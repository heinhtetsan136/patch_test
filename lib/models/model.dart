import 'package:equatable/equatable.dart';

abstract class Model extends Equatable {
  int id;
  String title, category, description, image;
  double price;

  Model(
      {required this.id,
      required this.title,
      required this.price,
      required this.category,
      required this.description,
      required this.image});

  @override
  // TODO: implement props
  List<Object?> get props => [id, DateTime.now()];
}

class Category extends Model {
  Category(
      {required super.id,
      required super.title,
      required super.price,
      required super.category,
      required super.description,
      required super.image});

  factory Category.fromJson(dynamic data) {
    return Category(
      id: data["id"],
      title: data["title"],
      price: data["price"],
      category: data["category"],
      description: data["description"],
      image: data["image"],
    );
  }
}

class Product extends Model {
  Product(
      {required super.id,
      required super.title,
      required super.price,
      required super.category,
      required super.description,
      required super.image});
  factory Product.fromJson(dynamic data) {
    print("this is raww $data");
    return Product(
      id: data["id"],
      title: data["title"],
      price: double.tryParse(data["price"].toString()) ?? 0,
      category: data["category"],
      description: data["description"],
      image: data["image"],
    );
  }
}
