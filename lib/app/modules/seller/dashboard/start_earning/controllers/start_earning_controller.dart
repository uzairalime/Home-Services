import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart' as deo;
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/modules/seller/dashboard/start_earning/controllers/service_post.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../consts/static_data.dart';
import '../../../../../../generated/locales.g.dart';
import '../../../../../../model/user_services_models/my_services_resp_model.dart';
import '../../../../../../services/apis/api_endpoints.dart';
import '../../../../../../services/apis/toast.dart';
import '../../../../user/dashboard/home/all_services/selected_category/category_item/house_cleaning/controllers/booking_controller.dart';
import '../../profile/user_profile/controllers/user_profile_controller.dart';

class StartEarningController extends GetxController {
  TextEditingController villaController = TextEditingController();
  ScrollController scrollController = ScrollController();
  final ImagePicker picker = ImagePicker();
  var latitude = '0'.obs;
  var longitude = '0'.obs;
  var isPermissionGranted = false.obs;

  var weekdays = [
    "monday",
    "tuesday",
    "wednesday",
    "thursday",
    "friday",
    "saturday",
    "sunday"
  ];
  final List<String> menuItems = [
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

  var selectedCategory;
  var selectedWeekdays = <String>['monday'].obs;
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

  XFile? profilePickedFile;
  Rx<File?> selectedProfileImage = Rx<File?>(null);

  XFile? frontPickedFile;
  Rx<File?> selectedFrontImage = Rx<File?>(null);

  XFile? backPickedFile;
  Rx<File?> selectedBackImage = Rx<File?>(null);

  XFile? workingPickedFile;
  Rx<File?> selectedworkingImage = Rx<File?>(null);

  deo.Dio dio = deo.Dio();
  String profileFileId = '';
  String workingFileId = '';
  String frontFileId = '';
  String backFileId = '';

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

  @override
  void onInit() {
    super.onInit();
    _getLocationPermission();
  }

  Future<void> pickProfileImage() async {
    try {
      profilePickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50, // Adjust the image quality as needed
      );
      if (profilePickedFile != null) {
        selectedProfileImage.value = File(profilePickedFile!.path);

        postProfilePic();
      } else {
        // print('No image selected.');
      }
    } catch (e) {
      //print('Error picking image: $e');
    }
  }

