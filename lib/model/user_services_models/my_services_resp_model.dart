class MyServicesRespModel {
  int? id;
  String? name;
  String? description;
  bool? isActive;
  String? rate;
  String? address;
  String? location;
  RespCategory? category;
  List<RespOpeningHours>? openingHours;
  List<RespFiles>? files;

  MyServicesRespModel(
      {this.id,
      this.name,
      this.description,
      this.isActive,
      this.rate,
      this.address,
      this.location,
      // this.category,
      this.openingHours,
      this.files});

  MyServicesRespModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    isActive = json['is_active'];
    rate = json['rate'];
    address = json['address'];
    location = json['location'];
    // category = json['category'] != null ? RespCategory.fromJson(json['category']) : null;
    if (json['opening_hours'] != null) {
      openingHours = <RespOpeningHours>[];
      json['opening_hours'].forEach((v) {
        openingHours!.add(RespOpeningHours.fromJson(v));
      });
    }
    if (json['files'] != null) {
      files = <RespFiles>[];
      json['files'].forEach((v) {
        files!.add(RespFiles.fromJson(v));
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
    // if (category != null) {
    //   data['category'] = category!.toJson();
    // }
    if (openingHours != null) {
      data['opening_hours'] = openingHours!.map((v) => v.toJson()).toList();
    }
    if (files != null) {
      data['files'] = files!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RespCategory {
  String? code;
  String? displayName;

  RespCategory({this.code, this.displayName});

  RespCategory.fromJson(Map<String, dynamic> json) {
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

class RespOpeningHours {
  String? weekday;
  String? fromHour;
  String? toHour;

  RespOpeningHours({this.weekday, this.fromHour, this.toHour});

  RespOpeningHours.fromJson(Map<String, dynamic> json) {
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

class RespFiles {
  String? id;
  String? file;
  String? filename;

  RespFiles({this.id, this.file, this.filename});

  RespFiles.fromJson(Map<String, dynamic> json) {
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
