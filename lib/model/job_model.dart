import 'dart:convert';

List<JobModel> jobModelFromJson(String str) =>
    List<JobModel>.from(json.decode(str).map((x) => JobModel.fromJson(x)));

String jobModelToJson(List<JobModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobModel {
  int? id;
  String? title;
  double? price;
  String? startAt;
  String? endAt;
  String? address;
  String? location;
  String? description;
  ExtraInfo? extraInfo;
  String? status;
  String? paymentStatus;
  String? createdAt;
  int? serviceId;
  ServiceResponse? service;
  SharedUser? user;

  JobModel({
    this.id,
    this.title,
    this.price,
    this.startAt,
    this.endAt,
    this.address,
    this.location,
    this.description,
    this.extraInfo,
    this.status,
    this.paymentStatus,
    this.createdAt,
    this.serviceId,
    this.service,
    this.user,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) => JobModel(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        startAt: json["start_at"],
        endAt: json["end_at"],
        address: json["address"],
        location: json["location"],
        description: json["description"],
        extraInfo: ExtraInfo.fromJson(json["extra_info"]),
        status: json["status"],
        paymentStatus: json["payment_status"],
        createdAt: json["created_at"],
        serviceId: json["service_id"],
        service: ServiceResponse.fromJson(json["service"]),
        user: SharedUser.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "start_at": startAt,
        "end_at": endAt,
        "address": address,
        "location": location,
        "description": description,
        "extra_info": extraInfo!.toJson(),
        "status": status,
        "payment_status": paymentStatus,
        "created_at": createdAt,
        "service_id": serviceId,
        "service": service!.toJson(),
        "user": user!.toJson(),
      };
}

class ExtraInfo {
  // Define properties for ExtraInfo if available in your use case.
  // Example: String? additionalField;

  ExtraInfo(
// Initialize properties if needed.
      );

  factory ExtraInfo.fromJson(Map<String, dynamic> json) {
// Implement the factory method if needed.
    return ExtraInfo();
  }

  Map<String, dynamic> toJson() {
// Implement toJson method if needed.
    return {};
  }
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

class SharedUser {
  String? username;
  String? firstName;
  String? lastName;
  String? mobile;

  SharedUser({
    this.username,
    this.firstName,
    this.lastName,
    this.mobile,
  });

  factory SharedUser.fromJson(Map<String, dynamic> json) => SharedUser(
        username: json["username"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        mobile: json["mobile"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "first_name": firstName,
        "last_name": lastName,
        "mobile": mobile,
      };
}
