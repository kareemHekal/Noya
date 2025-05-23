// ignore_for_file: file_names

import 'package:injectable/injectable.dart';
import 'package:noya_app/core/api/api_result.dart';
import 'package:noya_app/data/models/product.dart';
import 'package:noya_app/domain/repo/prodct_by_id_repo.dart';

@injectable
class GetProductByIdUsecase {
  final ProductByIdRepo bundleRepo;

  @factoryMethod
  GetProductByIdUsecase({required this.bundleRepo});

  Future<ApiResult<Product>> invoke({required num? productId}) async {
    final result = await bundleRepo.getProductById(productId: productId);
    return result;
  }
}
