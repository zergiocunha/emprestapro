import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class StorageService {
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
      return null;
    }
  }
}
