import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as deo;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/consts/global_variable.dart';
import 'package:home_brigadier/consts/static_data.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../../model/file_model.dart';
import '../../../../../../../model/user_services_models/my_booking_booking_model.dart';
import '../../../../../../../model/user_services_models/my_service_post_model.dart';
import '../../../../../../../model/user_services_models/my_services_resp_model.dart';
import '../../../../../../../services/apis/api_endpoints.dart';
import '../../../../../../../services/apis/toast.dart';
import '../../../../../../../utils/animation_dialog.dart';
import '../../../controllers/dashboard_controller.dart';

class UserProfileController extends GetxController {
  static UserProfileController get to => Get.find();
  static final con = Get.put(SellerDashboardController());

  ScrollController scrollController = ScrollController();
  String profileFileId = '';

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
  RxBool profileUploading = false.obs;
  RxBool frontUploading = false.obs;
  RxBool backUploading = false.obs;
  RxBool workingUploading = false.obs;

  List<String> imgUrlList = List.empty(growable: true);

  XFile? profilePickedFile;
  Rx<File?> selectedProfileImage = Rx<File?>(null);
  XFile? frontPickedFile;
  Rx<File?> selectedFrontImage = Rx<File?>(null);
  XFile? backPickedFile;
  Rx<File?> selectedBackImage = Rx<File?>(null);
  XFile? workingPickedFile;
  Rx<File?> selectedWorkingImage = Rx<File?>(null);
  deo.Dio dio = deo.Dio();

  // final bookingController = BookingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController rateController = TextEditingController();

  String file1 = '';
  String file2 = '';
  String file3 = '';
  String file4 = '';

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

