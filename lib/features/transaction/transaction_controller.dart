import 'package:emprestapro/common/models/creditor_model.dart';
import 'package:emprestapro/common/models/transaction_model.dart';
import 'package:emprestapro/common/models/user_model.dart';
import 'package:emprestapro/features/transaction/transaction_state.dart';
import 'package:emprestapro/repositories/creditor_repository.dart';
import 'package:emprestapro/repositories/transaction_repository.dart';
import 'package:emprestapro/services/secure_storage.dart';
import 'package:flutter/material.dart';

class TransactionController extends ChangeNotifier {
  final TransactionRepository transactionRepository;
  final CreditorRepository creditorRepository;
  final SecureStorageService secureStorageService;

  TransactionController({
    required this.transactionRepository,
    required this.creditorRepository,
    required this.secureStorageService,
  });

  TransactionState _state = TransactionInitialState();
  TransactionState get state => _state;

  List<TransactionModel> transactionsList = [];

  UserModel _userModel = UserModel();
  UserModel get userModel => _userModel;

  CreditorModel _creditorModel = CreditorModel();
  CreditorModel get creditorModel => _creditorModel;


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

  Future<void> getUserData() async {
    final data = await secureStorageService.readOne(key: 'CURRENT_USER');
    _userModel = UserModel.fromJson(data ?? '');
  }

  Future<void> getCreditorData() async {
    _changeState(TransactionLoadingState());

    final result = await creditorRepository.get(
      fieldName: 'userId',
      value: _userModel.uid!,
    );

    result.fold(
        (error) => _changeState(TransactionErrorState(message: error.message)),
        (creditorModel) {
      _creditorModel = creditorModel;
      _changeState(TransactionSuccessState());
    });
  }
}
