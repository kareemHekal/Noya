/// productId : 31
/// productName : "Sofa"
/// description : "A comfortable 3-seater sofa."
/// price : 3000.00
/// stock : 10
/// categoryId : 1
/// imageUrl : "https://example.com/images/sofa.jpg"
/// category : null

class Product {
    Product({
        this.productId,
        this.productName,
      this.quantity,
        this.description,
        this.price,
        this.stock,
        this.categoryId,
        this.imageUrl,
        this.category,});

  Product.fromJson(dynamic json) {
    productId = json['productId'];
    productName = json['productName'];
    description = json['description'];
    price = json['price'];
    quantity = json['quantity'];
    stock = json['stock'];
    categoryId = json['categoryId'];
    imageUrl = json['imageUrl'];
    category = json['category'];
  }
  num? productId;
  String? productName;
  String? description;
  num? price;
  num? stock;
  num? quantity;
  num? categoryId;
  String? imageUrl;
  dynamic category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productId'] = productId;
    map['productName'] = productName;
    map['description'] = description;
    map['price'] = price;
    map['stock'] = stock;
    map['quantity'] = quantity;
    map['categoryId'] = categoryId;
    map['imageUrl'] = imageUrl;
    map['category'] = category;
    return map;
  }

}