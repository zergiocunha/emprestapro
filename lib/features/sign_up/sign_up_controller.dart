import 'package:emprestapro/common/extensions/data_ext.dart';
import 'package:emprestapro/common/models/creditor_model.dart';
import 'package:emprestapro/common/models/user_model.dart';
import 'package:emprestapro/features/sign_up/sign_up_state.dart';
import 'package:emprestapro/repositories/creditor_repository.dart';
import 'package:emprestapro/repositories/user_repository.dart';
import 'package:emprestapro/services/auth_service.dart';
import 'package:emprestapro/services/secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class SignUpController extends ChangeNotifier {
  final AuthService _authService;
  final UserRepository _userRepository;
  final CreditorRepository _creditorRepository;
  final SecureStorageService secureStorage;

  SignUpController(
    this._userRepository,
    this._creditorRepository,
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

  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    _changeState(SignUpLoadingState());

    try {
      User user = await _authService.signUp(
        email,
        password,
      );

      final userMap = user.toMap();

      final userModel = UserModel.fromMap(
        map: userMap,
        displayName: name,
      );

      _userRepository.insert(
        uid: user.uid,
        userModel: userModel,
      );

      final creditorModel = _createCreditorModel(userModel);

      _creditorRepository.insert(
        creditorModel: creditorModel,
      );

      await secureStorage.write(
        key: "CURRENT_USER",
        value: user.toMap().toString(),
      );

      _changeState(SignUpSuccessState());
      return true;
    } catch (e) {
      _changeState(SignUpErrorState(e.toString()));
      return false;
    }
  }

  CreditorModel _createCreditorModel(UserModel userModel){
    return CreditorModel(
      uid: const Uuid().v1(),
      name: userModel.displayName,
      active: true,
      creationTime: userModel.creationTime,
      email: userModel.email,
      imageUrl: userModel.photoUrl,
      loanIds: [],
      phone: userModel.phoneNumber,
      updateTime: userModel.updateTime,
      userId: userModel.uid,
    );
  }
}
