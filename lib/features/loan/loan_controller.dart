import 'package:emprestapro/common/models/consumer_model.dart';
import 'package:emprestapro/common/models/creditor_model.dart';
import 'package:emprestapro/common/models/loan_model.dart';
import 'package:emprestapro/common/models/user_model.dart';
import 'package:emprestapro/features/home/home_controller.dart';
import 'package:emprestapro/features/loan/loan_state.dart';
import 'package:emprestapro/repositories/consumer_repository.dart';
import 'package:emprestapro/repositories/creditor_repository.dart';
import 'package:emprestapro/repositories/loan_repository.dart';
import 'package:emprestapro/services/secure_storage.dart';
import 'package:emprestapro/services/whatsapp_service.dart';
import 'package:flutter/material.dart';

class LoanController extends ChangeNotifier {
  final LoanRepository loanRepository;
  final CreditorRepository creditorRepository;
  final ConsumerRepository consumerRepository;
  final SecureStorageService secureStorageService;
  final WhatsAppService whatsAppService;
  final HomeController homeController;

  LoanController({
    required this.loanRepository,
    required this.consumerRepository,
    required this.secureStorageService,
    required this.homeController,
    required this.whatsAppService,
    required this.creditorRepository,
  });

  LoanState _state = LoanInitialState();
  LoanState get state => _state;

  UserModel _userModel = UserModel();
  UserModel get userModel => _userModel;

  CreditorModel _creditorModel = CreditorModel();
  CreditorModel get creditorModel => _creditorModel;

  List<ConsumerModel> _consumersList = [];
  List<ConsumerModel> get consumersList => _consumersList;

  void _changeState(LoanState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> addLoan({
    required LoanModel newLoan,
  }) async {
    _changeState(AddLoansLoadingState());

    final result = await loanRepository.insert(loanModel: newLoan);

    result.fold(
      (error) => _changeState(AddLoansErrorState(message: error.message)),
      (data) {
        _changeState(AddLoansSuccessState());
      },
    );
  }

  Future<void> getUserData() async {
    final data = await secureStorageService.readOne(key: 'CURRENT_USER');
    _userModel = UserModel.fromJson(data ?? '');
  }

  Future<void> getCreditorData() async {
    _changeState(AddLoansLoadingState());

    final result = await creditorRepository.get(
      fieldName: 'userId',
      value: _userModel.uid!,
    );

    result.fold(
        (error) => _changeState(AddLoansErrorState(message: error.message)),
        (creditorModel) {
      _creditorModel = creditorModel;
      _changeState(AddLoansSuccessState());
    });
  }

  Future<void> getConsumerList() async {
    _changeState(AddLoansLoadingState());

    final result = await consumerRepository.get(
      fieldName: 'creditorId',
      value: homeController.creditorModel.uid!,
    );

    result.fold(
        (error) => _changeState(AddLoansErrorState(message: error.message)),
        (data) {
      _consumersList = data;
      _changeState(AddLoansSuccessState());
    });
  }

  Future<void> sendMessage({
    required String phoneNumber,
    required String message,
  }) async {
    _changeState(AddLoansLoadingState());

    await whatsAppService.sendWhatsAppMessage(
      toPhoneNumber: '5511964549801',
      contentSid: 'HXb5b62575e6e4ff6129ad7c8efe1f983e',
      contentVariables: {
        '1': '12/1',
        '2': '3pm',
      },
    );

    // if (result == 'success') {
    //   _changeState(AddLoansSuccessState());
    // } else {
    //   _changeState(AddLoansErrorState(message: result));
    // }
  }
}
