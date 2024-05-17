class User {
  int id;
  String username;
  String firstName;
  String lastName;
  String mobile;
  String address;
  List<Service> services;

  User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.address,
    required this.services,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    var servicesList = json['services'] as List;
    List<Service> services =
        servicesList.map((service) => Service.fromJson(service)).toList();

    return User(
      id: json['id'],
      username: json['username'],
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? "",
      mobile: json['mobile'] ?? "",
      address: json['address'] ?? "",
      services: services,
    );
  }
}

class Service {
  int id;
  String name;
  String description;
  bool isActive;
  String rate;
  String address;
  String location;
  Category category;
  List<OpeningHour> openingHours;
  List<File> files;

  Service({
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

  factory Service.fromJson(Map<String, dynamic> json) {
    var openingHoursList = json['opening_hours'] as List;
    List<OpeningHour> openingHours = openingHoursList
        .map((openingHour) => OpeningHour.fromJson(openingHour))
        .toList();

    var filesList = json['files'] as List;
    List<File> files = filesList.map((file) => File.fromJson(file)).toList();

    return Service(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      isActive: json['is_active'],
      rate: json['rate'],
      address: json['address'],
      location: json['location'],
      category: Category.fromJson(json['category']),
      openingHours: openingHours,
      files: files,
    );
  }
}

class Category {
  String code;
  String displayName;

  Category({
    required this.code,
    required this.displayName,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      code: json['code'],
      displayName: json['display_name'],
    );
  }
}

class OpeningHour {
  String weekday;
  String fromHour;
  String toHour;

  OpeningHour({
    required this.weekday,
    required this.fromHour,
    required this.toHour,
  });

  factory OpeningHour.fromJson(Map<String, dynamic> json) {
    return OpeningHour(
      weekday: json['weekday'],
      fromHour: json['from_hour'],
      toHour: json['to_hour'],
    );
  }
}

class File {
  String id;
  String file;
  String filename;

  File({
    required this.id,
    required this.file,
    required this.filename,
  });

  factory File.fromJson(Map<String, dynamic> json) {
    return File(
      id: json['id'],
      file: json['file'],
      filename: json['filename'],
    );
  }
}
