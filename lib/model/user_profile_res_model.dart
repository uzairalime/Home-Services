class UserProfile {
  int? id;
  String? username;
  String? firstName;
  String? lastName;
  dynamic mobile;
  dynamic address;
  List<Services>? services;

  UserProfile(
      {this.id,
      this.username,
      this.firstName,
      this.lastName,
      this.mobile,
      this.address,
      this.services});

  UserProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobile = json['mobile'];
    address = json['address'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['mobile'] = mobile;
    data['address'] = address;
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  int? id;
  String? name;
  String? description;
  bool? isActive;
  String? rate;
  String? address;
  String? location;
  Category? category;
  List<OpeningHours>? openingHours;
  List<Files>? files;

  Services(
      {this.id,
      this.name,
      this.description,
      this.isActive,
      this.rate,
      this.address,
      this.location,
      this.category,
      this.openingHours,
      this.files});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    isActive = json['is_active'];
    rate = json['rate'];
    address = json['address'];
    location = json['location'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    if (json['opening_hours'] != null) {
      openingHours = <OpeningHours>[];
      json['opening_hours'].forEach((v) {
        openingHours!.add(OpeningHours.fromJson(v));
      });
    }
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(Files.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['is_active'] = isActive;
    data['rate'] = rate;
    data['address'] = address;
    data['location'] = location;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (openingHours != null) {
      data['opening_hours'] = openingHours!.map((v) => v.toJson()).toList();
    }
    if (files != null) {
      data['files'] = files!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String? code;
  String? displayName;

  Category({this.code, this.displayName});

  Category.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    displayName = json['display_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['display_name'] = displayName;
    return data;
  }
}

class OpeningHours {
  String? weekday;
  String? fromHour;
  String? toHour;

  OpeningHours({this.weekday, this.fromHour, this.toHour});

  OpeningHours.fromJson(Map<String, dynamic> json) {
    weekday = json['weekday'];
    fromHour = json['from_hour'];
    toHour = json['to_hour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['weekday'] = weekday;
    data['from_hour'] = fromHour;
    data['to_hour'] = toHour;
    return data;
  }
}

class Files {
  String? id;
  String? file;
  String? filename;

  Files({this.id, this.file, this.filename});

  Files.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    file = json['file'];
    filename = json['filename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['file'] = file;
    data['filename'] = filename;
    return data;
  }
}
