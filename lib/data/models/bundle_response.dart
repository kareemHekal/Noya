/// bundleId : 1
/// name : "Basic Bundle"
/// price : 5000.00
/// imageUrl : "https://example.com/images/basic_bundle.jpg"
/// bundleItems : [{"bundleId":1,"productId":31,"quantity":2},{"bundleId":1,"productId":32,"quantity":1},{"bundleId":1,"productId":33,"quantity":3}]

class BundleResponse {
  BundleResponse({
      this.bundleId, 
      this.name, 
      this.price, 
      this.imageUrl, 
      this.bundleItems,});

  BundleResponse.fromJson(dynamic json) {
    bundleId = json['bundleId'];
    name = json['name'];
    price = json['price'];
    imageUrl = json['imageUrl'];
    if (json['bundleItems'] != null) {
      bundleItems = [];
      json['bundleItems'].forEach((v) {
        bundleItems?.add(BundleItems.fromJson(v));
      });
    }
  }
  num? bundleId;
  String? name;
  num? price;
  String? imageUrl;
  List<BundleItems>? bundleItems;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bundleId'] = bundleId;
    map['name'] = name;
    map['price'] = price;
    map['imageUrl'] = imageUrl;
    if (bundleItems != null) {
      map['bundleItems'] = bundleItems?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// bundleId : 1
/// productId : 31
/// quantity : 2

class BundleItems {
  BundleItems({
      this.bundleId, 
      this.productId, 
      this.quantity,});

  BundleItems.fromJson(dynamic json) {
    bundleId = json['bundleId'];
    productId = json['productId'];
    quantity = json['quantity'];
  }
  num? bundleId;
  num? productId;
  num? quantity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bundleId'] = bundleId;
    map['productId'] = productId;
    map['quantity'] = quantity;
    return map;
  }

}