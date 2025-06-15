import 'package:flutter/material.dart';
import 'package:malina_test_app/core/constants/app_colors.dart';

class MalinaButton extends StatelessWidget {
  const MalinaButton({super.key, required this.child, this.onPressed});

  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(AppColors.malina),
        foregroundColor: WidgetStateProperty.all<Color>(AppColors.white),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
