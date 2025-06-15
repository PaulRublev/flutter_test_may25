import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:malina_test_app/core/constants/app_colors.dart';
import 'package:malina_test_app/core/constants/app_icons.dart';
import 'package:malina_test_app/core/constants/app_router_constants.dart';
import 'package:malina_test_app/core/enums/categories.dart';
import 'package:malina_test_app/features/shell/widgets/mini_button.dart';

final GlobalKey _cartKey = GlobalKey();

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

    return BackHandling(
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        body: child,
        bottomNavigationBar: Container(
          height: 80,
          margin: const EdgeInsets.only(top: 6),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.15),
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
                    alignment: Alignment.center,
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
                    child: SvgPicture.asset(
                      isHomeRoot ? AppIcons.main : AppIcons.mainBack,
                    ),
                  ),
                );
              }

              final itemIndex = index > 2 ? index - 1 : index;
              final iconData =
                  [
                    AppIcons.home,
                    AppIcons.favorite,
                    AppIcons.profile,
                    AppIcons.cart,
                  ][itemIndex];
              final label =
                  ['Лента', 'Избранное', 'Профиль', 'Корзина'][itemIndex];
              final route = _tabs[itemIndex];

              final isSelected = currentIndex == itemIndex;

              return GestureDetector(
                onTap: () {
                  if (itemIndex == 3) {
                    if (isSelected) return;
                    final overlay = Overlay.of(context);
                    final renderBox =
                        _cartKey.currentContext!.findRenderObject()
                            as RenderBox;
                    final offset = renderBox.localToGlobal(Offset.zero);
                    final size = renderBox.size;

                    late OverlayEntry entry;

                    entry = OverlayEntry(
                      builder: (context) {
                        return GestureDetector(
                          onTap: () => entry.remove(),
                          behavior: HitTestBehavior.opaque,
                          child: Stack(
                            children: [
                              Positioned(
                                left: offset.dx + size.width / 2 - 35,
                                top: offset.dy - 145,
                                child: Material(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(50),
                                  ),
                                  color: Colors.white,
                                  child: Container(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(50),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        MiniButton(
                                          icon: AppIcons.foodIcon,
                                          label: Categories.food.title,
                                          onTap: () {
                                            entry.remove();
                                            context.go(
                                              '${AppRouterConstants.cart}?category=food',
                                            );
                                          },
                                        ),
                                        MiniButton(
                                          icon: AppIcons.beautyIcon,
                                          label: Categories.beauty.title,
                                          onTap: () {
                                            entry.remove();
                                            context.go(
                                              '${AppRouterConstants.cart}?category=beauty',
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );

                    overlay.insert(entry);
                  } else {
                    context.go(route);
                  }
                },
                behavior: HitTestBehavior.opaque,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Container(
                      key: itemIndex == 3 ? _cartKey : null,
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            iconData,
                            colorFilter: ColorFilter.mode(
                              isSelected
                                  ? AppColors.malina
                                  : AppColors.unselected,
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 6,
                      child: Center(
                        child: Text(
                          label,
                          maxLines: 1,
                          style: TextStyle(
                            color:
                                isSelected
                                    ? AppColors.malina
                                    : AppColors.unselected,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class BackHandling extends StatefulWidget {
  const BackHandling({super.key, required this.child});

  final Widget child;

  @override
  State<BackHandling> createState() => _MyScreenWithBackHandlingState();
}

class _MyScreenWithBackHandlingState extends State<BackHandling>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<bool> didPopRoute() async {
    final String location = GoRouterState.of(context).fullPath ?? '';
    final bool isHomeRoot = location == AppRouterConstants.home;
    final bool isOtherRoot =
        location == AppRouterConstants.cart ||
        location == AppRouterConstants.profile ||
        location == AppRouterConstants.favorites;

    log(location);
    if (isHomeRoot) {
      return true;
    } else if (isOtherRoot) {
      context.go(AppRouterConstants.home);
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
