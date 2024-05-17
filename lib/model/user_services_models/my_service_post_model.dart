class MyServicesPostModel {
  String? name;
  String? description;
  String? category;
  String? address;
  List<String>? files;
  String? location;
  List<PostOpeningHours>? openingHours;
  String? rate;

  MyServicesPostModel(
      {this.name,
      this.description,
      this.category,
      this.address,
      this.files,
      this.location,
      this.openingHours,
      this.rate});

  MyServicesPostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    category = json['category'];
    address = json['address'];
    files = json['files'].cast<String>();
    location = json['location'];
    if (json['opening_hours'] != null) {
      openingHours = <PostOpeningHours>[];
      json['opening_hours'].forEach((v) {
        openingHours!.add(PostOpeningHours.fromJson(v));
      });
    }
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['category'] = category;
    data['address'] = address;
    data['files'] = files;
    data['location'] = location;
    if (openingHours != null) {
      data['opening_hours'] = openingHours!.map((v) => v.toJson()).toList();
    }
    data['rate'] = rate;
    return data;
  }
}

class PostOpeningHours {
  String? fromHour;
  String? toHour;
  String? weekday;

  PostOpeningHours({this.fromHour, this.toHour, this.weekday});

  PostOpeningHours.fromJson(Map<String, dynamic> json) {
    fromHour = json['from_hour'];
    toHour = json['to_hour'];
    weekday = json['weekday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['from_hour'] = fromHour;
    data['to_hour'] = toHour;
    data['weekday'] = weekday;
    return data;
  }
}
