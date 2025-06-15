import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:malina_test_app/core/constants/app_colors.dart';
import 'package:malina_test_app/core/constants/app_icons.dart';
import 'package:malina_test_app/core/constants/app_images.dart';
import 'package:malina_test_app/core/constants/app_text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(0, 12, 0, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 4,
                        offset: Offset(0, 2), // Смещение по Y
                      ),
                    ],
                  ),

                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Искать в Malina',
                      hintStyle: AppTextStyles.r14.copyWith(
                        color: AppColors.unselected,
                      ),
                      prefixIcon: SvgPicture.asset(AppIcons.search),
                      prefixIconConstraints: BoxConstraints(
                        minWidth: 40,
                        minHeight: 40,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 11,
                    horizontal: 24,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.malina,
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Row(
                    children: [
                      SvgPicture.asset(AppIcons.scan, height: 68),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'Сканируй QR-код и заказывай прямо в заведении',
                          style: AppTextStyles.m16.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Container(
                  height: 170,
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.symmetric(
                    vertical: 17,
                    horizontal: 23,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(AppImages.food),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Еда',
                        style: AppTextStyles.s22.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                      Text(
                        'Из кафе и\nресторанов',
                        style: AppTextStyles.l16.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Container(
                  height: 170,
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.symmetric(
                    vertical: 17,
                    horizontal: 23,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFDEDD),
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(AppImages.beauty),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Бьюти',
                        style: AppTextStyles.s22.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                      Text(
                        'Салоны красоты\nи товары',
                        style: AppTextStyles.l16.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                child: Text(
                  'Скоро в Malina',
                  style: AppTextStyles.m17.copyWith(color: AppColors.black),
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                child: Builder(
                  builder: (context) {
                    final list = List<(String, Color)>.from([
                      ('Вакансии', Color(0xFFD4E5FF)),
                      ('Маркет', Color(0xFFFFD3BA)),
                      ('Цветы', Color(0xFFFFDEDE)),
                      ('Спорт', Color(0xFFCFF2E3)),
                      ('Маркет', Color(0xFFBDE1D1)),
                      ('', Color(0xFF7BB9C3)),
                    ]);

                    return Row(
                      spacing: 10,
                      children: List.generate(
                        6,
                        (index) => Container(
                          height: 86,
                          width: 86,
                          decoration: BoxDecoration(
                            color: list[index].$2,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              list[index].$1,
                              style: AppTextStyles.r12.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