  Future<void> pickProfileImageFromGallery() async {
    final ImagePicker picker = ImagePicker();

    try {
      profilePickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50, // Adjust the image quality as needed
      );
      if (profilePickedFile != null) {
        selectedProfileImage.value = File(profilePickedFile!.path);
        postProfileFile();
      } else {
        // print('No image selected.');
      }
    } catch (e) {
      //print('Error picking image: $e');
    }
  }

  Future<void> pickBackImageFromGallery() async {
    final ImagePicker picker = ImagePicker();

    try {
      backPickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50, // Adjust the image quality as needed
      );
      if (backPickedFile != null) {
        selectedBackImage.value = File(backPickedFile!.path);
        postBackFile();
      } else {
        // print('No image selected.');
      }
    } catch (e) {
      //print('Error picking image: $e');
    }
  }

  Future<void> pickFrontImageFromGallery() async {
    final ImagePicker picker = ImagePicker();

    try {
      frontPickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50, // Adjust the image quality as needed
      );
      if (frontPickedFile != null) {
        selectedFrontImage.value = File(frontPickedFile!.path);
        postFrontFile();
      } else {
        // print('No image selected.');
      }
    } catch (e) {
      //print('Error picking image: $e');
    }
  }

  Future<void> pickWorkingImageFromGallery() async {
    final ImagePicker picker = ImagePicker();

    try {
      workingPickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50, // Adjust the image quality as needed
      );
      if (workingPickedFile != null) {
        selectedWorkingImage.value = File(workingPickedFile!.path);
        postWorkingFile();
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
      required BuildContext context,
      required String name,
      required String description,
      required String category,
      required String address,
      required String location,
      required List<String> fileIds,
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
        files: fileIds,
        location: location.toString(),
        openingHours: openingHours,
        rate: rate.toString());

    print(id);
    print(StaticData.accessToken);
    print(jsonEncode(model));

    try {
      isLoading.value = true;
      update();

      final response = await dio.put(
        "${ApiEndpoints.BASEURL + ApiEndpoints.SERVICE}$id/",
        data: jsonEncode(model),
      );
      //print(response.statusCode);
      if (response.statusCode == 200) {
        // showsnackbar("Service Update Successfully");
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const AnimationDialog(
                  text: 'Successfully Added !',
                )).then((value) => Get.back());
      }
    } on SocketException catch (e) {
      showSnackBar("Error: Check Internet Connection", true);

      print("SocketException: $e");
    } catch (e) {
      showSnackBar("Failed to Update: Try again", true);

      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> postProfileFile() async {
    FileModel files = FileModel();
    // profileUploading.value = true;
    update();
    dio.options.headers['Authorization'] = 'Bearer ${StaticData.accessToken}';
    dio.options.headers['Content-Type'] = 'multipart/form-data';

    try {
      await profilePickedFile!.readAsBytes().then((imageBytes) async {
        deo.FormData data = deo.FormData.fromMap(({
          "file": deo.MultipartFile.fromBytes(imageBytes,
              filename:
                  'profile_img.${selectedProfileImage.value!.path.split('.').last}')
        }));

        await dio
            .post(ApiEndpoints.BASEURL + ApiEndpoints.SERVICE_FILE, data: data)
            .then((value) {
          files = FileModel.fromJson(value.data);
          profileFileId = files.id!;
          // print(profileFileId);
          showSnackBar("Image Upload Successfully");
          update();
        });
      });
    } on SocketException catch (_) {
      showSnackBar("failed to upload: check internet connection", true);
    } catch (e) {
      showSnackBar("failed to upload: file already exist", true);
    } finally {
      // profileUploading.value = false;
      update();
    }
  }

  Future<void> postFrontFile() async {
    FileModel files = FileModel();

    update();
    dio.options.headers['Authorization'] = 'Bearer ${StaticData.accessToken}';
    dio.options.headers['Content-Type'] = 'multipart/form-data';

    try {
      await frontPickedFile!.readAsBytes().then((imageBytes) async {
        deo.FormData data = deo.FormData.fromMap(({
          "file": deo.MultipartFile.fromBytes(imageBytes,
              filename:
                  'front_img.${selectedFrontImage.value!.path.split('.').last}')
        }));

        await dio
            .post(ApiEndpoints.BASEURL + ApiEndpoints.SERVICE_FILE, data: data)
            .then((value) {
          //print("file response ${value.data}");
          files = FileModel.fromJson(value.data);
          // frontFileId = files.id!;
          GlobalVariable.serviceModel.files![1].file = files.file;
          // print(frontFileId);
          showSnackBar("Image Upload Successfully");
          update();
        });
      });
    } on SocketException catch (_) {
      showSnackBar("failed to upload: check internet connection", true);
    } catch (e) {
      showSnackBar("failed to upload: file already exist", true);
    } finally {
      update();
    }
  }

  Future<void> postBackFile() async {
    FileModel files = FileModel();
    update();
    dio.options.headers['Authorization'] = 'Bearer ${StaticData.accessToken}';
    dio.options.headers['Content-Type'] = 'multipart/form-data';

    try {
      await backPickedFile!.readAsBytes().then((imageBytes) async {
        deo.FormData data = deo.FormData.fromMap(({
          "file": deo.MultipartFile.fromBytes(imageBytes,
              filename:
                  'back_img.${selectedBackImage.value!.path.split('.').last}')
        }));

        await dio
            .post(ApiEndpoints.BASEURL + ApiEndpoints.SERVICE_FILE, data: data)
            .then((value) {
          //print("file response ${value.data}");
          files = FileModel.fromJson(value.data);
          // backFileId = files.id!;
          GlobalVariable.serviceModel.files![2].file = files.file;
          // print(backFileId);
          showSnackBar("Image Upload Successfully");
          update();
        });
      });
    } on SocketException catch (_) {
      showSnackBar("failed to upload: check internet connection", true);
    } catch (e) {
      showSnackBar("failed to upload: file already exist", true);
    } finally {
      update();
    }
  }

  Future<void> postWorkingFile() async {
    FileModel files = FileModel();

    update();
    dio.options.headers['Authorization'] = 'Bearer ${StaticData.accessToken}';
    dio.options.headers['Content-Type'] = 'multipart/form-data';

    try {
      await workingPickedFile!.readAsBytes().then((imageBytes) async {
        deo.FormData data = deo.FormData.fromMap(({
          "file": deo.MultipartFile.fromBytes(imageBytes,
              filename:
                  'working_img.${selectedWorkingImage.value!.path.split('.').last}')
        }));

        await dio
            .post(ApiEndpoints.BASEURL + ApiEndpoints.SERVICE_FILE, data: data)
            .then((value) {
          //print("file response ${value.data}");
          files = FileModel.fromJson(value.data);
          // workingFileId = files.id!;
          GlobalVariable.serviceModel.files![3].file = files.file;
          // print(workingFileId);
          showSnackBar("Image Upload Successfully");
          update();
        });
      });
    } on SocketException catch (_) {
      showSnackBar("failed to upload: check internet connection", true);
    } catch (e) {
      showSnackBar("failed to upload: file already exist", true);
    } finally {
      update();
    }
  }

  ///
  ///
  ///
  Future<List<MyServicesRespModel>> fetchServices() async {
    dio.options.headers['Authorization'] = 'Bearer ${StaticData.accessToken}';
    try {
      final response =
          await dio.get(ApiEndpoints.BASEURL + ApiEndpoints.SERVICE);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = response.data;
        List<MyServicesRespModel> services = jsonResponse
            .map((data) => MyServicesRespModel.fromJson(data))
            .toList();
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
      final response =
          await dio.get(ApiEndpoints.BASEURL + ApiEndpoints.USER_BOOKING);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data
            .map((item) => MyServicesBookingModel.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Failed to load data: $error');
    }
  }

  Future<void> deleteServices({required id, required context}) async {
    dio.options.headers['accept'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer ${StaticData.accessToken}';

    try {
      isLoading.value = true;
      update([2]);
      final response = await dio
          .delete("${ApiEndpoints.BASEURL + ApiEndpoints.SERVICE}$id/");
      print("status code ${response.statusCode}");
      if (response.statusCode == 200) {
        await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const AnimationDialog(
                  text: '',
                ));
        await fetchServices();
        update();
        Navigator.pop(context);
      }
    } catch (e) {
      showSnackBar("Active service cannot deleted", true);
      Navigator.pop(context);
    } finally {
      isLoading.value = false;
      update([2]);
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
    firstWord +=
        words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
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
