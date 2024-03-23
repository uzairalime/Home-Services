import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:home_brigadier/app/default_screen.dart';
import 'package:home_brigadier/app/modules/login/email_login/views/email_login_view.dart';
import 'package:home_brigadier/app/user/dashboard/views/dashboard_view.dart';
import 'package:home_brigadier/user_role/user_role.dart';
import 'package:home_brigadier/utils/isolate_manager.dart';
import 'package:home_brigadier/utils/shared_preferance.dart';
import 'package:showcaseview/showcaseview.dart';

import 'app/routes/app_pages.dart';
import 'app/seller/dashboard/views/dashboard_view.dart';
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
    log("current role ${StaticData.role}");
    var isNewUser = await getStorage.read("isNewUserKey");

    ///
    if (isNewUser != null || isNewUser == true) {
      SharedPreference.getRole();

      log("now role ${StaticData.role}");

      ///
      if (StaticData.role.isEmpty) {
        Get.off(const UserRoleView());

        ///
      } else if (StaticData.role == "seller") {
        SharedPreference.getToken();

        ///
        log("stored token is returned ${StaticData.refreshToken}");
        if (StaticData.refreshToken.isNotEmpty) {
          int refreshTokenResult = await IsolateManager.refreshToken();
          if (refreshTokenResult == 200) {
            Get.offAll(
               const SellerDashboardView(),
              
            );
          } else {
            Get.offAll(() => const EmailLoginView(
                  role: 'seller',
                ));
          }
        } else {
          Get.offAll(() => const EmailLoginView(
                role: 'seller',
              ));
        }
      } else if (StaticData.role == "buyer") {
        SharedPreference.getToken();

        ///
        log("stored token is returned ${StaticData.refreshToken}");
        if (StaticData.refreshToken.isNotEmpty) {
          int refreshTokenResult = await IsolateManager.refreshToken();
          if (refreshTokenResult == 200) {
            Get.to(  const UserDashboardView(),
              );
          } else {
            Get.offAll(() =>   const UserDashboardView(),
              );
          }
        } else {
          Get.offAll(() =>  const UserDashboardView(),
              );
        }
      }

      // SharedPreference.getToken();
      // log("stored token is returned ${StaticData.refreshToken}");
      // if (StaticData.refreshToken.isNotEmpty) {
      //   int refreshTokenResult = await IsolateManager.refreshToken();
      //   if (refreshTokenResult == 200) {
      //     GetStorage _storage = GetStorage();
      //     StaticData.isLogin = true;
      //
      //     String role = await _storage.read("role");
      //     logger.d("role is ${role == "seller"}");
      //
      //     if (role == "seller") {
      //       Get.off(() => const SellerDashboardView());
      //     } else {
      //       Get.off(const UserDashboardView());
      //     }
      //   } else {
      //     Get.offAll(() => const UserRoleView());
      //   }
      // } else {
      //   Get.offAll(() => const UserRoleView());
      // }
    } else {
      Get.offAndToNamed(Routes.WELCOME);
    }
  }
}
