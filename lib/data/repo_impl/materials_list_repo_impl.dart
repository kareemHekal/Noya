// ignore_for_file: file_names

import 'package:injectable/injectable.dart';
import 'package:noya_app/core/api/api_excuter.dart';
import 'package:noya_app/core/api/api_manager.dart';
import 'package:noya_app/core/api/api_result.dart';
import 'package:noya_app/core/api/endpoints.dart';
import 'package:noya_app/data/models/material_model.dart';
import 'package:noya_app/domain/repo/materials_list_repo.dart';

@Injectable(as: MaterialsRepo)
class CategoriesListRepoImpl implements MaterialsRepo {
  final ApiManager apiManager;

  @factoryMethod
  CategoriesListRepoImpl(this.apiManager);

  @override
  Future<ApiResult<List<MaterialModel>>> getList() async {
    return await executeApi<List<MaterialModel>>(() async {
      var apiResponse = await apiManager.getRequest(
        endpoint: EndPoint.materialEndpoint,
      );
      var result = (apiResponse.data as List)
          .map((item) => MaterialModel.fromJson(item))
          .toList();
      return result;
    });
  }
}
