import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malina_test_app/app/router.dart';
import 'package:malina_test_app/core/constants/app_colors.dart';
import 'package:malina_test_app/core/constants/app_text_styles.dart';
import 'package:malina_test_app/features/cart/cubit/cart_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => CartCubit())],
      child: MaterialApp.router(
        routerConfig: router,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.scaffold,
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.scaffold,
            titleTextStyle: AppTextStyles.title.copyWith(
              color: AppColors.black,
            ),
          ),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
