import 'package:malina_test_app/core/constants/app_images.dart';
import 'package:malina_test_app/core/enums/categories.dart';

class Product {
  Product({
    required this.name,
    required this.category,
    required this.price,
    required this.subCategory,
    required this.description,
    this.count = 1,
  });

  final String name;
  final Categories category;
  final int price;
  final String subCategory;
  final String description;
  final int count;

  String get image => switch (category) {
    Categories.beauty => AppImages.beautyProduct,
    Categories.food => AppImages.foodProduct,
  };

  Product copyWith({
    String? name,
    Categories? category,
    int? price,
    String? subCategory,
    String? description,
    int? count,
  }) {
    return Product(
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      subCategory: subCategory ?? this.subCategory,
      description: description ?? this.description,
      count: count ?? this.count,
    );
  }

  Product fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      category: Categories.values.byName(json['category']),
      price: json['price'],
      subCategory: json['sub_category'],
      description: json['description'],
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category.name,
      'price': price,
      'sub_category': subCategory,
      'description': description,
      'count': count,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.name == name &&
        other.category == category &&
        other.price == price &&
        other.subCategory == subCategory &&
        other.description == description;
  }

  @override
  int get hashCode =>
      name.hashCode ^
      category.hashCode ^
      price.hashCode ^
      subCategory.hashCode ^
      description.hashCode;
}
