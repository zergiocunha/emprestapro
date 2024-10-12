import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadFile(String path, File file) async {
    try {
      final ref = _storage.ref().child(path);
      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Erro ao fazer upload do arquivo: $e');
      return null;
    }
  }

  Future<File?> downloadFile(String path, String fileName) async {
    try {
      final ref = _storage.ref().child(path);
      final dir = Directory.systemTemp;
      final file = File('${dir.path}/$fileName');
      await ref.writeToFile(file);
      return file;
    } catch (e) {
      print('Erro ao fazer download do arquivo: $e');
      return null;
    }
  }

  Future<String?> updateFile(String path, File newFile) async {
    try {
      final ref = _storage.ref().child(path);

      try {
        await ref.getDownloadURL();
      } catch (e) {
        print('Arquivo não existe. Criando novo arquivo.');
      }

      // Faz o upload do novo arquivo
      final uploadTask = ref.putFile(newFile);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Erro ao atualizar o arquivo: $e');
      return null;
    }
  }

  Future<UploadTask> up(String path) async {
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

  Future<String?> upload(String path) async {
    try {
      UploadTask task = await up(path);
      TaskSnapshot snapshot = await task;

      if (snapshot.state == TaskState.success) {
        final photoRef = snapshot.ref;

        final newMetadata = SettableMetadata(
          cacheControl: "public, max-age=300",
          contentType: "image/jpeg",
        );
        await photoRef.updateMetadata(newMetadata);

        return await photoRef.getDownloadURL();
      } else {
        throw Exception('Upload falhou: ${snapshot.state}');
      }
    } catch (e) {
      print('Erro ao fazer upload e obter URL: $e');
      return null;
    }
  }
}
