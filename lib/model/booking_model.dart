// To parse this JSON data, do
//
//     final bookingModel = bookingModelFromJson(jsonString);

import 'dart:convert';

List<BookingModel> bookingModelFromJson(String str) => List<BookingModel>.from(json.decode(str).map((x) => BookingModel.fromJson(x)));

String bookingModelToJson(List<BookingModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookingModel {
    int id;
    String price;
    DateTime startAt;
    DateTime endAt;
    String address;
    String? location;
    String description;
    ExtraInfo extraInfo;
    String status;
    String paymentStatus;
    DateTime createdAt;
    int serviceId;
    Service service;
    User user;

    BookingModel({
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

    factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        id: json["id"],
        price: json["price"],
        startAt: DateTime.parse(json["start_at"]),
        endAt: DateTime.parse(json["end_at"]),
        address: json["address"],
        location: json["location"],
        description: json["description"],
        extraInfo: ExtraInfo.fromJson(json["extra_info"]),
        status: json["status"],
        paymentStatus: json["payment_status"],
        createdAt: DateTime.parse(json["created_at"]),
        serviceId: json["service_id"],
        service: Service.fromJson(json["service"]),
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "start_at": startAt.toIso8601String(),
        "end_at": endAt.toIso8601String(),
        "address": address,
        "location": location,
        "description": description,
        "extra_info": extraInfo.toJson(),
        "status": status,
        "payment_status": paymentStatus,
        "created_at": createdAt.toIso8601String(),
        "service_id": serviceId,
        "service": service.toJson(),
        "user": user.toJson(),
    };
}

class ExtraInfo {
    int noOfHours;
    String? pestService;
    String? home;
    int? noOfCleaners;
    String? cleaningFrequency;
    List<dynamic>? selectedDaysOfWeek;
    bool? isCheckedMaterialsNeeded;

    ExtraInfo({
        required this.noOfHours,
        this.pestService,
        this.home,
        this.noOfCleaners,
        this.cleaningFrequency,
        this.selectedDaysOfWeek,
        this.isCheckedMaterialsNeeded,
    });

    factory ExtraInfo.fromJson(Map<String, dynamic> json) => ExtraInfo(
        noOfHours: json["no_of_hours"],
        pestService: json["pest_service"],
        home: json["home"],
        noOfCleaners: json["no_of_cleaners"],
        cleaningFrequency: json["cleaning_frequency"],
        selectedDaysOfWeek: json["selected_days_of_week"] == null ? [] : List<dynamic>.from(json["selected_days_of_week"]!.map((x) => x)),
        isCheckedMaterialsNeeded: json["is_checked_materials_needed"],
    );

    Map<String, dynamic> toJson() => {
        "no_of_hours": noOfHours,
        "pest_service": pestService,
        "home": home,
        "no_of_cleaners": noOfCleaners,
        "cleaning_frequency": cleaningFrequency,
        "selected_days_of_week": selectedDaysOfWeek == null ? [] : List<dynamic>.from(selectedDaysOfWeek!.map((x) => x)),
        "is_checked_materials_needed": isCheckedMaterialsNeeded,
    };
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
    List<FileElement> files;

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

    factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        isActive: json["is_active"],
        rate: json["rate"],
        address: json["address"],
        location: json["location"],
        category: Category.fromJson(json["category"]),
        openingHours: List<OpeningHour>.from(json["opening_hours"].map((x) => OpeningHour.fromJson(x))),
        files: List<FileElement>.from(json["files"].map((x) => FileElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "is_active": isActive,
        "rate": rate,
        "address": address,
        "location": location,
        "category": category.toJson(),
        "opening_hours": List<dynamic>.from(openingHours.map((x) => x.toJson())),
        "files": List<dynamic>.from(files.map((x) => x.toJson())),
    };
}

class Category {
    String code;
    String displayName;

    Category({
        required this.code,
        required this.displayName,
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
    String id;
    String file;
    String filename;

    FileElement({
        required this.id,
        required this.file,
        required this.filename,
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
    String weekday;
    String fromHour;
    String toHour;

    OpeningHour({
        required this.weekday,
        required this.fromHour,
        required this.toHour,
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

class User {
    String username;
    String firstName;
    String lastName;
    dynamic mobile;

    User({
        required this.username,
        required this.firstName,
        required this.lastName,
        required this.mobile,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        mobile: json["mobile"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "first_name": firstName,
        "last_name": lastName,
        "mobile": mobile,
    };
}
