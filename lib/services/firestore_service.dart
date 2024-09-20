import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emprestapro/common/models/user_model.dart';

class FirestoreService {
  FirestoreService() : _db = FirebaseFirestore.instance;

  final FirebaseFirestore _db;

  Future<void> insertUser({
    required String uid,
    required UserModel userModel,
  }) async {
    try {
      await _db.collection('users').doc(uid).set(userModel.toMap());
    } catch (e) {
      log('FirestoreService - insertUser - Error: $e');
    }
  }

  Future<UserModel> getUser({
    required String uid,
  }) async {
    try {
      final result = await _db.collection('users').doc(uid).get();
      if (result.exists) {
        log('FirestoreService - getUser - result: ${result.data()}');
        return UserModel.fromMap(
          map: result.data()!,
          displayName: result.data()!['displayName'],
        );
      }
      return UserModel();
    } catch (e) {
      throw ('FirestoreService - insertUser - Error: $e');
    }
  }
}
