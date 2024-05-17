import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:home_brigadier/services/apis/api_helper.dart';
import 'package:home_brigadier/utils/shared_preferance.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../consts/static_data.dart';
import '../../../../../../model/user_model.dart';
import '../../../../../../services/apis/api_endpoints.dart';

class SellerProfileController extends GetxController {
  late ApiHelper apiHelper;
  Dio dio = Dio();
  RxString userName = ''.obs;
  RxString firstName = ''.obs;
  RxString mobile = ''.obs;
  RxString imgPath = ''.obs;
  RxList files = [].obs;
  RxList services = [].obs;
  RxBool isLoading = true.obs;
  GetStorage getStorage = GetStorage();
  bool isSeller = false;
  final ImagePicker _picker = ImagePicker();
  final Rx<XFile?> _pickedFile = Rx<XFile?>(null);

  XFile? get pickedFile => _pickedFile.value;
  String path = '';

  pickImage() async {
    _pickedFile.value = await _picker.pickImage(source: ImageSource.gallery);

    if (_pickedFile.value != null) {
      path = _pickedFile.value!.path;
      update();
    }
  }

  @override
  void onInit() {
    checkRole();
    apiHelper = ApiHelper();
    super.onInit();
  }

  Future<void> getUserInfo() async {
    dio.options.headers['Authorization'] = 'Bearer ${StaticData.accessToken}';

    try {
      print(StaticData.accessToken);

      var response = await dio.get(ApiEndpoints.BASEURL + ApiEndpoints.IM);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = response.data;

        // Extracting user information
        userName.value = jsonData['username'];
        firstName.value = jsonData['first_name'] ?? "";
        mobile.value = jsonData['mobile'] ?? "";

        var servicesList = jsonData['services'] as List;
        services.clear();
        services.value =
            servicesList.map((service) => Service.fromJson(service)).toList();

        // Extracting files
        files.clear();
        for (var service in services) {
          for (var file in service.files) {
            files.add(file.file);
          }
        }

        // Printing extracted information
        print('Username: $userName');
        print('First Name: $firstName');
        print('Mobile: $mobile');
        print(' ${files[0]}');
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error retrieving data: $error');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkRole() async {
    await SharedPreference.getRole();
    log("profile role ${StaticData.role}");

    if (StaticData.role == 'seller') {
      isSeller = true;
      log(isSeller.toString());
      update();
    } else if (StaticData.role == "buyer") {
      isSeller = false;
      log(isSeller.toString());

      update();
    }
  }
}

class SettingList {
  const SettingList(
      {required this.leading, required this.title, this.trailing});

  final Widget leading;
  final String title;
  final Widget? trailing;
}
