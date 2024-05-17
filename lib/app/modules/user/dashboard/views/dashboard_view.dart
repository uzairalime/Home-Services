import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/consts/media_query.dart';

import '../../../../../generated/locales.g.dart';
import '../controllers/dashboard_controller.dart';
import '../home/controllers/home_controller.dart';

class UserDashboardView extends GetView<UserDashboardController> {
  const UserDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserDashboardController());
    return GetBuilder<UserDashboardController>(
        init: UserDashboardController(),
        builder: (builderContext) {
          return Scaffold(
            ///body with pageBuilder
            body: controller.pages[controller.currentIndex.value],

            /// bottomNavigationBar
            bottomNavigationBar: GetBuilder<HomeController>(builder: (obj) {
              return BottomNavigationBar(
                selectedLabelStyle: TextStyle(
                    overflow: TextOverflow.visible,
                    fontSize: mediaQueryHeight(context) * 0.015),
                unselectedLabelStyle: TextStyle(
                    overflow: TextOverflow.visible,
                    fontSize: mediaQueryHeight(context) * 0.015),
                type: BottomNavigationBarType.fixed,
                fixedColor: AppColor.secondary,
                currentIndex: controller.currentIndex.value,
                onTap: (index) => controller.changePage(index),
                items: [
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child:
                          SvgPicture.asset("assets/icons/ic_home_outlined.svg"),
                    ),
                    activeIcon: Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child:
                          SvgPicture.asset("assets/icons/ic_home_filled.svg"),
                    ),
                    label: LocaleKeys.dashboard_items_home.tr,
                  ),
// <<<<<<< hanan
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: SvgPicture.asset(
                          "assets/icons/ic_booking_outlined.svg"),
                    ),
                    activeIcon: Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: SvgPicture.asset(
                          "assets/icons/ic_booking_filled.svg"),
                    ),
                    label: LocaleKeys.dashboard_items_bookings.tr,
                  ),
// =======
//                   if (StaticData.refreshToken.isNotEmpty)
//                     BottomNavigationBarItem(
//                       icon: SvgPicture.asset(
//                           "assets/icons/ic_booking_outlined.svg"),
//                       activeIcon: SvgPicture.asset(
//                           "assets/icons/ic_booking_filled.svg"),
//                       label: LocaleKeys.dashboard_items_bookings.tr,
//                     ),
// >>>>>>> main
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.question_mark),
                    activeIcon: const Icon(Icons.question_mark),
                    label: LocaleKeys.dashboard_items_faq.tr,
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: SvgPicture.asset(
                          "assets/icons/ic_profile_circled_outlined.svg"),
                    ),
                    activeIcon: Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: SvgPicture.asset(
                          "assets/icons/ic_profile_circled_filled.svg"),
                    ),
                    label: LocaleKeys.dashboard_items_profile.tr,
                  ),
                ],
              );
            }),
          );
        });
  }
}
