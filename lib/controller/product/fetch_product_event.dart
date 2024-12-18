abstract class ProductListEvent {
  const ProductListEvent();
}

class FetchAllProduct extends ProductListEvent {
  const FetchAllProduct();
}

class FetchProductByCategory extends ProductListEvent {
  String category;
  FetchProductByCategory(this.category);
}

class ArrangeProductbyLowestPrice extends ProductListEvent {
  const ArrangeProductbyLowestPrice();
}

class ArrangeProductbyHighestPrice extends ProductListEvent {
  const ArrangeProductbyHighestPrice();
}
