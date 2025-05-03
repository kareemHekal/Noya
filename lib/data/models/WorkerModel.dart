/// workerId : 1
/// name : "محمد يوسف"
/// phone : "01012345678"
/// email : "m.youssef@example.com"
/// specialization : "نجارة"
/// experienceYears : 5
/// location : "الجيزة"
/// imageUrl : "https://example.com/images/worker1.jpg"
/// jobs : null

class WorkerModel {
  WorkerModel({
      this.workerId, 
      this.name, 
      this.phone, 
      this.email, 
      this.specialization, 
      this.experienceYears, 
      this.location, 
      this.imageUrl, 
      this.jobs,});

  WorkerModel.fromJson(dynamic json) {
    workerId = json['workerId'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    specialization = json['specialization'];
    experienceYears = json['experienceYears'];
    location = json['location'];
    imageUrl = json['imageUrl'];
    jobs = json['jobs'];
  }
  num? workerId;
  String? name;
  String? phone;
  String? email;
  String? specialization;
  num? experienceYears;
  String? location;
  String? imageUrl;
  dynamic jobs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['workerId'] = workerId;
    map['name'] = name;
    map['phone'] = phone;
    map['email'] = email;
    map['specialization'] = specialization;
    map['experienceYears'] = experienceYears;
    map['location'] = location;
    map['imageUrl'] = imageUrl;
    map['jobs'] = jobs;
    return map;
  }

}