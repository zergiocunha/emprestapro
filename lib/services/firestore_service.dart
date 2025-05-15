import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

enum FilterOperator {
  isEqualTo,
  isLessThanOrEqualTo,
  isGreaterThan,
  // ... outros operadores conforme necessário
}

class FilterCondition {
  final dynamic value;
  final FilterOperator operator;

  const FilterCondition(this.value, this.operator);
}

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
      await _db.collection(collection).doc(uid).update(params);
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

  Future<void> delete({
    required String collection,
    required String uid,
  }) async {
    try {
      await _db.collection(collection).doc(uid).delete();
      log('FirestoreService - get - result: deleted');
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

  Future<List<Map<String, dynamic>>> getByFilter({
    required String collection,
    Map<String, FilterCondition>? filters,
  }) async {
    try {
      Query query = _db.collection(collection);

      if (filters != null) {
        filters.forEach((field, condition) {
          switch (condition.operator) {
            case FilterOperator.isEqualTo:
              query = query.where(field, isEqualTo: condition.value);
              break;
            case FilterOperator.isLessThanOrEqualTo:
              query = query.where(field, isLessThanOrEqualTo: condition.value);
              break;
            case FilterOperator.isGreaterThan:
              query = query.where(field, isGreaterThan: condition.value);
              break;
          }
        });
      }

      final querySnapshot = await query.get();
      final documents = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .where((data) => data.isNotEmpty)
          .toList();

      return documents;
    } catch (e) {
      log('FirestoreService - getByFilter - Error: $e');
      throw ('FirestoreService - getByFilter - Error: $e');
    }
  }

  Future<List<Map<String, dynamic>>> deleteByField({
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

      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }

      log('FirestoreService - deleteByField - documents: $documents');
      return documents;
    } catch (e) {
      log('FirestoreService - deleteByField - Error: $e');
      throw ('FirestoreService - deleteByField - Error: $e');
    }
  }
}
