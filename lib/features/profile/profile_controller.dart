import 'package:emprestapro/features/profile/profile_state.dart';
import 'package:emprestapro/services/auth_service.dart';
import 'package:emprestapro/services/secure_storage.dart';
import 'package:flutter/material.dart';

class ProfileController extends ChangeNotifier {
  final AuthService authService;
  final SecureStorageService secureStorage;

  ProfileController({
    required this.authService,
    required this.secureStorage,
  });
  // Variáveis de estado
  String userName = "Nome do Usuário"; // Nome do usuário atual
  String? profilePicture; // URL da foto de perfil

  ProfileState _state = ProfileInitialState();
  ProfileState get state => _state;

  void _changeState(ProfileState newState) {
    _state = newState;
    notifyListeners();
  }

  // Função para alterar a foto do perfil
  void changeProfilePicture() async {
    _changeState(ProfileLoadingState());
    // Lógica para alterar a foto de perfil
    // ...
    _changeState(ProfileSuccessState());
  }

  // Função para alterar o nome do usuário
  void changeName() async {
    _changeState(ProfileLoadingState());
    // Lógica para alterar o nome
    // ...
    _changeState(ProfileSuccessState());
  }

  // Função para alterar a senha do usuário
  void changePassword() async {
    _changeState(ProfileLoadingState());
    // Lógica para alterar a senha
    // ...
    _changeState(ProfileSuccessState());
  }

  // Função para mostrar os acordos
  void showAgreements() {
    _changeState(ProfileAgreementsState());
  }

  // Função para deletar a conta do usuário
  void deleteAccount() async {
    _changeState(ProfileLoadingState());
    // Lógica para deletar a conta
    // ...
    _changeState(ProfileSuccessState());
  }

  // Função para sair do aplicativo
  void logOut() async {
    _changeState(ProfileLoadingState());
    await authService.signOut();
    await secureStorage.deleteAll();
    _changeState(ProfileLoggedOutState());
  }
}
