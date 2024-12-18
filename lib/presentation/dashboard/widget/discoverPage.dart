import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patch_skill_test/controller/category/fetch_category_bloc.dart';
import 'package:patch_skill_test/controller/category/fetch_category_state.dart';
import 'package:patch_skill_test/controller/product/fetch_product_bloc.dart';
import 'package:patch_skill_test/controller/product/fetch_product_event.dart';
import 'package:patch_skill_test/controller/product/fetch_product_state.dart';

Map<String, String> categoryMap = {
  "electronics": "https://fakestoreapi.com/img/81QpkIctqPL._AC_SX679_.jpg",
  "jewelery":
      "https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg",
  "men's clothing": "https://fakestoreapi.com/img/71YXzeOuslL._AC_UY879_.jpg",
  "women's clothing":
      "https://fakestoreapi.com/img/71HblAHs5xL._AC_UY879_-2.jpg"
};

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productbloc = context.read<ProductListBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.white,
          height: 156,
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  height: 110,
                  width: double.infinity,
                  color: const Color.fromRGBO(122, 110, 174, 1),
                ),
              ),
              Positioned(
                  left: 18,
                  right: 18,
                  top: 75,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          hintStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                          prefixIcon: Icon(Icons.search, size: 18),
                          hintText: "What are you looking for"),
                    ),
                  ))
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Text(
            "Choose from any Category",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          // color: Colors.amber,
          width: double.infinity,
          height: 130,
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 10),
          child: BlocBuilder<CategoryListBloc, CategoryBaseState>(
              builder: (_, state) {
            if (state is CategoryLoadingState) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
            print("state is ${state.category} $state");
            return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, i) {
                  final category = state.category[i];
                  return Column(
                    children: [
                      ValueListenableBuilder(
                          valueListenable: productbloc.isSelected,
                          builder: (_, value, i) {
                            print("value is v $value");
                            if (value == category) {
                              return GestureDetector(
                                  onTap: () {
                                    productbloc
                                        .add(FetchProductByCategory(category));
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(3),
                                      width: 85,
                                      height: 85,
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Color.fromRGBO(76, 186, 204, 1),
                                          Color.fromRGBO(119, 210, 139, 1)
                                        ]),
                                        shape: BoxShape.circle,
                                      ),
                                      child: CategoryItems(
                                        image: categoryMap[category] ?? "",
                                      )));
                            }
                            return GestureDetector(
                              onTap: () {
                                productbloc
                                    .add(FetchProductByCategory(category));
                              },
                              child: Container(
                                  padding: const EdgeInsets.all(3),
                                  width: 85,
                                  height: 85,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: CategoryItems(
                                    image: categoryMap[category] ?? "",
                                  )),
                            );
                          }),
                      Text(
                        category,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      )
                    ],
                  );
                },
                separatorBuilder: (_, i) {
                  return const SizedBox(
                    width: 4,
                  );
                },
                itemCount: state.category.length);
          }),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: BlocBuilder<ProductListBloc, ProductListState>(
              builder: (_, state) {
            return Text(
              "${state.products.length} products to choose from",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            );
          }),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 15.0, right: 15, left: 15),
          child: Row(
            children: [
              FilterButton(
                valueListenable: productbloc.islowestPriceFirst,
                name: "Lowest Price First",
                onTap: () {
                  productbloc.add(const ArrangeProductbyLowestPrice());
                },
              ),
              FilterButton(
                valueListenable: productbloc.isHighestPriceFirst,
                name: "Highest Price First",
                onTap: () {
                  productbloc.add(const ArrangeProductbyHighestPrice());
                },
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            width: double.infinity,
            child: BlocBuilder<ProductListBloc, ProductListState>(
                builder: (_, state) {
              if (state is FetchProductLoadingState) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              }
              print("product state is $state ${state.products}");
              final products = state.products;
              return GridView.builder(
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                      crossAxisCount: 2),
                  itemBuilder: (_, i) {
                    final product = products[i];
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      width: 170,
                      height: 210,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 0.5,
                              color: const Color.fromRGBO(202, 202, 202, 1))),
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              child: CachedNetworkImage(
                                imageUrl: product.image,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            width: 150,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  product.description,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  "\$${product.price}",
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  });
            }),
          ),
        ),
        BlocBuilder<ProductListBloc, ProductListState>(builder: (_, state) {
          if (state is FetchProductLoadedState) {
            return const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8),
                  child: Text(
                    "That's all!",
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(124, 124, 124, 1)),
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        })
      ],
    );
  }
}

class CategoryItems extends StatelessWidget {
  final String image;
  const CategoryItems({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(2),
        width: 82,
        height: 82,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
            radius: 37.5,
            foregroundImage: NetworkImage(
              image,
            )));
  }
}

class FilterButton extends StatelessWidget {
  final String name;
  final ValueListenable<bool> valueListenable;
  void Function()? onTap;

  FilterButton(
      {super.key,
      required this.name,
      required this.valueListenable,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ValueListenableBuilder(
          valueListenable: valueListenable,
          builder: (_, value, __) {
            return Container(
              margin: const EdgeInsets.only(right: 15),
              padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 9),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(width: 0.5),
                  color: value
                      ? const Color.fromRGBO(122, 110, 174, 1)
                      : const Color.fromRGBO(202, 202, 202, 1)),
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            );
          }),
    );
  }
}
