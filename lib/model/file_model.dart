import 'dart:convert';

List<FileModel> fileModelFromJson(String str) =>
    List<FileModel>.from(json.decode(str).map((x) => FileModel.fromJson(x)));

String fileModelToJson(List<FileModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FileModel {
  String? id;
  String? title;
  String? file;
  String? filename;

  FileModel({
    this.id,
    this.title,
    this.file,
    this.filename,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) => FileModel(
        id: json["id"],
        title: json["title"],
        file: json["file"],
        filename: json["filename"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "file": file,
        "filename": filename,
      };
}

class FileResponse {
  String? id;
  String? title;
  String? file;
  String? filename;

  FileResponse({
    this.id,
    this.title,
    this.file,
    this.filename,
  });

  factory FileResponse.fromJson(Map<String, dynamic> json) => FileResponse(
        id: json["id"],
        title: json["title"],
        file: json["file"],
        filename: json["filename"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "file": file,
        "filename": filename,
      };
}
