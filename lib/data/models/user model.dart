class Usermodel {
  String id;
  String name;
  String email;
  String phoneNumber;

  Usermodel({this.id = "", required this.name,required this.phoneNumber, required this.email});

  factory Usermodel.fromJson(Map<String, dynamic> json) => Usermodel(
    id: json['id'] ?? "", // Provide a default value if 'id' is null
    name: json['name'] ?? "", // Handle potential null values
    email: json['email'] ?? "",
    phoneNumber: json['phoneNumber'] ?? "",
    // Handle potential null values
  );

  Map<String, dynamic> tojson() {
    return {"id": id, "name": name, "email": email, "phoneNumber": phoneNumber};
  }
}
