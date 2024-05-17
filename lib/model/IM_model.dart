import 'dart:convert';

List<IMModel> imModelFromJson(String str) =>
    List<IMModel>.from(json.decode(str).map((x) => IMModel.fromJson(x)));

String imModelToJson(List<IMModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IMModel {
  int? id;
  String? username;
  String? firstName;
  String? lastName;
  String? mobile;
  String? address;
  List<ServiceResponse>? services;

  IMModel({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.mobile,
    this.address,
    this.services,
  });

  factory IMModel.fromJson(Map<String, dynamic> json) => IMModel(
        id: json["id"],
        username: json["username"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        mobile: json["mobile"],
        address: json["address"],
        services: List<ServiceResponse>.from(
            json["services"].map((x) => ServiceResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "first_name": firstName,
        "last_name": lastName,
        "mobile": mobile,
        "address": address,
        "services": List<dynamic>.from(services!.map((x) => x.toJson())),
      };
}

class ServiceResponse {
  int? id;
  String? name;
  String? description;
  bool? isActive;
  double? rate;
  String? address;

  ServiceResponse({
    this.id,
    this.name,
    this.description,
    this.isActive,
    this.rate,
    this.address,
  });

  factory ServiceResponse.fromJson(Map<String, dynamic> json) =>
      ServiceResponse(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        isActive: json["is_active"],
        rate: json["rate"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "is_active": isActive,
        "rate": rate,
        "address": address,
      };
}
