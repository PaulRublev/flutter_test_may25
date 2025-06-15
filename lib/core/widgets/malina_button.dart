import 'package:flutter/material.dart';
import 'package:malina_test_app/core/constants/app_colors.dart';

class MalinaButton extends StatelessWidget {
  const MalinaButton({
    super.key,
    required this.child,
    this.onPressed,
    this.isSelected = true,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: WidgetStateProperty.all<double>(0),
        shape:
            isSelected
                ? null
                : WidgetStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                    side: const BorderSide(color: Color(0xFFEDEBEB)),
                  ),
                ),
        backgroundColor: WidgetStateProperty.all<Color>(
          isSelected ? AppColors.malina : AppColors.white,
        ),
        foregroundColor: WidgetStateProperty.all<Color>(
          isSelected ? AppColors.white : AppColors.black,
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
