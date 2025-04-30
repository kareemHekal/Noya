// ignore_for_file: file_names

import 'package:injectable/injectable.dart';
import 'package:noya_app/core/api/api_excuter.dart';
import 'package:noya_app/core/api/api_manager.dart';
import 'package:noya_app/core/api/api_result.dart';
import 'package:noya_app/core/api/endpoints.dart';
import 'package:noya_app/data/models/bundle_response.dart';
import 'package:noya_app/data/models/categories_response.dart';
import 'package:noya_app/domain/repo/bundel_list_repo.dart';
import 'package:noya_app/domain/repo/categories_list_repo.dart';

@Injectable(as: CategoriesRepo)
class CategoriesListRepoImpl implements CategoriesRepo {
  final ApiManager apiManager;

  @factoryMethod
  CategoriesListRepoImpl(this.apiManager);

  @override
  Future<ApiResult<List<CategoriesResponse>>> getList() async {
    return await executeApi<List<CategoriesResponse>>(() async {
      var apiResponse = await apiManager.getRequest(
        endpoint: EndPoint.categoriesEndpoint,
      );
      var result = (apiResponse.data as List)
          .map((item) => CategoriesResponse.fromJson(item))
          .toList();
      return result;
    });
  }
}
