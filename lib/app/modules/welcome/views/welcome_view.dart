import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/modules/welcome/views/page_builder.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/consts/media_query.dart';
import 'package:home_brigadier/user_role/user_role.dart';
import 'package:home_brigadier/utils/shared_preferance.dart';
import 'package:home_brigadier/widget/c_filled_btn.dart';

import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SizedBox(
                height: mediaQueryHeight(context),
                child: GetBuilder<WelcomeController>(
                    init: Get.put(WelcomeController()),
                    builder: (obj) {
                      return Stack(alignment: Alignment.center, children: [
                        SizedBox(
                            height: mediaQueryHeight(context) * 0.6,
                            width: mediaQueryWidth(context) * 0.95,
                            child: PageView(
                                controller: controller.pageController,
                                physics: const BouncingScrollPhysics(),
                                onPageChanged: (int page) {
                                  controller.onPageSwipe(page);
                                },
                                children: [
                                  WelcomeScreen(
                                      "We provide\n Professional Services \nat a friendly price",
                                      Image.asset(
                                          "assets/images/welcome_img1.png",
                                          fit: BoxFit.cover)),
                                  WelcomeScreen(
                                      "The Best Result\nand Your Satisfaction is\nour top priority",
                                      Image.asset(
                                          "assets/images/welcome_img2.png",
                                          fit: BoxFit.cover)),
                                  WelcomeScreen(
                                      "Let's make\nawesome changes\n to your home",
                                      Image.asset(
                                          "assets/images/welcome_img3.png",
                                          fit: BoxFit.cover)),
                                ])),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Obx(() => Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List.generate(
                                            3,
                                            (index) => PageIndicator(
                                                itemCount: 3,
                                                currentIndex: index)),
                                      ).marginOnly(bottom: 20),
                                      CButton(
                                          shadow: true,
                                          bgcolor: AppColor.secondary,
                                          btnheight: kToolbarHeight * 0.9,
                                          gradient: AppColor.box1,
                                          text: controller.currentPage.value
                                                  .isEqual(2)
                                              ? "Get Started"
                                              : "Next",
                                          ontab: () {
                                            controller.onPageChange();
                                            if (controller.currentPage.value
                                                .isEqual(2)) {
                                              SharedPreference.isNewUser();
                                              Get.off(const UserRoleView());
                                            }
                                          }).paddingSymmetric(horizontal: 20),
                                    ]))).paddingOnly(
                            bottom: mediaQueryHeight(context) * 0.04)
                      ]);
                    }))));
  }
}

class PageIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;

  const PageIndicator({
    super.key,
    required this.itemCount,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WelcomeController());

    return Container(
      height: 8,
      width: controller.currentPage.value == currentIndex ? 25 : 8,
      decoration: BoxDecoration(
          color: controller.currentPage.value == currentIndex
              ? AppColor.secondary
              : AppColor.grey,
          borderRadius: BorderRadius.circular(50)),
    ).paddingAll(4);
  }
}
