import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService() : _db = FirebaseFirestore.instance;

  final FirebaseFirestore _db;

  Future<void> insert({
    required String collection,
    required String uid,
    required Map<String, dynamic> params,
  }) async {
    try {
      await _db.collection(collection).doc(uid).set(params);
    } catch (e) {
      log('FirestoreService - insert - Error: $e');
    }
  }

  Future<Map<String, dynamic>> get({
    required String collection,
    required String uid,
  }) async {
    try {
      final result = await _db.collection(collection).doc(uid).get();
      log('FirestoreService - get - result: ${result.data()}');
      return result.data() ?? {};
    } catch (e) {
      throw ('FirestoreService - insert - Error: $e');
    }
  }
}
