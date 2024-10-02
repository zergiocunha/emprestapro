import 'package:emprestapro/features/sign_in/sign_in_state.dart';
import 'package:emprestapro/repositories/user_repository.dart';
import 'package:emprestapro/services/auth_service.dart';
import 'package:emprestapro/services/secure_storage.dart';
import 'package:flutter/material.dart';

class SignInController extends ChangeNotifier {
  final AuthService _authService;
  final SecureStorageService secureStorage;
  final UserRepository _userReposiory;


  SignInController(
    this._authService,
    this.secureStorage, this._userReposiory,
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

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    _changeState(SignInLoadingState());

    final userData = await _authService.signIn(
      email,
      password,
    );

    final result = await _userReposiory.get(uid: userData.data!.uid!);

    result.fold(
      (error) => _changeState(SignInErrorState(error.message)),
      (data) async {
        
        await secureStorage.write(
          key: "CURRENT_USER",
          value: data.toJson(),
        );

        result.fold(
          (error) => _changeState(SignInErrorState(error.message)),
          (_) => _changeState(SignInSuccessState()),
        );
      },
    );
  }
}
