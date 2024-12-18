import 'package:dio/dio.dart';
import 'package:patch_skill_test/const.dart';
import 'package:patch_skill_test/error.dart';
import 'package:patch_skill_test/locator.dart';
import 'package:patch_skill_test/models/model.dart';
import 'package:patch_skill_test/result.dart';

class ProductRepo {
  final _dio = Locator.get<Dio>();
  Future<Result> _try(Future<Result> Function() callback) async {
    try {
      final result = await callback();
      return result;
    } on DioException catch (e) {
      return Result(error: GeneralError(e.toString()));
    } catch (e) {
      print("e is $e");
      return Result(error: GeneralError("Unknown Error"));
    }
  }

  Future<Result> getProductbyCategory(String Category) async {
    return _try(() async {
      final result = await _dio.get("${Api.GetProductsByCategories}$Category");
      if (result.data == null) {
        return Result(error: GeneralError("There is no Products"));
      }
      final body = result.data as List;
      List<Product> products = body.map(Product.fromJson).toList();
      return Result(data: products);
    });
  }

  Future<Result> getAllProduct() async {
    return _try(() async {
      final result = await _dio.get(Api.GetAllProducts);
      if (result.data == null) {
        return Result(error: GeneralError("There is no Products"));
      }
      final body = result.data as List;
      List<Product> products = body.map(Product.fromJson).toList();
      return Result(data: products);
    });
  }
}
