// ignore_for_file: file_names

import 'package:noya_app/core/api/api_result.dart';
import 'package:noya_app/data/models/WorkerModel.dart';


abstract class WorkersRepo {
  Future<ApiResult<List<WorkerModel>>> getList();
}
