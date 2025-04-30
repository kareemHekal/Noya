///  Auth Intent ///
// ignore_for_file: non_constant_identifier_names, dangling_library_doc_comments

sealed class ProductCardIntent {}

class GetProductCardIntent extends ProductCardIntent {
  num? productId;

  GetProductCardIntent({required this.productId});
}
