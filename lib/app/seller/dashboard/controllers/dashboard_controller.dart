import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/isolate_manager.dart';
import '../../../user/dashboard/home/controllers/home_controller.dart';
import '../bookings/views/bookings_view.dart';
import '../profile/help_center/FAQ/views/faq_view.dart';
import '../profile/views/profile_view.dart';
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
    const BookingsView(),
    const StartEarningView(),
    const FaqView(),
    const SellerProfileView()
  ];
}
