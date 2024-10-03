import 'package:emprestapro/common/models/creditor_model.dart';
import 'package:emprestapro/common/models/loan_model.dart';
import 'package:emprestapro/common/models/user_model.dart';
import 'package:emprestapro/features/loan/loan_state.dart';
import 'package:emprestapro/repositories/creditor_repository.dart';
import 'package:emprestapro/repositories/loan_repository.dart';
import 'package:emprestapro/services/secure_storage.dart';
import 'package:flutter/material.dart';

class AddLoanController extends ChangeNotifier {
  final LoanRepository loanRepository;
  final CreditorRepository creditorRepository;
  final SecureStorageService secureStorageService;

  AddLoanController({
    required this.loanRepository,
    required this.secureStorageService,
    required this.creditorRepository,
  });

  AddLoansState _state = AddLoansInitialState();
  AddLoansState get state => _state;

  UserModel _userModel = UserModel();
  UserModel get userModel => _userModel;

  CreditorModel _creditorModel = CreditorModel();
  CreditorModel get creditorModel => _creditorModel;

  void _changeState(AddLoansState newState) {
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
}
