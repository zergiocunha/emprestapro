import 'package:emprestapro/common/models/loan_model.dart';
import 'package:emprestapro/common/models/transaction_model.dart';
import 'package:emprestapro/features/transaction/transaction_state.dart';
import 'package:emprestapro/repositories/loan_repository.dart';
import 'package:emprestapro/repositories/transaction_repository.dart';
import 'package:flutter/material.dart';

class TransactionController extends ChangeNotifier {
  final TransactionRepository transactionRepository;
  final LoanRepository loanRepository;

  TransactionController({
    required this.transactionRepository,
    required this.loanRepository,
  });

  TransactionState _state = TransactionInitialState();
  TransactionState get state => _state;

  List<TransactionModel> transactionsList = [];

  void _changeState(TransactionState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> addTransaction({
    required TransactionModel newTransaction,
  }) async {
    _changeState(TransactionLoadingState());

    final result =
        await transactionRepository.insert(transactionModel: newTransaction);

    result.fold(
      (error) => _changeState(TransactionErrorState(message: error.message)),
      (transaction) {
        transactionsList.add(newTransaction);
        _changeState(TransactionSuccessState());
      },
    );
  }

  Future<void> updateLoan({
    required LoanModel loan,
  }) async {
    _changeState(TransactionLoadingState());

    final result = await loanRepository.update(loanModel: loan);

    result.fold(
      (error) => _changeState(TransactionErrorState(message: error.message)),
      (transaction) {
        _changeState(TransactionSuccessState());
      },
    );
  }

  Future<void> getTransactionsByLoan(LoanModel loan) async {
    _changeState(TransactionLoadingState());
    final result =
        await transactionRepository.get(fieldName: 'loanId', value: loan.uid!);

    result.fold(
        (error) => _changeState(TransactionErrorState(message: error.message)),
        (data) {
      transactionsList = data;
      _changeState(TransactionSuccessState());
    });
  }
}
