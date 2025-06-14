import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    final int currentIndex =
        location.isEmpty
            ? 0
            : _tabs.indexWhere((path) => location.startsWith(path));

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          context.go(_tabs[index]);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
