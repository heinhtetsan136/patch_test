import 'package:patch_skill_test/error.dart';

class Result<T> {
  final T? _data;
  final GeneralError? error;

  Result({T? data, this.error}) : _data = data;

  bool get hasError => error != null;
  T get data => _data!;
}
