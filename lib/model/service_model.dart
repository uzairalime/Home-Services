// To parse this JSON data, do
//
//     final ServicesModel = ServicesModelFromJson(jsonString);

import 'dart:convert';

List<ServicesModel> ServicesModelFromJson(String str) => List<ServicesModel>.from(
    json.decode(str).map((x) => ServicesModel.fromJson(x)));

String ServicesModelToJson(List<ServicesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServicesModel {
  int? id;
  String? name;
  String? description;
  bool? isActive;
  String? rate;
  String? address;
  String? location;
  Category? category;
  List<OpeningHour>? openingHours;
  List<FileElement>? files;

  ServicesModel({
    this.id,
    this.name,
    this.description,
    this.isActive,
    this.rate,
    this.address,
    this.location,
    this.category,
    this.openingHours,
    this.files,
  });

  factory ServicesModel.fromJson(Map<String, dynamic> json) => ServicesModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        isActive: json["is_active"],
        rate: json["rate"],
        address: json["address"],
        location: json["location"],
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        openingHours: json["opening_hours"] == null
            ? []
            : List<OpeningHour>.from(
                json["opening_hours"]!.map((x) => OpeningHour.fromJson(x))),
        files: json["files"] == null
            ? []
            : List<FileElement>.from(
                json["files"]!.map((x) => FileElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "is_active": isActive,
        "rate": rate,
        "address": address,
        "location": location,
        "category": category?.toJson(),
        "opening_hours": openingHours == null
            ? []
            : List<dynamic>.from(openingHours!.map((x) => x.toJson())),
        "files": files == null
            ? []
            : List<dynamic>.from(files!.map((x) => x.toJson())),
      };
}

class Category {
  String? code;
  String? displayName;

  Category({
    this.code,
    this.displayName,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        code: json["code"],
        displayName: json["display_name"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "display_name": displayName,
      };
}

class FileElement {
  String? id;
  String? file;
  String? filename;

  FileElement({
    this.id,
    this.file,
    this.filename,
  });

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        id: json["id"],
        file: json["file"],
        filename: json["filename"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "file": file,
        "filename": filename,
      };
}

class OpeningHour {
  String? weekday;
  String? fromHour;
  String? toHour;

  OpeningHour({
    this.weekday,
    this.fromHour,
    this.toHour,
  });

  factory OpeningHour.fromJson(Map<String, dynamic> json) => OpeningHour(
        weekday: json["weekday"],
        fromHour: json["from_hour"],
        toHour: json["to_hour"],
      );

  Map<String, dynamic> toJson() => {
        "weekday": weekday,
        "from_hour": fromHour,
        "to_hour": toHour,
      };
}
