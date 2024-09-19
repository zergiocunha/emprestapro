import 'package:emprestapro/app.dart';
import 'package:emprestapro/firebase_options.dart';
import 'package:emprestapro/locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupDependencies();

  await locator.allReady();

  runApp(const App());
}
