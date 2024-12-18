import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:patch_skill_test/repositories/category_repo.dart';
import 'package:patch_skill_test/repositories/product_repo.dart';

GetIt Locator = GetIt.asNewInstance();
Future<void> setUp() async {
  final dio = Dio();

  Locator.registerLazySingleton(() => dio);
  Locator.registerLazySingleton(() => CategoryRepo());
  Locator.registerLazySingleton(() => ProductRepo());
  // Locator.registerLazySingleton(() => SharePref);
}
