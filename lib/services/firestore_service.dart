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

  Future<void> update({
    required String collection,
    required String uid,
    required Map<String, dynamic> params,
  }) async {
    try {
      await _db
          .collection(collection)
          .doc(uid)
          .update(params);
    } catch (e) {
      log('FirestoreService - update - Error: $e'); // Mensagem de erro correta
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

  Future<List<Map<String, dynamic>>> getByField({
    required String collection,
    required String fieldName,
    required String value,
  }) async {
    try {
      final querySnapshot = await _db
          .collection(collection)
          .where(fieldName, isEqualTo: value)
          .get();

      final documents = querySnapshot.docs.map((doc) => doc.data()).toList();

      log('FirestoreService - getByField - documents: $documents');
      return documents;
    } catch (e) {
      log('FirestoreService - getByField - Error: $e');
      throw ('FirestoreService - getByField - Error: $e');
    }
  }
}
