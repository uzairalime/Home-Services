import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/seller/dashboard/profile/help_center/FAQ/views/faq_view.dart';
import 'package:home_brigadier/app/user/dashboard/bookings/views/bookings_view.dart';
import 'package:home_brigadier/app/user/dashboard/home/controllers/home_controller.dart';
import 'package:home_brigadier/app/user/dashboard/home/views/home_view.dart';
import 'package:home_brigadier/app/user/dashboard/profile/views/profile_view.dart';
import 'package:home_brigadier/consts/static_data.dart';
import 'package:home_brigadier/utils/isolate_manager.dart';

class UserDashboardController extends GetxController {
  var a = Get.put(HomeController());

  /// bottomNavigationBar Index
  var currentIndex = 0.obs;
  IsolateManager isolateManager = IsolateManager();

  /// change bottomNavigationBar item
  void changePage(int index) {
    currentIndex.value = index;
    update();
  }

  @override
  void onInit() {
    isolateManager.isolateEntryPoint();
    IsolateManager.refreshToken();
    super.onInit();
  }

  final List<Widget> pages = [
    const HomeView(),
    if (StaticData.refreshToken.isNotEmpty) BookingsView(),
    const FaqView(),
    const UserProfileView()
  ];
}
