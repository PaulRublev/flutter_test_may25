import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:malina_test_app/core/constants/app_colors.dart';
import 'package:malina_test_app/core/constants/app_text_styles.dart';

class MiniButton extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const MiniButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 60,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColors.greyBackground,
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(icon, width: 20, height: 20),
            Text(label, style: AppTextStyles.r10, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
