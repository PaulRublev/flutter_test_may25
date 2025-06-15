import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:malina_test_app/core/constants/app_colors.dart';
import 'package:malina_test_app/core/constants/app_icons.dart';
import 'package:malina_test_app/core/constants/app_text_styles.dart';
import 'package:malina_test_app/data/models/product.dart';

class CartProductsWidget extends StatefulWidget {
  const CartProductsWidget({
    super.key,
    required this.products,
    required this.subCategory,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  });

  final List<Product> products;
  final String subCategory;
  final Function(Product product) onIncrease;
  final Function(Product product) onDecrease;
  final Function(Product product) onRemove;

  @override
  State<CartProductsWidget> createState() => _CartProductsWidgetState();
}

class _CartProductsWidgetState extends State<CartProductsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            spacing: 4,
            children: [
              Text(
                widget.subCategory,
                style: AppTextStyles.r16.copyWith(color: AppColors.grey),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.grey,
                size: 12,
              ),
            ],
          ),
          Divider(color: AppColors.greyBackground, thickness: 1),
          ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 0),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.products.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              return IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 9,
                  children: [
                    Container(
                      height: 110,
                      width: 110,
                      decoration: BoxDecoration(
                        color: AppColors.greyBackground,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage(widget.products[index].image),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 4,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.products[index].name,
                                  style: AppTextStyles.m16.copyWith(
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                              Text(
                                '${widget.products[index].price} C',
                                style: AppTextStyles.m16.copyWith(
                                  color: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Text(
                              widget.products[index].description,
                              maxLines: 3,
                              style: AppTextStyles.r12.copyWith(
                                color: AppColors.grey,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Row(
                            spacing: 10,
                            children: [
                              GestureDetector(
                                onTap:
                                    () => widget.onDecrease(
                                      widget.products[index],
                                    ),
                                child: Container(
                                  height: 34,
                                  width: 34,
                                  decoration: BoxDecoration(
                                    color: AppColors.greyBackground,
                                    borderRadius: BorderRadius.circular(9.44),
                                  ),
                                  child: const Icon(
                                    Icons.remove,
                                    color: AppColors.black,
                                    size: 20,
                                  ),
                                ),
                              ),
                              Text(
                                widget.products[index].count.toString(),
                                style: AppTextStyles.r16.copyWith(
                                  color: AppColors.black,
                                ),
                              ),
                              GestureDetector(
                                onTap:
                                    () => widget.onIncrease(
                                      widget.products[index],
                                    ),
                                child: Container(
                                  height: 34,
                                  width: 34,
                                  decoration: BoxDecoration(
                                    color: AppColors.greyBackground,
                                    borderRadius: BorderRadius.circular(9.44),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: AppColors.black,
                                    size: 20,
                                  ),
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap:
                                    () =>
                                        widget.onRemove(widget.products[index]),
                                child: SizedBox(
                                  height: 34,
                                  width: 34,
                                  child: SvgPicture.asset(AppIcons.delete),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.malina,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Text(
                  'Всего',
                  style: AppTextStyles.m16.copyWith(color: AppColors.white),
                ),
                Spacer(),
                Text(
                  '${widget.products.map((e) => e.price * e.count).reduce((value, element) => value + element)} C',
                  style: AppTextStyles.m16.copyWith(color: AppColors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
