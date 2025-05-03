// ignore_for_file: file_names

import 'package:injectable/injectable.dart';
import 'package:noya_app/core/api/api_result.dart';
import 'package:noya_app/data/models/material_model.dart';
import 'package:noya_app/domain/repo/materials_list_repo.dart';

@injectable
class GetMaterialsListUseCase {
  final MaterialsRepo materialRepo;

  @factoryMethod
  GetMaterialsListUseCase({required this.materialRepo});

  Future<ApiResult<List<MaterialModel>>> invoke() async {
    final result = await materialRepo.getList();
    return result;
  }
}
