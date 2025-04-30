// ignore_for_file: file_names

import 'package:noya_app/core/api/api_result.dart';
import 'package:noya_app/data/models/product.dart';

abstract class ProductByIdRepo {
  Future<ApiResult<Product>> getProductById({
    required num? productId,
  });
}
