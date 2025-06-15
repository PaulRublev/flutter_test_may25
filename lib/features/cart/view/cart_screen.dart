import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:malina_test_app/core/constants/app_colors.dart';
import 'package:malina_test_app/core/constants/app_router_constants.dart';
import 'package:malina_test_app/core/constants/app_text_styles.dart';
import 'package:malina_test_app/core/enums/categories.dart';
import 'package:malina_test_app/core/utils/group_by_sub_category.dart';
import 'package:malina_test_app/core/widgets/malina_button.dart';
import 'package:malina_test_app/data/models/product.dart';
import 'package:malina_test_app/features/cart/cubit/cart_cubit.dart';
import 'package:malina_test_app/features/cart/cubit/current_category_cubit.dart';
import 'package:malina_test_app/features/cart/widgets/cart_products_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin {
  late final tabController = TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    final categoryCubit = context.read<CurrentCategoryCubit>();
    final currentCategory = context.watch<CurrentCategoryCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
        leading: IconButton(
          onPressed: () => context.go(AppRouterConstants.home),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actionsPadding: const EdgeInsets.only(right: 10),
        actions: [
          TextButton(
            style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
            onPressed: () {
              context.read<CartCubit>().clearCartCategory(currentCategory);
            },
            child: Text(
              'Очистить',
              style: AppTextStyles.r14.copyWith(color: AppColors.black),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              spacing: 16,
              children: [
                ...Categories.values.map(
                  (category) => Expanded(
                    child: MalinaButton(
                      isSelected: category == currentCategory,
                      onPressed: () => categoryCubit.changeCategory(category),
                      child: Text(category.title, style: AppTextStyles.r16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: currentCategory.index,
              children: [
                ...Categories.values.map(
                  (category) => BlocBuilder<CartCubit, List<Product>>(
                    builder: (context, state) {
                      final items = state.where(
                        (product) => product.category == category,
                      );
                      final subcategoryItems =
                          groupBySubCategory(items.toList()).values.toList();

                      return ListView.separated(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                        itemBuilder:
                            (context, index) => CartProductsWidget(
                              products: subcategoryItems[index],
                              subCategory:
                                  subcategoryItems[index].first.subCategory,
                              onIncrease: (product) {
                                context.read<CartCubit>().addToCart(product);
                              },
                              onDecrease: (product) {
                                context.read<CartCubit>().decreaseCount(
                                  product,
                                );
                              },
                              onRemove: (product) {
                                context.read<CartCubit>().removeFromCart(
                                  product,
                                );
                              },
                            ),
                        separatorBuilder:
                            (context, index) => const SizedBox(height: 16),
                        itemCount: subcategoryItems.length,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: FloatingActionButton(
          backgroundColor: Color(0xFFECE6F0),
          child: const Icon(Icons.add),
          onPressed:
              () => context.push(
                '${AppRouterConstants.addProduct}?category=${currentCategory.name}',
              ),
        ),
      ),
    );
  }
}
