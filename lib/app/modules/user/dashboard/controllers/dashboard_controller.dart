import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/modules/user/dashboard/profile/views/profile_view.dart';
import 'package:home_brigadier/utils/isolate_manager.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../seller/dashboard/profile/help_center/FAQ/views/faq_view.dart';
import '../home/controllers/home_controller.dart';
import '../home/views/home_view.dart';
import '../my_bookings/views/my_bookings_view.dart';

class UserDashboardController extends GetxController {
  static UserDashboardController get to => Get.find();

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
    ShowCaseWidget(
      builder: Builder(builder: (_) => const HomeView()),
    ),
    const MyBookingsView(),
    const FaqView(),
    const UserProfileView()
  ];
}
