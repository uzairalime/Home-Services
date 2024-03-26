import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/seller/dashboard/bookings/completed_view.dart';
import 'package:home_brigadier/app/seller/dashboard/bookings/upcoming_view.dart';
import 'package:home_brigadier/app/seller/dashboard/profile/user_profile/controllers/jobs_controller.dart';
import 'package:home_brigadier/consts/media_query.dart';
import 'package:home_brigadier/generated/locales.g.dart';

import '../../../../../../consts/app_color.dart';
import '../../../../../../widget/cText.dart';

class MyJobsView extends StatefulWidget {
  const MyJobsView({super.key});

  @override
  State<MyJobsView> createState() => _MyJobsViewState();
}

class _MyJobsViewState extends State<MyJobsView> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyJobsController());
    final titleSmall = Theme.of(context).textTheme.titleSmall!.fontSize;
    controller.tabController = TabController(length: 2, vsync: this);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            leading: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/icons/ic_launcher_icon.png")),
                  borderRadius: BorderRadius.all(Radius.circular(6))),
            ),
            title: CText(
                text: LocaleKeys.user_profile_item_jobs.tr,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontsize: mediaQueryHeight(context) * 0.025),
            bottom: TabBar(
                controller: controller.tabController,
                labelStyle: TextStyle(fontSize: titleSmall, fontWeight: FontWeight.bold),
                unselectedLabelStyle: TextStyle(fontSize: titleSmall, color: AppColor.grey),
                padding: EdgeInsets.symmetric(horizontal: mediaQueryWidth(context) * 0.05),
                automaticIndicatorColorAdjustment: true,
                indicatorWeight: 3,
                tabs: [
                  Tab(text: LocaleKeys.user_profile_item_upcoming.tr),
                  Tab(text: LocaleKeys.user_profile_item_completed.tr),
                ])),
        body: TabBarView(
            physics: const BouncingScrollPhysics(),
            controller: controller.tabController,
            children: const [UpcomingView(), CompletedView()]),
      ),
    );
  }
}
