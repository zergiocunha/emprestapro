import 'package:emprestapro/common/models/consumer_model.dart';
import 'package:emprestapro/common/models/creditor_model.dart';
import 'package:emprestapro/common/models/loan_model.dart';
import 'package:emprestapro/common/models/transaction_model.dart';
import 'package:emprestapro/common/models/user_model.dart';
import 'package:emprestapro/pages/home/home_state.dart';
import 'package:emprestapro/repositories/consumer_repository.dart';
import 'package:emprestapro/repositories/creditor_repository.dart';
import 'package:emprestapro/repositories/loan_repository.dart';
import 'package:emprestapro/repositories/transaction_repository.dart';
import 'package:emprestapro/services/secure_storage.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  HomeController({
    required SecureStorageService secureStorageService,
    required CreditorRepository creditorRepository,
    required LoanRepository loanRepository,
    required ConsumerRepository consumerRepository,
    required TransactionRepository transactionRepository,
  })  : _creditorRepository = creditorRepository,
        _secureStorageService = secureStorageService,
        _consumerRepository = consumerRepository,
        _transactionRepository = transactionRepository,
        _loanRepository = loanRepository;

  final CreditorRepository _creditorRepository;
  final LoanRepository _loanRepository;
  final SecureStorageService _secureStorageService;
  final ConsumerRepository _consumerRepository;
  final TransactionRepository _transactionRepository;

  HomeState _state = HomeInitialState();
  final ValueNotifier<bool> showFloatingButton = ValueNotifier<bool>(true);

  HomeState get state => _state;

  bool _filterOnlyOverdue = false;
  bool get filterOnlyOverdue => _filterOnlyOverdue;

  CreditorModel _creditorModel = CreditorModel();
  CreditorModel get creditorModel => _creditorModel;

  UserModel _userModel = UserModel();
  UserModel get userModel => _userModel;

  List<LoanModel> loans = List.empty(growable: true);

  List<ConsumerModel> consumers = List.empty(growable: true);

  List<TransactionModel> transactons = List.empty(growable: true);

  late PageController _pageController;
  PageController get pageController => _pageController;

  set setPageController(PageController newPageController) {
    _pageController = newPageController;
  }

  void setFilterOnlyOverdue(bool value) {
    _filterOnlyOverdue = value;
  }

  void _changeState(HomeState newState) {
    _state = newState;
    notifyListeners();
  }

  void jumpToLoansPage() {
    _pageController.jumpToPage(1);
  }

  void jumpToHomePage() {
    _pageController.jumpToPage(0);
  }

  void jumpToConsumersPage() {
    _pageController.jumpToPage(2);
  }

  void clearData() {
    consumers = [];
    loans = [];
    _userModel = UserModel();
    _creditorModel = CreditorModel();
  }

  Future<void> getUser() async {
    final data = await _secureStorageService.readOne(key: 'CURRENT_USER');
    _userModel = UserModel.fromJson(data ?? '');
  }

  Future<void> getCreditor() async {
    _changeState(HomeLoadingState());

    final result = await _creditorRepository.get(
        fieldName: 'userId', value: _userModel.uid!);

    result.fold((error) => _changeState(HomeErrorState(message: error.message)),
        (creditorModel) {
      _creditorModel = creditorModel;
      _changeState(HomeSuccessState());
    });
  }

  Future<void> getLoansByCreditor() async {
    _changeState(HomeLoadingState());
    final result = await _loanRepository.get(
        fieldName: 'creditorId', value: _creditorModel.uid!);

    result.fold((error) => _changeState(HomeErrorState(message: error.message)),
        (data) {
      loans = data;
      _changeState(HomeSuccessState());
    });
  }

  Future<void> getConsumersByCreditor() async {
    _changeState(HomeLoadingState());

    final result = await _consumerRepository.get(
      fieldName: 'creditorId',
      value: _creditorModel.uid!,
    );

    result.fold(
      (error) => _changeState(HomeErrorState(message: error.message)),
      (data) {
        consumers = data;
        _changeState(HomeSuccessState());
      },
    );
  }

  Future<void> getTransactionsByCreditor() async {
    _changeState(HomeLoadingState());

    final result = await _transactionRepository.get(
      fieldName: 'creditorId',
      value: _creditorModel.uid!,
    );

    result.fold(
      (error) {
        transactons = [];
        _changeState(HomeErrorState(message: error.message));
      },
      (data) {
        transactons = data;
        _changeState(HomeSuccessState());
      },
    );
  }
}
