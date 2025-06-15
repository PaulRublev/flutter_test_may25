import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:malina_test_app/core/constants/app_router_constants.dart';
import 'package:malina_test_app/core/enums/categories.dart';
import 'package:malina_test_app/features/cart/cubit/current_category_cubit.dart';
import 'package:malina_test_app/features/cart/view/cart_screen.dart';
import 'package:malina_test_app/features/favorites/view/favorites_screen.dart';
import 'package:malina_test_app/features/home/view/home_screen.dart';
import 'package:malina_test_app/features/login/view/login_screen.dart';
import 'package:malina_test_app/features/profile/view/profile_screen.dart';
import 'package:malina_test_app/features/qr/view/qr_page.dart';
import 'package:malina_test_app/features/shell/shell_page.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRouterConstants.login,
  routes: [
    GoRoute(
      path: AppRouterConstants.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRouterConstants.qr,
      builder: (context, state) => const QrPage(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return ShellPage(child: child);
      },
      routes: [
        GoRoute(
          path: AppRouterConstants.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: AppRouterConstants.profile,
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: AppRouterConstants.cart,
          builder:
              (context, state) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) {
                      Categories category;
                      try {
                        category = Categories.values.byName(
                          state.uri.queryParameters['category'] ?? '',
                        );
                      } catch (e) {
                        category = Categories.food;
                      }
                      return CurrentCategoryCubit(initialCategory: category);
                    },
                  ),
                ],
                child: CartScreen(),
              ),
        ),
        GoRoute(
          path: AppRouterConstants.favorites,
          builder: (context, state) => const FavoritesScreen(),
        ),
      ],
    ),
  ],
);
