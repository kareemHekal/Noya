// ignore_for_file: file_names

import 'package:injectable/injectable.dart';
import 'package:noya_app/core/api/api_excuter.dart';
import 'package:noya_app/core/api/api_manager.dart';
import 'package:noya_app/core/api/api_result.dart';
import 'package:noya_app/core/api/endpoints.dart';
import 'package:noya_app/data/models/bundle_response.dart';
import 'package:noya_app/data/models/product.dart';
import 'package:noya_app/domain/repo/bundel_list_repo.dart';
import 'package:noya_app/domain/repo/prodct_by_id_repo.dart';

@Injectable(as: ProductByIdRepo)
class GetProudctByIdRepoImpl implements ProductByIdRepo {
  final ApiManager apiManager;

  @factoryMethod
  GetProudctByIdRepoImpl(this.apiManager);
  @override
  Future<ApiResult<Product>> getProductById({required num? productId}) async {
    return await executeApi<Product>(() async {
      var apiResponse = await apiManager.getRequest(
        endpoint: EndPoint.getProductById(productId),
      );
      var result = Product.fromJson(apiResponse.data);
      return result;
    });
  }

}
