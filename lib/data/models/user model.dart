class Usermodel {
  String id;
  String firstName;
  String lastName;
  String email;
  String? phoneNumber;
  String? userAddress;

  Usermodel({
    this.id = "",
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.userAddress,
    required this.email,
  });

  factory Usermodel.fromJson(Map<String, dynamic> json) => Usermodel(
    userAddress: json['userAddress'] ?? null,
    id: json['id'] ?? "",
    firstName: json['firstName'] ?? "",
    lastName: json['lastName'] ?? "",
    email: json['email'] ?? "",
    phoneNumber: json['phoneNumber'] ?? null,
    // Handle potential null values
  );

  Map<String, dynamic> tojson() {
    return {
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phoneNumber": phoneNumber,
      "userAddress": userAddress,
    };
  }
}
