import 'package:emprestapro/common/extensions/data_ext.dart';
import 'package:emprestapro/common/models/user_model.dart';
import 'package:emprestapro/features/sign_up/sign_up_state.dart';
import 'package:emprestapro/services/auth_service.dart';
import 'package:emprestapro/services/firestore_service.dart';
import 'package:emprestapro/services/secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpController extends ChangeNotifier {
  final AuthService _authService;
  final FirestoreService _firestoreService;
  final SecureStorageService secureStorage;

  SignUpController(
    this._firestoreService,
    this._authService,
    this.secureStorage,
  );

  late PageController _pageController;
  PageController get pageController => _pageController;

  SignUpState _state = SignUpInitialState();
  SignUpState get state => _state;

  void _changeState(SignUpState newState) {
    _state = newState;
    notifyListeners();
  }

  void jumpToLoansPage() {
    pageController.jumpToPage(0);
  }

  set setPageController(PageController newPageController) {
    _pageController = newPageController;
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    _changeState(SignUpLoadingState());

    try {
      User user = await _authService.signUpWithEmailPassword(
        name,
        email,
        password,
      );

      final userMap = user.toMap();

      final userModel = UserModel.fromMap(userMap, name);

      _firestoreService.insertUser(
        uid: user.uid,
        params: userModel.toMap(),
      );

      await secureStorage.write(
        key: "CURRENT_USER",
        value: user.toMap().toString(),
      );

      _changeState(SignUpSuccessState());
    } catch (e) {
      _changeState(SignUpErrorState(e.toString()));
    }
  }
}
