import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart' as deo;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/seller/dashboard/start_earning/controllers/service_post.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/house_cleaning/controllers/booking_controller.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../consts/const.dart';
import '../../../../../consts/static_data.dart';
import '../../../../../generated/locales.g.dart';
import '../../../../../model/user_services_models/my_services_resp_model.dart';
import '../../../../../services/apis/toast.dart';
import '../../profile/user_profile/controllers/user_profile_controller.dart';

class StartEarningController extends GetxController {
  TextEditingController villaController = TextEditingController();
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
  var selectedWeekdays = <String>['monday'].obs;
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

  final bookingController = BookingController();

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

  void onFromFocus(value) {
    fromFocus.value = value;
  }

  void onTillFocus(value) {
    tillFocus.value = value;
  }

  void onCategFocus(value) {
    categoryFocus.value = value;
  }

  void onRateFocus(value) {
    rateFocus.value = value;
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
    print(selectedWeekdays);
  }

  Future<void> postFile() async {
    RespFiles files = RespFiles();
    imgUploading.value = true;
    update();
    dio.options.headers['Authorization'] = 'Bearer ${StaticData.accessToken}';

    try {
      await pickedFile!.readAsBytes().then((imageBytes) async {
        deo.FormData data = deo.FormData.fromMap(({
          "file": deo.MultipartFile.fromBytes(imageBytes,
              filename: pickedFile!.path)
        }));

        await dio
            .post("https://homebrigadier.fly.dev/api/service/file/", data: data)
            .then((value) {
          //print("file response ${value.data}");
          files = RespFiles.fromJson(value.data);
          fileId = files.id!;
          print(fileId);
          showsnackbar("Image Upload Successfully");
        });
      });
    } on SocketException catch (_) {
      showsnackbar("failed to upload: check internet connection");
    } catch (e) {
      showsnackbar("failed to upload: file already exist");
    } finally {
      imgUploading.value = false;
      update();
    }
  }

  Future<void> addNewService(context) async {
    isLoading.value = true;
    update();
    try {
      await PostService.postMyService(
              context: context,
              name: nameController.text,
              description: descController.text,
              fileId: fileId,
              category: convertToCamelCase(selectedCategory.value),
              address: "${villaController.text}${addressController.text}",
              weekDays: selectedWeekdays,
              rate: rateController.text,
              from_hour: selectedFrom.value,
              to_hour: selectedTill.value,
              location: cPosition)
          .then((value) {
        clearController();
      });
    } finally {
      isLoading.value = false;
      update();
    }
  }

  clearController() {
    nameController.clear();
    descController.clear();
    fileId = '';
    selectedCategory.value = '';
    villaController.clear();
    addressController.clear();
    rateController.clear();
    selectedFrom.value = '';
    selectedTill.value = '';
  }
}
