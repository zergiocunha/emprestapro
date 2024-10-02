import 'package:emprestapro/common/models/creditor_model.dart';
import 'package:emprestapro/common/models/user_model.dart';
import 'package:emprestapro/features/home/home_state.dart';
import 'package:emprestapro/repositories/creditor_repository.dart';
import 'package:emprestapro/services/secure_storage.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  HomeController({
    required SecureStorageService secureStorageService,
    required CreditorRepository creditorRepository,
  })  : _creditorRepository = creditorRepository,
        _secureStorageService = secureStorageService;

  final CreditorRepository _creditorRepository;
  final SecureStorageService _secureStorageService;

  HomeState _state = HomeInitialState();
  final ValueNotifier<bool> showFloatingButton = ValueNotifier<bool>(true);

  HomeState get state => _state;

  CreditorModel _creditorModel = CreditorModel();
  CreditorModel get creditorModel => _creditorModel;

  late PageController _pageController;
  PageController get pageController => _pageController;

  set setPageController(PageController newPageController) {
    _pageController = newPageController;
  }

  void _changeState(HomeState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> getCreditor() async {
    _changeState(HomeLoadingState());
    final data = await _secureStorageService.readOne(key: 'CURRENT_USER');
    final user = UserModel.fromJson(data ?? '');

    final result = await _creditorRepository.getByField(
        fieldName: 'userId', value: user.uid!);

    result.fold((error) => _changeState(HomeErrorState(message: error.message)),
        (creditorModel) {
          _creditorModel = creditorModel;
      _changeState(HomeSuccessState());
    });
  }
}
