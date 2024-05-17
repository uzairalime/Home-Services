import 'dart:convert';

List<CetegoryModel> cetegoryModelFromJson(String str) =>
    List<CetegoryModel>.from(
        json.decode(str).map((x) => CetegoryModel.fromJson(x)));

String cetegoryModelToJson(List<CetegoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class CetegoryModel {
  final String? code;
  final String? displayName;

  CetegoryModel({
    this.code,
    this.displayName,
  });

  factory CetegoryModel.fromJson(Map<String, dynamic> json) => CetegoryModel(
        code: json["code"],
        displayName: json["display_name"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "display_name": displayName,
      };
}
