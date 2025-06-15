import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malina_test_app/core/enums/categories.dart';

class CurrentCategoryCubit extends Cubit<Categories> {
  CurrentCategoryCubit({required Categories initialCategory})
    : super(initialCategory);

  void changeCategory(Categories category) => emit(category);
}
