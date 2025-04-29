// ignore_for_file: file_names

import 'package:noya_app/core/api/api_result.dart';
import 'package:noya_app/data/models/bundle_response.dart';

abstract class BundleRepo {
  Future<ApiResult<List<BundleResponse>>> getList();
}
