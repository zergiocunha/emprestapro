import 'dart:io';
import 'package:emprestapro/features/profile/profile_state.dart';
import 'package:emprestapro/services/auth_service.dart';
import 'package:emprestapro/services/firestore_service.dart';
import 'package:emprestapro/services/secure_storage.dart';
import 'package:emprestapro/services/storage_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends ChangeNotifier {
  final AuthService authService;
  final SecureStorageService secureStorage;
  final StorageService storageService;
  final FirestoreService firestoreService;

  ProfileController({
    required this.authService,
    required this.secureStorage,
    required this.storageService,
    required this.firestoreService,
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

  Future<XFile?> getImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<UploadTask> upload(String path) async {
    File file = File(path);
    try {
      String ref = 'images/img-${DateTime.now().toString()}.jpeg';
      final storageRef = FirebaseStorage.instance.ref();
      return storageRef.child(ref).putFile(
            file,
            SettableMetadata(
              cacheControl: "public, max-age=300",
              contentType: "image/jpeg",
              customMetadata: {
                "user": "123",
              },
            ),
          );
    } on FirebaseException catch (e) {
      throw Exception('Erro no upload: ${e.code}');
    }
  }

  pickAndUploadImage(String uid) async {
    XFile? file = await getImage();
    if (file != null) {
      final imageUrl = await storageService.upload(file.path);
      firestoreService.update(
        collection: 'creditors',
        uid: uid,
        params: {'imageUrl': imageUrl},
      );

      firestoreService.update(
        collection: 'users',
        uid: uid,
        params: {'photoUrl': imageUrl},
      );
    }
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
  Future<void> logOut() async {
    _changeState(ProfileLoadingState());
    await secureStorage.deleteAll();
    await authService.signOut();
    _changeState(ProfileLoggedOutState());
  }
}
