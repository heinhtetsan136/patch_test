import 'package:dio/dio.dart';
import 'package:patch_skill_test/const.dart';
import 'package:patch_skill_test/error.dart';
import 'package:patch_skill_test/locator.dart';
import 'package:patch_skill_test/result.dart';

class CategoryRepo {
  final dio = Locator.get<Dio>();
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

  Future<Result> getAllCategory() async {
    return _try(() async {
      final result = await dio.get(Api.GetAllCategories);
      if (result.data == null) {
        return Result(error: GeneralError("There is No Categories"));
      }
      print(result.data);
      List<String> body = [];
      for (var i in result.data) {
        body.add(i);
      }

      print(body);
      return Result(data: body);
    });
  }
}
