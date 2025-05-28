class Usermodel {
  String id;
  String name;
  String email;
  String? phoneNumber;
  String? userAddress;

  Usermodel({this.id = "", required this.name,required this.phoneNumber, required this.userAddress, required this.email});

  factory Usermodel.fromJson(Map<String, dynamic> json) => Usermodel(
    userAddress: json['userAddress'] ?? null,
    id: json['id'] ?? "", // Provide a default value if 'id' is null
    name: json['name'] ?? "", // Handle potential null values
    email: json['email'] ?? "",
    phoneNumber: json['phoneNumber'] ??null,
    // Handle potential null values
  );

  Map<String, dynamic> tojson() {
    return {"id": id, "name": name, "email": email, "phoneNumber": phoneNumber, "userAddress": userAddress};
  }
}
