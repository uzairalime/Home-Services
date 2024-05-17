// // To parse this JSON data, do
// //
// //     final categoryModel = categoryModelFromJson(jsonString);

// import 'dart:convert';

// List<CategoryModel> categoryModelFromJson(String str) =>
//     List<CategoryModel>.from(
//         json.decode(str).map((x) => CategoryModel.fromJson(x)));

// String categoryModelToJson(List<CategoryModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class CategoryModel {
//   String? code;
//   String? displayName;

//   CategoryModel({
//     this.code,
//     this.displayName,
//   });

//   factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
//         code: json["code"],
//         displayName: json["display_name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "code": code,
//         "display_name": displayName,
//       };
// }
