// ignore_for_file: file_names

import 'package:noya_app/core/api/api_result.dart';
import 'package:noya_app/data/models/material_model.dart';

abstract class MaterialsRepo {
  Future<ApiResult<List<MaterialModel>>> getList();
}
