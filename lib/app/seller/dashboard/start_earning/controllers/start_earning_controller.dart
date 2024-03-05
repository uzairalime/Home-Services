import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart' as deo;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/seller/dashboard/start_earning/controllers/service_post.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../consts/const.dart';
import '../../../../../consts/static_data.dart';
import '../../../../../generated/locales.g.dart';
import '../../../../../model/user_services_models/my_services_resp_model.dart';
import '../../../../../services/apis/toast.dart';
import '../../../../user/dashboard/home/all_services/selected_category/category_item/house_cleaning/controllers/booking_controller.dart';
import '../../profile/user_profile/controllers/user_profile_controller.dart';

class StartEarningController extends GetxController {
  TextEditingController villaController = TextEditingController();
  ScrollController scrollController = ScrollController();
  final ImagePicker picker = ImagePicker();

  var weekdays = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"];
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
              location: cPosition)
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
              filename: 'profile_img.${selectedProfileImage.value!.path.split('.').last}')
        }));

        await dio.post("https://homebrigadier.fly.dev/api/service/file/", data: data).then((value) {
          //print("file response ${value.data}");
          files = RespFiles.fromJson(value.data);
          profileFileId = files.id!;
          print("profileFileId $profileFileId");
          showsnackbar("Image Upload Successfully");
        });
      });
    } on SocketException catch (_) {
      showsnackbar("failed to upload: check internet connection");
    } catch (e) {
      showsnackbar("failed to upload: file already exist");
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
              filename: 'working_img.${selectedworkingImage.value!.path.split('.').last}')
        }));

        await dio.post("https://homebrigadier.fly.dev/api/service/file/", data: data).then((value) {
          //print("file response ${value.data}");
          files = RespFiles.fromJson(value.data);
          workingFileId = files.id!;
          print("workingFileId $workingFileId");
          showsnackbar("Image Upload Successfully");
        });
      });
    } on SocketException catch (_) {
      showsnackbar("failed to upload: check internet connection");
    } catch (e) {
      showsnackbar("failed to upload: file already exist");
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
              filename: 'front_img.${selectedFrontImage.value!.path.split('.').last}')
        }));

        await dio.post("https://homebrigadier.fly.dev/api/service/file/", data: data).then((value) {
          //print("file response ${value.data}");
          files = RespFiles.fromJson(value.data);
          frontFileId = files.id!;
          print("frontFileId $frontFileId");
          showsnackbar("Image Upload Successfully");
        });
      });
    } on SocketException catch (_) {
      showsnackbar("failed to upload: check internet connection");
    } catch (e) {
      showsnackbar("failed to upload: file already exist");
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
              filename: 'back_img.${selectedBackImage.value!.path.split('.').last}')
        }));

        await dio.post("https://homebrigadier.fly.dev/api/service/file/", data: data).then((value) {
          //print("file response ${value.data}");
          files = RespFiles.fromJson(value.data);
          backFileId = files.id!;
          print("backFileId $backFileId");
          showsnackbar("Image Upload Successfully");
        });
      });
    } on SocketException catch (_) {
      showsnackbar("failed to upload: check internet connection");
    } catch (e) {
      showsnackbar("failed to upload: file already exist");
    } finally {
      backUploading.value = false;
      update();
    }
  }

  clearController() {
    nameController.clear();
    descController.clear();
    selectedCategory = '';
    villaController.clear();
    addressController.clear();
    rateController.clear();
    selectedFrom.value = '';
    selectedTill.value = '';
  }
}
