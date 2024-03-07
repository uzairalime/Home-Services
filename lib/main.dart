import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:home_brigadier/app/routes/app_pages.dart';
import 'package:home_brigadier/connectivity_service.dart';
import 'package:home_brigadier/splash_screen.dart';
import 'package:home_brigadier/theme/theme.dart';
import 'package:home_brigadier/utils/shared_preferance.dart';

import 'generated/locales.g.dart';

String localeValue() => GetStorage().read(SharedPreference.langKey) ?? "English";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  ConnectivityService.connectivity();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
  ));

  log("Start user Role ${GetStorage().read(SharedPreference.roleKey)}");

  runApp(
    GetMaterialApp(
      translationsKeys: AppTranslation.translations,
      locale: localeValue() == "العربية" ? const Locale('ar', 'SA') : const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      title: "home_brigadier",
      theme: Themes.lightTheme,
      themeMode: ThemeMode.light,
      getPages: AppPages.routes,
      home: const SplashScreen(),
    ),
  );
}
