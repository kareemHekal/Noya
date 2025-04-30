// ignore_for_file: file_names

import 'package:noya_app/core/api/api_result.dart';
import 'package:noya_app/data/models/categories_response.dart';

abstract class CategoriesRepo {
  Future<ApiResult<List<CategoriesResponse>>> getList();
}
