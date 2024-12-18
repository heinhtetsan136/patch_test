import 'package:equatable/equatable.dart';
import 'package:patch_skill_test/models/model.dart';

abstract class ProductListState extends Equatable {
  List<Product> products;
  ProductListState(this.products);
  @override
  // TODO: implement props
  List<Object?> get props => [...products, DateTime.now()];
}

class FetchProductInitialState extends ProductListState {
  FetchProductInitialState(super.products);
}

class FetchProductLoadingState extends ProductListState {
  FetchProductLoadingState(super.products);
}

class FetchProductSoftLoadingState extends ProductListState {
  FetchProductSoftLoadingState(super.products);
}

class FetchProductErrorState extends ProductListState {
  final String message;
  FetchProductErrorState(super.products, this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [...products, DateTime.now(), message];
}

class FetchProductLoadedState extends ProductListState {
  FetchProductLoadedState(super.products);
}
