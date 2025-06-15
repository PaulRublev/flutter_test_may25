import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:malina_test_app/core/constants/app_colors.dart';
import 'package:malina_test_app/core/constants/app_icons.dart';
import 'package:malina_test_app/core/constants/app_router_constants.dart';
import 'package:malina_test_app/core/constants/app_text_styles.dart';
import 'package:malina_test_app/core/widgets/malina_button.dart';

final key = GlobalKey<FormState>();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  bool isEmailEmpty = true;
  bool hidePassword = true;

  @override
  void initState() {
    super.initState();

    emailController.addListener(() {
      setState(() {
        isEmailEmpty = emailController.text.isEmpty;
      });
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    final RegExp passwordRegex = RegExp(r'^.{8,}$');

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          20,
          MediaQuery.of(context).size.height * 0.25,
          20,
          20,
        ),
        child: Center(
          child: Form(
            key: key,
            autovalidateMode: AutovalidateMode.onUserInteraction,

            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: emailController,
                  focusNode: _emailFocusNode,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_passwordFocusNode);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Поле не может быть пустым';
                    }
                    if (!emailRegex.hasMatch(value)) {
                      return 'Введите корректную почту';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: Text('Почта'),
                    border: OutlineInputBorder(),
                    suffixIconConstraints: const BoxConstraints(
                      maxHeight: 40,
                      maxWidth: 40,
                    ),
                    suffixIcon:
                        isEmailEmpty
                            ? null
                            : GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () => emailController.clear(),
                              child: Center(
                                child: SvgPicture.asset(
                                  AppIcons.close,
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            ),
                  ),
                ),
                SizedBox(height: 24),
                TextFormField(
                  controller: passwordController,
                  focusNode: _passwordFocusNode,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) {
                    _passwordFocusNode.unfocus();
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Поле не может быть пустым';
                    }
                    if (!passwordRegex.hasMatch(value)) {
                      return 'Пароль должен содержать не менее 8 символов';
                    }
                    return null;
                  },
                  obscureText: hidePassword,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    label: Text('Пароль'),

                    border: OutlineInputBorder(),
                    suffixIconConstraints: const BoxConstraints(
                      maxHeight: 40,
                      maxWidth: 40,
                    ),
                    suffixIcon: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                      child: Center(
                        child: SvgPicture.asset(
                          AppIcons.hide,
                          height: 20,
                          width: 20,
                          colorFilter: ColorFilter.mode(
                            hidePassword
                                ? AppColors.black
                                : AppColors.unselected,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                MalinaButton(
                  onPressed: () {
                    // if (key.currentState!.validate()) {
                    //   // TODO: save user if not exist, check password if exist
                    //   context.go(AppRouterConstants.home);
                    // }
                    context.go(AppRouterConstants.home);
                  },
                  child: Text(
                    'Войти',
                    style: AppTextStyles.m16.copyWith(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
