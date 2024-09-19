import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService() : _db = FirebaseFirestore.instance;

  final FirebaseFirestore _db;

  Future<void> insertUser({
    required String uid,
    Map<String, dynamic> params = const {},
  }) async {
    try {
      await _db.collection('users').doc(uid).set(params);

    } catch (e) {
      log('Erro ao registrar usuário: $e');
    }
  }
}
