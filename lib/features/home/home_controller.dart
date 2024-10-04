import 'package:emprestapro/common/models/creditor_model.dart';
import 'package:emprestapro/common/models/loan_model.dart';
import 'package:emprestapro/common/models/user_model.dart';
import 'package:emprestapro/features/home/home_state.dart';
import 'package:emprestapro/repositories/creditor_repository.dart';
import 'package:emprestapro/repositories/loan_repository.dart';
import 'package:emprestapro/services/secure_storage.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  HomeController({
    required SecureStorageService secureStorageService,
    required CreditorRepository creditorRepository,
    required LoanRepository loanRepository,
  })  : _creditorRepository = creditorRepository,
        _secureStorageService = secureStorageService,
        _loanRepository = loanRepository;

  final CreditorRepository _creditorRepository;
  final LoanRepository _loanRepository;
  final SecureStorageService _secureStorageService;

  HomeState _state = HomeInitialState();
  final ValueNotifier<bool> showFloatingButton = ValueNotifier<bool>(true);

  HomeState get state => _state;

  CreditorModel _creditorModel = CreditorModel();
  CreditorModel get creditorModel => _creditorModel;

  UserModel _userModel = UserModel();
  UserModel get userModel => _userModel;

  List<LoanModel> loans = List.empty(growable: true);

  late PageController _pageController;
  PageController get pageController => _pageController;

  set setPageController(PageController newPageController) {
    _pageController = newPageController;
  }

  void _changeState(HomeState newState) {
    _state = newState;
    notifyListeners();
  }

  void jumpToLoansPage() {
    _pageController.jumpToPage(1);
  }


  Future<void> getUser() async {
    final data = await _secureStorageService.readOne(key: 'CURRENT_USER');
    _userModel = UserModel.fromJson(data ?? '');
  }

  Future<void> getCreditor() async {
    _changeState(HomeLoadingState());

    final result =
        await _creditorRepository.get(fieldName: 'userId', value: _userModel.uid!);

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
}
