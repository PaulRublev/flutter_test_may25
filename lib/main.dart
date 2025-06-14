import 'package:flutter/material.dart';
import 'package:malina_test_app/app/app.dart';
import 'package:malina_test_app/core/di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  runApp(const App());
}
