import 'package:emprestapro/common/extensions/data_ext.dart';
import 'package:emprestapro/features/sign_in/sign_in_state.dart';
import 'package:emprestapro/repositories/user_repository.dart';
import 'package:emprestapro/services/auth_service.dart';
import 'package:emprestapro/services/secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInController extends ChangeNotifier {
  final AuthService _authService;
  final UserRepository _userRepository;
  final SecureStorageService secureStorage;

  SignInController(
    this._userRepository,
    this._authService,
    this.secureStorage,
  );

  late PageController _pageController;
  PageController get pageController => _pageController;

  SignInState _state = SignInInitialState();
  SignInState get state => _state;

  void _changeState(SignInState newState) {
    _state = newState;
    notifyListeners();
  }

  void jumpToLoansPage() {
    pageController.jumpToPage(0);
  }

  set setPageController(PageController newPageController) {
    _pageController = newPageController;
  }

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    _changeState(SignInLoadingState());

    try {
      User user = await _authService.signIn(
        email,
        password,
      );

      await _userRepository.get(
        uid: user.uid,
      );

      await secureStorage.write(
        key: "CURRENT_USER",
        value: user.toMap().toString(),
      );

      _changeState(SignInSuccessState());
      return true;
    } catch (e) {
      _changeState(SignInErrorState(e.toString()));
      return false;
    }
  }
}
