import 'package:emprestapro/app.dart';
import 'package:emprestapro/locator.dart';
import 'package:flutter/material.dart';

void main() async {
  setupDependencies();

  await locator.allReady();

  runApp(const App());
}
