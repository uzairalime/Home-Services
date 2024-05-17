// Define Dart model classes
class MyServicesBookingModel {
  final int id;
  final String price;
  final String startAt;
  final String endAt;
  final String address;
  final String? location;
  final String description;
  final Map<String, dynamic> extraInfo;
  final String status;
  final String paymentStatus;
  final String createdAt;
  final int serviceId;
  final MyServicesService service;
  final Map<String, dynamic> user;

  MyServicesBookingModel({
    required this.id,
    required this.price,
    required this.startAt,
    required this.endAt,
    required this.address,
    required this.location,
    required this.description,
    required this.extraInfo,
    required this.status,
    required this.paymentStatus,
    required this.createdAt,
    required this.serviceId,
    required this.service,
    required this.user,
  });

  factory MyServicesBookingModel.fromJson(Map<String, dynamic> json) {
    return MyServicesBookingModel(
      id: json['id'],
      price: json['price'],
      startAt: json['start_at'],
      endAt: json['end_at'],
      address: json['address'],
      location: json['location'],
      description: json['description'],
      extraInfo: json['extra_info'],
      status: json['status'],
      paymentStatus: json['payment_status'],
      createdAt: json['created_at'],
      serviceId: json['service_id'],
      service: MyServicesService.fromJson(json['service']),
      user: json['user'],
    );
  }
}

class MyServicesService {
  final int id;
  final String name;
  final String description;
  final bool isActive;
  final String rate;
  final String address;
  final String location;
  final MyServicesCategory category;
  final List<MyServicesOpeningHour> openingHours;
  final List<MyServicesFile> files;

  MyServicesService({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
    required this.rate,
    required this.address,
    required this.location,
    required this.category,
    required this.openingHours,
    required this.files,
  });

  factory MyServicesService.fromJson(Map<String, dynamic> json) {
    return MyServicesService(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      isActive: json['is_active'],
      rate: json['rate'],
      address: json['address'],
      location: json['location'],
      category: MyServicesCategory.fromJson(json['category']),
      openingHours:
          (json['opening_hours'] as List).map((e) => MyServicesOpeningHour.fromJson(e)).toList(),
      files: (json['files'] as List).map((e) => MyServicesFile.fromJson(e)).toList(),
    );
  }
}

class MyServicesCategory {
  final String code;
  final String displayName;

  MyServicesCategory({required this.code, required this.displayName});

  factory MyServicesCategory.fromJson(Map<String, dynamic> json) {
    return MyServicesCategory(
      code: json['code'],
      displayName: json['display_name'],
    );
  }
}

class MyServicesOpeningHour {
  final String weekday;
  final String fromHour;
  final String toHour;

  MyServicesOpeningHour({required this.weekday, required this.fromHour, required this.toHour});

  factory MyServicesOpeningHour.fromJson(Map<String, dynamic> json) {
    return MyServicesOpeningHour(
      weekday: json['weekday'],
      fromHour: json['from_hour'],
      toHour: json['to_hour'],
    );
  }
}

class MyServicesFile {
  final String id;
  final String file;
  final String filename;

  MyServicesFile({required this.id, required this.file, required this.filename});

  factory MyServicesFile.fromJson(Map<String, dynamic> json) {
    return MyServicesFile(
      id: json['id'],
      file: json['file'],
      filename: json['filename'],
    );
  }
}
