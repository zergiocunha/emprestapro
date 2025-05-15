import 'package:emprestapro/common/models/creditor_model.dart';
import 'package:emprestapro/common/models/user_model.dart';
import 'package:emprestapro/repositories/creditor_repository.dart';
import 'package:workmanager/workmanager.dart';
import '../repositories/loan_repository.dart';
import 'notification_service.dart';
import 'secure_storage.dart';

class LoanCheckService {
  static const taskName = 'checkOverdueLoans';
  final LoanRepository _loanRepository;
  static LoanRepository? __loanRepositoryInstance;
  final SecureStorageService _secureStorageService;
  final CreditorRepository _creditorRepository;

  LoanCheckService(
    this._loanRepository,
    this._secureStorageService,
    this._creditorRepository,
  ) {
    __loanRepositoryInstance = _loanRepository;
  }

  CreditorModel creditorModel = CreditorModel();

  UserModel _userModel = UserModel();
  UserModel get userModel => _userModel;

  Future<void> getCreditor() async {
    final data = await _secureStorageService.readOne(key: 'CURRENT_USER');
    _userModel = UserModel.fromJson(data ?? '');
    final creditor = await _creditorRepository.get(
      fieldName: 'userId',
      value: _userModel.uid!,
    );

    if (creditor.data != null) {
      creditorModel = creditor.data!;
    } else {
      throw Exception('Credor não encontrado');
    }
  }

  Future<void> initialize() async {
    await Workmanager().initialize(callbackDispatcher);
    await scheduleDailyCheck();
  }

  Future<void> scheduleDailyCheck() async {
    await getCreditor();

    await Workmanager().registerPeriodicTask(
      taskName,
      taskName,
      frequency: const Duration(days: 1),
      initialDelay: _getInitialDelay(),
      inputData: {
        'creditorId': creditorModel.uid,
        'userId': userModel.uid,
      },
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
  }

  static Duration _getInitialDelay() {
    final now = DateTime.now();
    final scheduledTime = DateTime(
      now.year,
      now.month,
      now.day,
      23,
      35,
    );

    if (now.isAfter(scheduledTime)) {
      return scheduledTime.add(const Duration(days: 1)).difference(now);
    }

    return scheduledTime.difference(now);
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    try {
      if (taskName == LoanCheckService.taskName) {
        if (LoanCheckService.__loanRepositoryInstance == null ||
            inputData == null) {
          return false;
        }

        final creditorId = inputData['creditorId'] as String;

        final overdueLoans =
            await LoanCheckService.__loanRepositoryInstance!.getOverduLoans(
          creditorId: creditorId,
        );

        if (overdueLoans.data != null && overdueLoans.data!.isNotEmpty) {
          await NotificationService().showNotification(
            title: 'Empréstimos Vencidos',
            body:
                'Você tem ${overdueLoans.data!.length} empréstimo(s) vencido(s).',
          );
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  });
}
