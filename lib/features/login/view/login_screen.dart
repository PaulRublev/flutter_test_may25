import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:malina_test_app/core/constants/app_router_constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Login Screen'),
            ElevatedButton(
              onPressed: () {
                context.go(AppRouterConstants.home);
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
