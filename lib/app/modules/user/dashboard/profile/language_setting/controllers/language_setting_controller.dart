import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:home_brigadier/utils/shared_preferance.dart';

class LanguageSettingController extends GetxController {
  static LanguageSettingController get to => Get.find();
  RxString selectedLanguage = "".obs;
  late GetStorage getStorage;

  List<String> languages = ["English", "العربية"];

  @override
  void onInit() {
    getStorage = GetStorage();
    selectedLanguage.value = getStorage.read(SharedPreference.langKey) ?? "English";
    update();
    super.onInit();
  }

  Future<void> setSelectedLanguage(String? language) async {
    selectedLanguage.value = language!;

    if (selectedLanguage.value == "العربية") {
      await getStorage.write(SharedPreference.langKey, language);
      changeLocal("ar", "SA");
    } else {
      await getStorage.write(SharedPreference.langKey, language);
      changeLocal("en", "US");
    }
  }

  void changeLocal(p1, p2) {
    var local = Locale(p1, p2);
    Get.updateLocale(local);
  }
}
