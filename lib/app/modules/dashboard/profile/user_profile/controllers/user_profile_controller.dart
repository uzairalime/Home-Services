import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as deo;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/modules/dashboard/profile/user_profile/views/user_profile_view.dart';
import 'package:home_brigadier/consts/static_data.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../../model/file_model.dart';
import '../../../../../../model/user_services_models/my_booking_booking_model.dart';
import '../../../../../../model/user_services_models/my_service_post_model.dart';
import '../../../../../../model/user_services_models/my_services_resp_model.dart';
import '../../../../../../services/apis/toast.dart';

class UserProfileController extends GetxController {
  static UserProfileController get to => Get.find();

  ScrollController scrollController = ScrollController();



  var weekdays = [
    "monday",
    "tuesday",
    "wednesday",
    "thursday",
    "friday",
    "saturday",
    "sunday"
  ];
  var menuItems = [
    'Cleaning',
    'Painting',
    'Tailor',
    'Handyman',
    'Pest Control',
    'Women Salon',
    'Men Salon',
    'Spa',
    'Electricity',
    'Plumbing',
    'Ac Repair'
  ].obs;
  var selectedCategory = 'Cleaning'.obs;
  var selectedWeekdays = <String>[].obs;
  var selectedFrom = ''.obs;
  var selectedTill = ''.obs;
  var categoryFocus = false.obs;
  var fromFocus = false.obs;
  var tillFocus = false.obs;
  var rateFocus = false.obs;
  RxBool isLoading = false.obs;
  RxBool imgUploading = false.obs;
  XFile? pickedFile;
  Rx<File?> selectedImage = Rx<File?>(null);
  deo.Dio dio = deo.Dio();

  String fileId = '';

  // final bookingController = BookingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController rateController = TextEditingController();

  String txt = LocaleKeys.start_earning_item_txt.tr;

  var hours = [
    '08 AM',
    '09 AM',
    '10 AM',
    '11 AM',
    '12 PM',
    '01 PM',
    '02 PM',
    '03 PM',
    '04 PM',
    '05 PM',
  ].obs;

  var previousImage = '';

  Future<void> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();

    try {
      pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50, // Adjust the image quality as needed
      );
      if (pickedFile != null) {
        selectedImage.value = File(pickedFile!.path);
        postFile();
      } else {
        // print('No image selected.');
      }
    } catch (e) {
      //print('Error picking image: $e');
    }
  }

  void selectFrom(String hour) {
    selectedFrom.value = hour;
  }

  void selectTill(String hour) {
    selectedTill.value = hour;
  }

  void onSelectCategory(String item) {
    selectedCategory.value = item;
  }

  void toggleSelection(String weekday) {
    if (selectedWeekdays.contains(weekday)) {
      selectedWeekdays.remove(weekday);
    } else {
      selectedWeekdays.add(weekday);
    }
    update();
  }

  Future<void> updateUserService(
      {required int id,
      required String name,
      required String description,
      required String category,
      required String address,
      required String location,
      required String fileId,
      required List<String> weekDays,
      required String from_hour,
      required String to_hour,
      required String rate}) async {
    MyServicesPostModel model = MyServicesPostModel();
    dio.options.headers['Authorization'] = 'Bearer ${StaticData.accessToken}';
    List<PostOpeningHours> openingHours = [];

    for (var i in weekDays) {
      openingHours.add(PostOpeningHours(
          weekday: i.toLowerCase().toString(),
          fromHour: from_hour.toString(),
          toHour: to_hour.toString()));
    }

    model = MyServicesPostModel(
        name: name.toString(),
        description: description.toString(),
        category: category.toString().trim(),
        address: address.toString(),
        files: [fileId.toString()],
        location: location.toString(),
        openingHours: openingHours,
        rate: rate.toString());

    //print(jsonEncode(model));

    try {
      isLoading.value = true;
      update();

      final response = await dio.put(
        "https://homebrigadier.fly.dev/api/service/$id/",
        data: jsonEncode(model),
      );
      //print(response.statusCode);
      if (response.statusCode == 200) {
        showsnackbar("Service Update Successfully");
        Get.off(() => const UserProfileView());
      }
    } on SocketException catch (_) {
      showsnackbar("Error: Check Internet Connection", true);

      // print("SocketException: $e");
    } catch (e) {
      showsnackbar("Failed to Update: Try again", true);

      //print("Error: $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<List<MyServicesRespModel>> fetchServices() async {
    dio.options.headers['Authorization'] = 'Bearer ${StaticData.accessToken}';
    try {
      final response = await dio.get("https://homebrigadier.fly.dev/api/service/");

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = response.data;
        List<MyServicesRespModel> services =
            jsonResponse.map((data) => MyServicesRespModel.fromJson(data)).toList();
        return services;
      } else {
        throw Exception('Failed to load jobs from API');
      }
    } catch (e) {
      throw Exception('Failed to load jobs from API: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<MyServicesBookingModel>> fetchBooking() async {
    dio.options.headers['Authorization'] = 'Bearer ${StaticData.accessToken}';

    try {
      final response = await dio.get("https://homebrigadier.fly.dev/api/user/booking/");
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((item) => MyServicesBookingModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Failed to load data: $error');
    }
  }

  Future<void> postFile() async {
    FileModel files = FileModel();
    imgUploading.value = true;
    update();
    dio.options.headers['Authorization'] = 'Bearer ${StaticData.accessToken}';

    try {
      await pickedFile!.readAsBytes().then((imageBytes) async {
        deo.FormData data = deo.FormData.fromMap(
            ({"file": deo.MultipartFile.fromBytes(imageBytes, filename: pickedFile!.path)}));

        await dio.post("https://homebrigadier.fly.dev/api/service/file/", data: data).then((value) {
          //print("file response ${value.data}");
          files = FileModel.fromJson(value.data);
          fileId = files.id!;
          print(fileId);
          showsnackbar("Image Upload Successfully");
        });
      });
    } on SocketException catch (_) {
      showsnackbar("failed to upload: check internet connection", true);
    } catch (e) {
      showsnackbar("failed to upload: file already exist", true);
    } finally {
      imgUploading.value = false;
      update();
    }
  }
}

String convertTo24Hour(String time12Hour) {
  List<String> timeParts = time12Hour.split(' ');
  String time = timeParts[0];
  String period = timeParts[1];
  int hours = int.parse(time);

  if (period == 'PM' && hours < 12) {
    hours += 12;
  } else if (period == 'AM' && hours == 12) {
    hours = 0;
  }
  String hoursString = hours.toString().padLeft(2, '0');

  return '$hoursString:00';
}

String convertToCamelCase(String input) {
  List<String> words = input.split(' ');

  String firstWord = words[0].toLowerCase();

  for (int i = 1; i < words.length; i++) {
    firstWord += words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
  }

  return firstWord;
}

String txt =
    "Once you've filled out this form, our team will be in touch with you to facilitate your service listing.";

String formatTime(String time24Hour) {
  // Split the time string by ":"
  List<String> parts = time24Hour.split(":");

  // Get the hour part
  int hour = int.parse(parts[0]);

  // Determine AM/PM
  String period = hour < 12 ? 'AM' : 'PM';

  // Convert hour to 12-hour format
  if (hour > 12) {
    hour -= 12;
  } else if (hour == 0) {
    hour = 12;
  }

  return "$hour$period";
}
