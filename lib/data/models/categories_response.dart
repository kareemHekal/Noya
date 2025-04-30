import 'product.dart'; // تأكد إن ده هو المسار الصحيح لموديل Product

class CategoriesResponse {
  CategoriesResponse({
    this.categoryId,
    this.categoryName,
    this.products,
  });

  CategoriesResponse.fromJson(dynamic json) {
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    if (json['products'] != null) {
      products = List<Product>.from(
        (json['products'] as List).map((e) => Product.fromJson(e)),
      );
    }
  }

  num? categoryId;
  String? categoryName;
  List<Product>? products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categoryId'] = categoryId;
    map['categoryName'] = categoryName;
    if (products != null) {
      map['products'] = products!.map((e) => e.toJson()).toList();
    }
    return map;
  }
}
