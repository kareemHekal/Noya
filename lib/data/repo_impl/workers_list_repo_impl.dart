// ignore_for_file: file_names

import 'package:injectable/injectable.dart';
import 'package:noya_app/core/api/api_excuter.dart';
import 'package:noya_app/core/api/api_manager.dart';
import 'package:noya_app/core/api/api_result.dart';
import 'package:noya_app/core/api/endpoints.dart';
import 'package:noya_app/data/models/WorkerModel.dart';
import 'package:noya_app/data/models/material_model.dart';
import 'package:noya_app/domain/repo/materials_list_repo.dart';
import 'package:noya_app/domain/repo/workers_list_repo.dart';

@Injectable(as: WorkersRepo)
class WorkersListRepoImpl implements WorkersRepo {
  final ApiManager apiManager;

  @factoryMethod
  WorkersListRepoImpl(this.apiManager);

  @override
  Future<ApiResult<List<WorkerModel>>> getList() async {
    return await executeApi<List<WorkerModel>>(() async {
      var apiResponse = await apiManager.getRequest(
        endpoint: EndPoint.workersEndpoint,
      );
      var result = (apiResponse.data as List)
          .map((item) => WorkerModel.fromJson(item))
          .toList();
      return result;
    });
  }
}
