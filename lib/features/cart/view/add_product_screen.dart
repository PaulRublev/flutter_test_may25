import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:malina_test_app/core/constants/app_colors.dart';
import 'package:malina_test_app/core/constants/app_text_styles.dart';
import 'package:malina_test_app/core/enums/categories.dart';
import 'package:malina_test_app/core/widgets/malina_button.dart';
import 'package:malina_test_app/data/models/product.dart';
import 'package:malina_test_app/features/cart/cubit/cart_cubit.dart';
import 'package:malina_test_app/features/cart/widgets/pink_shape.dart';

final addProductFormKey = GlobalKey<FormState>();

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key, required this.category});

  final Categories? category;

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController subCategoryController = TextEditingController();

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();
  final FocusNode priceFocusNode = FocusNode();
  final FocusNode subCategoryFocusNode = FocusNode();

  final categoryNotifier = ValueNotifier<Categories?>(null);

  @override
  void initState() {
    super.initState();

    categoryNotifier.value = widget.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить'),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actionsPadding: const EdgeInsets.only(right: 10),
        actions: [
          TextButton(
            style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
            onPressed: () {
              // TODO: go to qr screen to scan and fill product's fields
            },
            child: Text(
              'Сканировать',
              style: AppTextStyles.r14.copyWith(color: AppColors.black),
            ),
          ),
        ],
      ),
      body: Form(
        key: addProductFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.fromLTRB(9, 16, 9, 20),
          child: Stack(
            children: [
              Positioned.fill(child: PinkShape()),
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 14, 4, 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  for (Categories category in Categories.values)
                                    ListTile(
                                      title: Text(category.title),
                                      visualDensity: VisualDensity.compact,
                                      onTap: () {
                                        categoryNotifier.value = category;
                                        Navigator.pop(context);
                                      },
                                    ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: ValueListenableBuilder(
                        valueListenable: categoryNotifier,
                        builder: (context, category, _) {
                          return TextFormField(
                            enabled: false,
                            controller: TextEditingController(
                              text: category?.title ?? '',
                            ),
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Поле не может быть пустым';
                              }

                              return null;
                            },
                            style: AppTextStyles.r16.copyWith(
                              color: AppColors.black,
                            ),
                            decoration: InputDecoration(
                              label: Text('Категория'),
                              border: OutlineInputBorder(),
                              suffixIconConstraints: const BoxConstraints(
                                maxHeight: 40,
                                maxWidth: 40,
                              ),
                              labelStyle: AppTextStyles.r16.copyWith(
                                color: AppColors.black,
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.black,
                                  width: 1,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 24),
                    TextFormField(
                      controller: subCategoryController,
                      focusNode: subCategoryFocusNode,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(nameFocusNode);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Поле не может быть пустым';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text('Подкатегория'),
                        border: OutlineInputBorder(),
                        suffixIconConstraints: const BoxConstraints(
                          maxHeight: 40,
                          maxWidth: 40,
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    TextFormField(
                      controller: nameController,
                      focusNode: nameFocusNode,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(priceFocusNode);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Поле не может быть пустым';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text('Название'),
                        border: OutlineInputBorder(),
                        suffixIconConstraints: const BoxConstraints(
                          maxHeight: 40,
                          maxWidth: 40,
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    TextFormField(
                      controller: priceController,
                      focusNode: priceFocusNode,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(
                          context,
                        ).requestFocus(descriptionFocusNode);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Поле не может быть пустым';
                        }

                        if (int.tryParse(value) == null) {
                          return 'Введите целое число';
                        }

                        return null;
                      },
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text('Цена'),
                        border: OutlineInputBorder(),
                        suffixIconConstraints: const BoxConstraints(
                          maxHeight: 40,
                          maxWidth: 40,
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Text('Описание', style: AppTextStyles.r16),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: descriptionController,
                      focusNode: descriptionFocusNode,
                      maxLines: 10,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).unfocus();
                      },
                      validator: (value) {
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIconConstraints: const BoxConstraints(
                          maxHeight: 40,
                          maxWidth: 40,
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    MalinaButton(
                      child: const Text('Сохранить'),
                      onPressed: () {
                        if (addProductFormKey.currentState!.validate()) {
                          try {
                            final product = Product(
                              name: nameController.text,
                              description: descriptionController.text,
                              price: int.parse(priceController.text),
                              subCategory: subCategoryController.text,
                              category: categoryNotifier.value!,
                            );
                            context.read<CartCubit>().addToCart(product);
                            context.pop();
                          } catch (e) {
                            log(e.toString());
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
