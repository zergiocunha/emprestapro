import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addUser(String id, Map<String, dynamic> userData) async {
    try {
      await _db.collection('users').doc(id).set(userData);
    } catch (e) {
      print('Error adding user: $e');
    }
  }

  Future<Map<String, dynamic>?> getUser(String id) async {
    try {
      DocumentSnapshot doc = await _db.collection('users').doc(id).get();
      return doc.data() as Map<String, dynamic>?;
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }
}
