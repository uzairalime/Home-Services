import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:home_brigadier/app/default_screen.dart';
import 'package:home_brigadier/app/routes/app_pages.dart';
import 'package:home_brigadier/utils/isolate_manager.dart';
import 'package:home_brigadier/utils/shared_preferance.dart';

import 'consts/static_data.dart';

class ConnectivityService {
  static final getStorage = GetStorage();
  static connectivity() {
    Connectivity().onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        Get.to(() => const DefaultScreen());
      }
    });
  }

  static checkInternetConnectivity({required AnimationController controller}) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          ConnectivityService.checkUserStatus();
        }
      });
    }
  }

  static checkUserStatus() async {
    var isNewUser = await getStorage.read("isNewUserKey");
    if (isNewUser != null || isNewUser == true) {
      SharedPreference.getToken();
      if (kDebugMode) {
        print("stored token is returned ${StaticData.refreshToken}");
      }
      if (StaticData.refreshToken.isNotEmpty) {
        int refreshTokenResult = await IsolateManager.refreshToken();
        if (refreshTokenResult == 200) {
          Get.offAndToNamed(Routes.DASHBOARD);
        } else {
          Get.offAndToNamed(Routes.EMAIL_LOGIN);
        }
      } else {
        Get.offAndToNamed(Routes.EMAIL_LOGIN);
      }
    } else {
      Get.offAndToNamed(Routes.WELCOME);
    }
  }
}
