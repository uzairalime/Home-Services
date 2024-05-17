import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/isolate_manager.dart';
import '../../../user/dashboard/home/controllers/home_controller.dart';
import '../jobs/views/jobs_view.dart';
import '../profile/views/profile_view.dart';
import '../services/views/services_view.dart';
import '../start_earning/views/start_earning_view.dart';

class SellerDashboardController extends GetxController {
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
    const JobsView(),
    const StartEarningView(),
    const MyServicesView(),
    const SellerProfileView(),
  ];
}
