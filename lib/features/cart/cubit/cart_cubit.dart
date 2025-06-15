import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malina_test_app/core/enums/categories.dart';
import 'package:malina_test_app/data/models/product.dart';

class CartCubit extends Cubit<List<Product>> {
  CartCubit() : super([]);

  // TODO: add hive service

  void addToCart(Product product) {
    if (state.contains(product)) {
      final updatedState = [...state];
      final index = updatedState.indexOf(product);
      final oldProduct = updatedState[index];
      updatedState[index] = oldProduct.copyWith(count: 1 + oldProduct.count);
      emit(updatedState);

      return;
    }
    emit([...state, product]);
  }

  void decreaseCount(Product product) {
    final updatedState = [...state];
    final index = updatedState.indexOf(product);
    final oldProduct = updatedState[index];
    if (oldProduct.count == 1) {
      removeFromCart(product);
      return;
    }
    updatedState[index] = oldProduct.copyWith(count: oldProduct.count - 1);
    emit(updatedState);
  }

  void removeFromCart(Product product) {
    final updatedState = [...state];
    final index = updatedState.indexOf(product);
    updatedState.removeAt(index);
    emit(updatedState);
  }

  void clearCart() => emit([]);

  void clearCartCategory(Categories category) {
    final updatedState = [...state];
    updatedState.removeWhere((element) => element.category == category);
    emit(updatedState);
  }
}
