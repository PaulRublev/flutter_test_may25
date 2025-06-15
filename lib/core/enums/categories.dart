enum Categories { food, beauty }

extension CategoriesExtension on Categories {
  String get title => switch (this) {
    Categories.beauty => 'Бьюти',
    Categories.food => 'Еда',
  };
}
