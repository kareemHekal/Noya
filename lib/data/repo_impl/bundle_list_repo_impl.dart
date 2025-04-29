// ignore_for_file: file_names

import 'package:injectable/injectable.dart';
import 'package:noya_app/core/api/api_excuter.dart';
import 'package:noya_app/core/api/api_manager.dart';
import 'package:noya_app/core/api/api_result.dart';
import 'package:noya_app/core/api/endpoints.dart';
import 'package:noya_app/data/models/bundle_response.dart';
import 'package:noya_app/domain/repo/bundel_list_repo.dart';

@Injectable(as: BundleRepo)
class BundleRepoImpl implements BundleRepo {
  final ApiManager apiManager;

  @factoryMethod
  BundleRepoImpl(this.apiManager);

  @override
  Future<ApiResult<List<BundleResponse>>> getList() async {
    return await executeApi<List<BundleResponse>>(() async {
      var apiResponse = await apiManager.getRequest(
        endpoint: EndPoint.bundleEndpoint,
      );
      var result = (apiResponse.data as List)
          .map((item) => BundleResponse.fromJson(item))
          .toList();
      return result;
    });
  }
}
