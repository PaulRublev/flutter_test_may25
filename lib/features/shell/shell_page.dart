import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:malina_test_app/core/constants/app_colors.dart';
import 'package:malina_test_app/core/constants/app_router_constants.dart';

class ShellPage extends StatelessWidget {
  final Widget child;
  const ShellPage({super.key, required this.child});

  static const _tabs = [
    AppRouterConstants.home,
    AppRouterConstants.favorites,
    AppRouterConstants.profile,
    AppRouterConstants.cart,
  ];

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).fullPath ?? '';
    final bool isHomeRoot = location == AppRouterConstants.home;
    final int currentIndex =
        location.isEmpty
            ? 0
            : _tabs.indexWhere((path) => location.startsWith(path));

    return Scaffold(
      body: child,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(5, (index) {
              if (index == 2) {
                return GestureDetector(
                  onTap: () {
                    if (isHomeRoot) {
                      context.push('/qr');
                    } else {
                      if (Navigator.of(context).canPop()) {
                        context.pop();
                      } else {
                        context.go(AppRouterConstants.home);
                      }
                    }
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.malina,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.malina.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      isHomeRoot ? Icons.qr_code : Icons.close,
                      color: Colors.white,
                    ),
                  ),
                );
              }

              final itemIndex = index > 2 ? index - 1 : index;
              final iconData =
                  [
                    Icons.home,
                    Icons.favorite,
                    Icons.person,
                    Icons.shopping_cart,
                  ][itemIndex];
              final label = ['Home', 'Favorites', 'Profile', 'Cart'][itemIndex];
              final route = _tabs[itemIndex];

              final isSelected = currentIndex == itemIndex;

              return GestureDetector(
                onTap: () => context.go(route),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        iconData,
                        color:
                            isSelected
                                ? AppColors.malina
                                : AppColors.unselected,
                      ),
                      Text(
                        label,
                        style: TextStyle(
                          color:
                              isSelected
                                  ? AppColors.malina
                                  : AppColors.unselected,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
