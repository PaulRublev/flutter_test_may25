import 'package:malina_test_app/data/models/product.dart';

Map<String, List<Product>> groupBySubCategory(List<Product> products) {
  final map = <String, List<Product>>{};

  for (final product in products) {
    map.putIfAbsent(product.subCategory, () => []).add(product);
  }

  return map;
}
