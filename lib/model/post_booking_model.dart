// To parse this JSON data, do
//
//     final postBookingModel = postBookingModelFromJson(jsonString);

import 'dart:convert';

PostBookingModel postBookingModelFromJson(String str) => PostBookingModel.fromJson(json.decode(str));

String postBookingModelToJson(PostBookingModel data) => json.encode(data.toJson());

class PostBookingModel {
    String price;
    DateTime startAt;
    DateTime endAt;
    String address;
    String location;
    String description;
    int serviceId;
    ExtraInfo extraInfo;

    PostBookingModel({
        required this.price,
        required this.startAt,
        required this.endAt,
        required this.address,
        required this.location,
        required this.description,
        required this.serviceId,
        required this.extraInfo,
    });

    factory PostBookingModel.fromJson(Map<String, dynamic> json) => PostBookingModel(
        price: json["price"],
        startAt: DateTime.parse(json["start_at"]),
        endAt: DateTime.parse(json["end_at"]),
        address: json["address"],
        location: json["location"],
        description: json["description"],
        serviceId: json["service_id"],
        extraInfo: ExtraInfo.fromJson(json["extra_info"]),
    );

    Map<String, dynamic> toJson() => {
        "price": price,
        "start_at": startAt.toIso8601String(),
        "end_at": endAt.toIso8601String(),
        "address": address,
        "location": location,
        "description": description,
        "service_id": serviceId,
        "extra_info": extraInfo.toJson(),
    };
}

class ExtraInfo {
    String cleaningFrequency;
    String isCheckedMaterialsNeeded;
    String noOfCleaners;
    String noOfHours;
    List<dynamic> selectedDaysOfWeek;

    ExtraInfo({
        required this.cleaningFrequency,
        required this.isCheckedMaterialsNeeded,
        required this.noOfCleaners,
        required this.noOfHours,
        required this.selectedDaysOfWeek,
    });

    factory ExtraInfo.fromJson(Map<String, dynamic> json) => ExtraInfo(
        cleaningFrequency: json["cleaning_frequency"],
        isCheckedMaterialsNeeded: json["is_checked_materials_needed"],
        noOfCleaners: json["no_of_cleaners"],
        noOfHours: json["no_of_hours"],
        selectedDaysOfWeek: List<dynamic>.from(json["selected_days_of_week"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "cleaning_frequency": cleaningFrequency,
        "is_checked_materials_needed": isCheckedMaterialsNeeded,
        "no_of_cleaners": noOfCleaners,
        "no_of_hours": noOfHours,
        "selected_days_of_week": List<dynamic>.from(selectedDaysOfWeek.map((x) => x)),
    };
}
