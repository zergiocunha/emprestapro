import 'package:emprestapro/common/extensions/data_ext.dart';
import 'package:emprestapro/common/models/creditor_model.dart';
import 'package:emprestapro/common/models/user_model.dart';
import 'package:emprestapro/data/data.dart';
import 'package:emprestapro/pages/sign_in/sign_in_state.dart';
import 'package:emprestapro/repositories/creditor_repository.dart';
import 'package:emprestapro/repositories/user_repository.dart';
import 'package:emprestapro/services/auth_service.dart';
import 'package:emprestapro/services/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class SignInController extends ChangeNotifier {
  final AuthService _authService;
  final SecureStorageService secureStorage;
  final UserRepository _userReposiory;
  final CreditorRepository _creditorRepository;

  SignInController(
    this._authService,
    this.secureStorage,
    this._userReposiory,
    this._creditorRepository,
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

    final result = await _userReposiory.get(
      uid: userData.data!.uid!,
    );

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

  Future<void> signInWithGoogle() async {
    _changeState(SignInLoadingState());

    final user = await _authService.signInWithGoogle();

    DataResult<UserModel> loggedUserModelData = await _userReposiory.get(
      uid: user.data!.uid,
    );

    if (loggedUserModelData.data == null) {
      final userMap = user.data!.toMap();

      final newUserModel = UserModel.fromMap(
        map: userMap,
        displayName: user.data!.displayName,
      );

      _userReposiory.insert(
        uid: user.data!.uid,
        userModel: newUserModel,
      );

      final creditorModel = _createCreditorModel(newUserModel);

      _creditorRepository.insert(
        creditorModel: creditorModel,
      );

      loggedUserModelData = await _userReposiory.get(uid: user.data!.uid);
    }
    loggedUserModelData.fold(
      (error) => _changeState(SignInErrorState(error.message)),
      (data) async {
        await secureStorage.write(
          key: "CURRENT_USER",
          value: data.toJson(),
        );

        loggedUserModelData.fold(
          (error) => _changeState(SignInErrorState(error.message)),
          (_) => _changeState(SignInSuccessState()),
        );
      },
    );
  }

  CreditorModel _createCreditorModel(UserModel userModel) {
    return CreditorModel(
      uid: const Uuid().v1(),
      name: userModel.displayName,
      active: true,
      creationTime: userModel.creationTime,
      email: userModel.email,
      photoURL: userModel.photoURL,
      loanIds: [],
      phone: userModel.phoneNumber,
      updateTime: userModel.updateTime,
      userId: userModel.uid,
      calculate: false,
    );
  }
}
