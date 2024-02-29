import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/modules/dashboard/bookings/views/bookings_view.dart';
import 'package:home_brigadier/app/modules/dashboard/home/controllers/home_controller.dart';
import 'package:home_brigadier/app/modules/dashboard/home/views/home_view.dart';
import 'package:home_brigadier/app/modules/dashboard/profile/help_center/FAQ/views/faq_view.dart';
import 'package:home_brigadier/app/modules/dashboard/profile/views/profile_view.dart';
import 'package:home_brigadier/utils/isolate_manager.dart';

import '../start_earning/views/start_earning_view.dart';

class DashboardController extends GetxController {
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
    const BookingsView(),
    const StartEarningView(),
    const FaqView(),
    //CalenderView(),
    // InboxView(),
    const ProfileView()
  ];
}
