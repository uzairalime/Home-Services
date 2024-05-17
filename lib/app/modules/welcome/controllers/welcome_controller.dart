import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class WelcomeController extends GetxController {
  PageController pageController = PageController();
  RxInt currentPage = 0.obs;

  onPageSwipe(int page) {
    currentPage.value = page;
    update();
  }

  onPageChange() {
    if (currentPage.value >= 2) {
      Get.toNamed(Routes.DASHBOARD);
    }
    pageController.nextPage(
        duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
  }
}
