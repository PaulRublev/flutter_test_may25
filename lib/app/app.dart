import 'package:flutter/material.dart';
import 'package:malina_test_app/app/router.dart';
import 'package:malina_test_app/core/constants/app_colors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.scaffold,
        appBarTheme: const AppBarTheme(backgroundColor: AppColors.scaffold),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
