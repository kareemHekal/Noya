/// materialId : 4
/// name : "خشب زان"
/// description : "خشب زان ممتاز للأبواب"
/// unitPrice : 850.00
/// stockQuantity : 50
/// providerId : 1
/// imageUrl : "https://example.com/images/wood.jpg"

class MaterialModel {
  MaterialModel({
      this.materialId, 
      this.name, 
      this.description, 
      this.unitPrice, 
      this.stockQuantity, 
      this.providerId, 
      this.imageUrl,});

  MaterialModel.fromJson(dynamic json) {
    materialId = json['materialId'];
    name = json['name'];
    description = json['description'];
    unitPrice = json['unitPrice'];
    stockQuantity = json['stockQuantity'];
    providerId = json['providerId'];
    imageUrl = json['imageUrl'];
  }
  num? materialId;
  String? name;
  String? description;
  num? unitPrice;
  num? stockQuantity;
  num? providerId;
  String? imageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['materialId'] = materialId;
    map['name'] = name;
    map['description'] = description;
    map['unitPrice'] = unitPrice;
    map['stockQuantity'] = stockQuantity;
    map['providerId'] = providerId;
    map['imageUrl'] = imageUrl;
    return map;
  }

}