  Future<void> pickIdFrontImage() async {
    try {
      frontPickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50, // Adjust the image quality as needed
      );
      if (frontPickedFile != null) {
        selectedFrontImage.value = File(frontPickedFile!.path);

        postFrontPic();
      } else {
        // print('No image selected.');
      }
    } catch (e) {
      //print('Error picking image: $e');
    }
  }

  Future<void> pickIdBackImage() async {
    try {
      backPickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50, // Adjust the image quality as needed
      );
      if (backPickedFile != null) {
        selectedBackImage.value = File(backPickedFile!.path);

        postBackPic();
      } else {
        // print('No image selected.');
      }
    } catch (e) {
      //print('Error picking image: $e');
    }
  }

  Future<void> pickWorkingImage() async {
    try {
      workingPickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50, // Adjust the image quality as needed
      );
      if (workingPickedFile != null) {
        selectedworkingImage.value = File(workingPickedFile!.path);

        postWorkingPic();
      } else {
        // print('No image selected.');
      }
    } catch (e) {
      //print('Error picking image: $e');
    }
  }

  String extractHour(String hourString) {
    List<String> parts = hourString.split(' ');
    String hour = parts[0];
    return hour;
  }

  void selectFrom(String hour) {
    selectedFrom.value = hour;
  }

  void selectTill(String hour) {
    selectedTill.value = hour;
    update();
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
    selectedCategory = item;
  }

  void toggleSelection(String weekday) {
    if (selectedWeekdays.contains(weekday)) {
      selectedWeekdays.remove(weekday);
    } else {
      selectedWeekdays.add(weekday);
    }
    print(selectedWeekdays);
  }

  Future<void> addNewService(context) async {
    isLoading.value = true;
    update();
    try {
      await PostService.postMyService(
              context: context,
              name: nameController.text,
              description: descController.text,
              fileId: [profileFileId, frontFileId, backFileId, workingFileId],
              category: convertToCamelCase(selectedCategory),
              address: "${villaController.text}${addressController.text}",
              weekDays: selectedWeekdays,
              rate: rateController.text,
              from_hour: selectedFrom.value,
              to_hour: selectedTill.value,
              location: "$latitude , $longitude")
          .then((value) {
        clearController();
      });
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> postProfilePic() async {
    RespFiles files = RespFiles();
    profileUploading.value = true;
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
          //print("file response ${value.data}");
          files = RespFiles.fromJson(value.data);
          profileFileId = files.id!;
          print("profileFileId $profileFileId");
          showSnackBar("Image Upload Successfully");
        });
      });
    } on SocketException catch (_) {
      showSnackBar("failed to upload: check internet connection");
    } catch (e) {
      showSnackBar("failed to upload: file already exist");
    } finally {
      profileUploading.value = false;
      update();
    }
  }

  Future<void> postWorkingPic() async {
    RespFiles files = RespFiles();
    workingUploading.value = true;
    update();
    dio.options.headers['Authorization'] = 'Bearer ${StaticData.accessToken}';

    try {
      await workingPickedFile!.readAsBytes().then((imageBytes) async {
        deo.FormData data = deo.FormData.fromMap(({
          "file": deo.MultipartFile.fromBytes(imageBytes,
              filename:
                  'working_img.${selectedworkingImage.value!.path.split('.').last}')
        }));

        await dio
            .post(ApiEndpoints.BASEURL + ApiEndpoints.SERVICE_FILE, data: data)
            .then((value) {
          //print("file response ${value.data}");
          files = RespFiles.fromJson(value.data);
          workingFileId = files.id!;
          print("workingFileId $workingFileId");
          showSnackBar("Image Upload Successfully");
        });
      });
    } on SocketException catch (_) {
      showSnackBar("failed to upload: check internet connection");
    } catch (e) {
      showSnackBar("failed to upload: file already exist");
    } finally {
      workingUploading.value = false;
      update();
    }
  }

  Future<void> postFrontPic() async {
    RespFiles files = RespFiles();
    frontUploading.value = true;
    update();
    dio.options.headers['Authorization'] = 'Bearer ${StaticData.accessToken}';

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
          files = RespFiles.fromJson(value.data);
          frontFileId = files.id!;
          print("frontFileId $frontFileId");
          showSnackBar("Image Upload Successfully");
        });
      });
    } on SocketException catch (_) {
      showSnackBar("failed to upload: check internet connection");
    } catch (e) {
      showSnackBar("failed to upload: file already exist");
    } finally {
      frontUploading.value = false;
      update();
    }
  }

  Future<void> postBackPic() async {
    RespFiles files = RespFiles();
    backUploading.value = true;
    update();
    dio.options.headers['Authorization'] = 'Bearer ${StaticData.accessToken}';

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
          files = RespFiles.fromJson(value.data);
          backFileId = files.id!;
          print("backFileId $backFileId");
          showSnackBar("Image Upload Successfully");
        });
      });
    } on SocketException catch (_) {
      showSnackBar("failed to upload: check internet connection");
    } catch (e) {
      showSnackBar("failed to upload: file already exist");
    } finally {
      backUploading.value = false;
      update();
    }
  }

  Future<void> _getLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Handle denied permission
      isPermissionGranted.value = false;
    } else if (permission == LocationPermission.deniedForever) {
      // Handle denied forever permission
      isPermissionGranted.value = false;
    } else {
      isPermissionGranted.value = true;
      _getLocation();
    }
  }

  Future<void> _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude.value = position.latitude.toString();
      longitude.value = position.longitude.toString();

      print("$latitude, $longitude");
    } catch (e) {
      print('Error: $e');
    }
  }

  clearController() {
    selectedProfileImage = Rx<File?>(null);
    selectedFrontImage = Rx<File?>(null);
    selectedworkingImage = Rx<File?>(null);
    selectedProfileImage = Rx<File?>(null);
    selectedBackImage = Rx<File?>(null);
    nameController.clear();
    descController.clear();
    selectedCategory = '';
    villaController.clear();
    addressController.clear();
    selectedFrom.value = '';
    selectedTill.value = '';
    rateController.clear();
    selectedFrom.value = '';
    selectedTill.value = '';
    update();
  }
}
