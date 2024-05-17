import 'dart:convert';

List<OfferModel> offerModelFromJson(String str) =>
    List<OfferModel>.from(json.decode(str).map((x) => OfferModel.fromJson(x)));

String offerModelToJson(List<OfferModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OfferModel {
  int? id;
  String? image;
  String? heading;
  String? description;

  OfferModel({
    this.id,
    this.image,
    this.heading,
    this.description,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
        id: json["id"],
        image: json["image"],
        heading: json["heading"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "heading": heading,
        "description": description,
      };
}
