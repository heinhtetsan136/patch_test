import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patch_skill_test/controller/category/fetch_category_event.dart';
import 'package:patch_skill_test/controller/category/fetch_category_state.dart';
import 'package:patch_skill_test/locator.dart';
import 'package:patch_skill_test/repositories/category_repo.dart';
import 'package:patch_skill_test/repositories/product_repo.dart';

class CategoryListBloc extends Bloc<CategoryListBaseEvent, CategoryBaseState> {
  final CategoryRepo categoryRepo = Locator.get<CategoryRepo>();
  CategoryListBloc() : super(const CategoryInitialState([])) {
    final ProductRepo productRepo = Locator.get<ProductRepo>();
    on<FetchCategoryEvent>((event, emit) async {
      if (state is CategoryLoadingState || state is CategorySoftLoadingState) {
        return;
      }
      final List<String> category = state.category;
      if (category.isNotEmpty != true) {
        emit(const CategoryLoadingState([]));
      } else {
        emit(CategorySoftLoadingState(category));
      }

      final result = await categoryRepo.getAllCategory();
      print("result is $result");
      if (result.hasError) {
        emit(CategoryErrorState(category, result.error!.messsage));
        return;
      }
      final List<String> data = result.data;
      emit(CategoryLoadedState(data));
    });
    add(const FetchCategoryEvent());
  }
}
