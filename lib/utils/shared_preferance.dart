// ignore_for_file: avoid_print

import 'package:get_storage/get_storage.dart';
import 'package:home_brigadier/consts/static_data.dart';

class SharedPreference {
  static GetStorage getStorage = GetStorage();
  static String accessKey = 'accessKey';
  static String refreshKey = 'refreshKey';
 static String rolekey = 'rolekey';
  // static String firstNameKey = 'firstNameKey';
  // static String lastNameKey = 'lastNameKey';
  // static String mobileKey = 'mobileKey';
  static String isNewUserKey = 'isNewUserKey';
  static String langKey = 'langKey';

  static storeUserPreference(
      {
       String? role,
      // String? firstName,
      // String? lastName,
      // String? mobile,
      access,
      refresh}) {
    getStorage.write(accessKey, access);
    getStorage.write(refreshKey, refresh);
     getStorage.write(rolekey, role);
    // getStorage.write(firstNameKey, firstName);
    // getStorage.write(lastNameKey, lastName);
    // getStorage.write(mobileKey, mobile);

    /// store data to Static_Data
    StaticData.accessToken = access;
    StaticData.refreshToken = refresh;
    // StaticData.userName = username ?? '';
    // StaticData.firstName = firstName ?? '';
    // StaticData.lastName = lastName ?? '';
    // StaticData.mobile = mobile ?? '';
  }

  static clearUser() {
    getStorage.remove(accessKey);
    getStorage.remove(refreshKey);
     getStorage.remove(rolekey);
    // getStorage.remove(firstNameKey);
    // getStorage.remove(lastNameKey);
    // getStorage.remove(mobileKey);
  }

  static getToken() {
    print("getting token from shredPreference");
    String? accessToken = getStorage.read(accessKey);
    String? refreshToken = getStorage.read(refreshKey);
    StaticData.accessToken = accessToken ?? '';
    StaticData.refreshToken = refreshToken ?? '';
  }

  static isNewUser() {
    getStorage.write(isNewUserKey, false);
  }
}
