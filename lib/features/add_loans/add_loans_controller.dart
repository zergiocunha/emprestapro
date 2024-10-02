import 'package:emprestapro/features/add_loans/add_loans_state.dart';
import 'package:emprestapro/services/secure_storage.dart';
import 'package:flutter/material.dart';

class AddLoanController extends ChangeNotifier {
  AddLoanController({
    required SecureStorageService secureStorageService,
    // required LoansRepository loanRepository,
  });
  // _loanRepository = loanRepository,
  //       _secureStorageService = secureStorageService;

  // // final LoansRepository _loanRepository;
  // final SecureStorageService _secureStorageService;

  AddLoansState _state = AddLoansInitialState();
  AddLoansState get state => _state;

  // LoanModel _loanModel = LoanModel();
  // LoanModel get loanModel => _loanModel;

  void _changeState(AddLoansState newState) {
    _state = newState;
    notifyListeners();
  }

  // Future<void> addLoan({
  //   required double amount,
  //   required String dueDate,
  //   required String debtorName,
  //   required double interestRate,
  // }) async {
  //   _changeState(AddLoansLoadingState());

  //   try {
  //     final data = await _secureStorageService.readOne(key: 'CURRENT_USER');
  //     final user = UserModel.fromJson(data ?? '');

  //     final newLoan = LoanModel(
  //       amount: amount,
  //       dueDate: dueDate,
  //       debtorName: debtorName,
  //       interestRate: interestRate,
  //       userId: user.uid!,
  //     );

  //     final result = await _loanRepository.addLoan(newLoan);

  //     result.fold(
  //       (error) => _changeState(AddLoanErrorState(message: error.message)),
  //       (loanModel) {
  //         _loanModel = loanModel;
  //         _changeState(AddLoanSuccessState());
  //       },
  //     );
  //   } catch (e) {
  //     _changeState(AddLoanErrorState(message: e.toString()));
  //   }
  // }

  // void clearLoanData() {
  //   _loanModel = LoanModel();
  //   _changeState(AddLoansInitialState());
  // }
}
