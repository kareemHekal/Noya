// ignore_for_file: file_names

import 'package:injectable/injectable.dart';
import 'package:noya_app/core/api/api_result.dart';
import 'package:noya_app/data/models/WorkerModel.dart';
import 'package:noya_app/data/models/material_model.dart';
import 'package:noya_app/domain/repo/materials_list_repo.dart';
import 'package:noya_app/domain/repo/workers_list_repo.dart';

@injectable
class GetWorkersListUsecase {
  final WorkersRepo workerRepo;

  @factoryMethod
  GetWorkersListUsecase({required this.workerRepo});

  Future<ApiResult<List<WorkerModel>>> invoke() async {
    final result = await workerRepo.getList();
    return result;
  }
}
