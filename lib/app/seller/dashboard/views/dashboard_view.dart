// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/seller/dashboard/profile/user_profile/controllers/jobs_controller.dart';
import 'package:home_brigadier/app/user/dashboard/home/controllers/home_controller.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/consts/media_query.dart';

import '../../../../generated/locales.g.dart';
import '../controllers/dashboard_controller.dart';

class SellerDashboardView extends GetView<SellerDashboardController> {
  const SellerDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SellerDashboardController>(
        init: SellerDashboardController(),
        builder: (builderContext) {
          return PopScope(
            canPop: false,
            onPopInvoked: (didPop) {
              if (!didPop) {
                if (MyJobsController.to.tabController.index == 1) {
                  MyJobsController.to.tabController.animateTo(0);
                } else {
                  showBackDialog(context);
                }
              }
            },
            child: Scaffold(
              ///body with pageBuilder
              body: controller.pages[controller.currentIndex.value],

              /// bottomNavigationBar
              bottomNavigationBar: GetBuilder<HomeController>(builder: (obj) {
                return BottomNavigationBar(
                  selectedLabelStyle: TextStyle(
                      overflow: TextOverflow.visible, fontSize: mediaQueryHeight(context) * 0.015),
                  unselectedLabelStyle: TextStyle(
                      overflow: TextOverflow.visible, fontSize: mediaQueryHeight(context) * 0.015),
                  type: BottomNavigationBarType.fixed,
                  fixedColor: AppColor.secondary,
                  currentIndex: controller.currentIndex.value,
                  onTap: (index) => controller.changePage(index),
                  items: [
                    // BottomNavigationBarItem(

                    //   icon: SvgPicture.asset("assets/icons/ic_home_outlined.svg"),
                    //   activeIcon: SvgPicture.asset("assets/icons/ic_home_filled.svg"),
                    //   label: LocaleKeys.dashboard_items_home.tr,
                    // ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: SizedBox(
                            height: 18,
                            child: SvgPicture.asset("assets/icons/ic_booking_outlined.svg")),
                      ),
                      activeIcon: Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: SizedBox(
                            height: 18,
                            child: SvgPicture.asset("assets/icons/ic_booking_filled.svg")),
                      ),
                      label: LocaleKeys.user_profile_item_jobs.tr,
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: const Icon(
                          size: 20,
                          Icons.currency_exchange,
                        ),
                      ),
                      activeIcon: Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: const Icon(
                          size: 20,
                          Icons.currency_exchange,
                          color: AppColor.secondary,
                        ),
                      ),
                      label: LocaleKeys.dashboard_items_start_earning.tr,
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: const Icon(
                          size: 20,
                          Icons.home_repair_service,
                        ),
                      ),
                      activeIcon: Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: const Icon(
                          size: 20,
                          Icons.home_repair_service,
                          color: AppColor.secondary,
                        ),
                      ),
                      label: LocaleKeys.home_screen_items_services.tr,
                    ),
                    // BottomNavigationBarItem(
                    //   icon: const Icon(Icons.question_mark),
                    //   activeIcon: const Icon(Icons.question_mark),
                    //   label: LocaleKeys.dashboard_items_faq.tr,
                    // ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: SvgPicture.asset("assets/icons/ic_profile_circled_outlined.svg"),
                      ),
                      activeIcon: Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: SvgPicture.asset("assets/icons/ic_profile_circled_filled.svg"),
                      ),
                      label: LocaleKeys.dashboard_items_profile.tr,
                    ),
                  ],
                );
              }),
            ),
          );
        });
  }
}

void showBackDialog(context) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(LocaleKeys.exit_dialog_exit.tr),
        content: Text(
          LocaleKeys.exit_dialog_verify.tr,
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: Text(LocaleKeys.exit_dialog_cancel.tr),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: Text(LocaleKeys.exit_dialog_ok.tr),
            onPressed: () {
              Navigator.pop(context);
              if (Platform.isAndroid) {
                SystemNavigator.pop(animated: true);
              } else if (Platform.isIOS) {
                exit(0);
              }
            },
          ),
        ],
      );
    },
  );
}
