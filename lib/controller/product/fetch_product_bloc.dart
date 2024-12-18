import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patch_skill_test/controller/product/fetch_product_event.dart';
import 'package:patch_skill_test/controller/product/fetch_product_state.dart';
import 'package:patch_skill_test/locator.dart';
import 'package:patch_skill_test/repositories/product_repo.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final ProductRepo productRepo = Locator.get<ProductRepo>();
  ValueNotifier<bool> islowestPriceFirst = ValueNotifier(false);
  ValueNotifier<bool> isHighestPriceFirst = ValueNotifier(false);
  ValueNotifier<String> isSelected = ValueNotifier("");

  ProductListBloc() : super(FetchProductInitialState(const [])) {
    on<FetchAllProduct>((event, emit) async {
      if (state is FetchProductLoadingState ||
          state is FetchProductSoftLoadingState) return;
      final product = state.products;
      print("state of product $product");

      emit(FetchProductLoadingState(const []));
      final result = await productRepo.getAllProduct();
      if (result.hasError) {
        emit(FetchProductErrorState(product, result.error!.messsage));
        return;
      }
      emit(FetchProductLoadedState(result.data));
    });
    on<FetchProductByCategory>((event, emit) async {
      if (state is FetchProductLoadingState ||
          state is FetchProductSoftLoadingState) return;
      if (isSelected.value == event.category) {
        isSelected.value = "";
        add(const FetchAllProduct());
        return;
      }

      isSelected.value = event.category;

      emit(FetchProductLoadingState(const []));
      final result = await productRepo.getProductbyCategory(event.category);
      if (result.hasError) {
        emit(FetchProductErrorState(const [], result.error!.messsage));
        return;
      }

      emit(FetchProductLoadedState(result.data));
    });
    on<ArrangeProductbyHighestPrice>((_, emit) {
      if (state is FetchProductLoadingState ||
          state is FetchProductSoftLoadingState) return;
      final products = state.products;
      if (products.isNotEmpty != true) {
        return;
      }
      islowestPriceFirst.value = false;
      isHighestPriceFirst.value = true;
      emit(FetchProductLoadingState(products));
      products.sort((p, c) {
        return c.price.compareTo(p.price);
      });
      emit(FetchProductLoadedState(products));
    });
    on<ArrangeProductbyLowestPrice>((_, emit) {
      if (state is FetchProductLoadingState ||
          state is FetchProductSoftLoadingState) return;
      final products = state.products;
      if (products.isNotEmpty != true) {
        return;
      }
      islowestPriceFirst.value = true;
      isHighestPriceFirst.value = false;
      emit(FetchProductLoadingState(products));
      products.sort((p, c) {
        return p.price.compareTo(c.price);
      });
      emit(FetchProductLoadedState(products));
    });
    add(const FetchAllProduct());
  }
}
