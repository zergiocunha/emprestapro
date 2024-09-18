import 'package:emprestapro/services/firestore_service.dart';
import 'package:flutter/material.dart';

//TODO: REMOVER
class MyHomePage extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();

  MyHomePage({super.key});

  Future<void> _addUser() async {
    await _firestoreService.addUser('userId123', {
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'phone': '123-456-7890',
      // Adicione outros campos conforme necessário
    });
  }

  Future<void> _getUser() async {
    Map<String, dynamic>? userData = await _firestoreService.getUser('userId123');
    print(userData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Firebase Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _addUser,
              child: Text('Add User'),
            ),
            ElevatedButton(
              onPressed: _getUser,
              child: Text('Get User'),
            ),
          ],
        ),
      ),
    );
  }
}