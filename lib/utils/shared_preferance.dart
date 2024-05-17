// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:home_brigadier/consts/static_data.dart';

class SharedPreference {
  static GetStorage getStorage = GetStorage();
  static String accessKey = 'accessKey';
  static String refreshKey = 'refreshKey';
  static String roleKey = 'roleKey';
  // static String firstNameKey = 'firstNameKey';
  // static String lastNameKey = 'lastNameKey';
  // static String mobileKey = 'mobileKey';
  static String isNewUserKey = 'isNewUserKey';
  static String langKey = 'langKey';

  static storeRole({role}) {
    getStorage.write(roleKey, role);
    StaticData.role = role;
  }

  static storeToken({access, refresh}) {
    getStorage.write(accessKey, access);
    getStorage.write(refreshKey, refresh);

    /// store data to Static_Data
    StaticData.accessToken = access;
    StaticData.refreshToken = refresh;
  }

  static getRole() async {
    String? role = getStorage.read(roleKey);
    log("current role ${StaticData.role}");
    StaticData.role = role ?? '';
  }

  static getToken() {
    print("getting token from shredPreference");
    String? accessToken = getStorage.read(accessKey);
    String? refreshToken = getStorage.read(refreshKey);
    StaticData.accessToken = accessToken ?? '';
    StaticData.refreshToken = refreshToken ?? '';
  }

  static clearRole() {
    getStorage.remove(roleKey);
    StaticData.role = '';
  }

  static clearToken() {
    getStorage.remove(accessKey);
    getStorage.remove(refreshKey);
  }

  static isNewUser() {
    getStorage.write(isNewUserKey, false);
  }
}
