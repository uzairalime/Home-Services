import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/seller/dashboard/bookings/completed_view.dart';
import 'package:home_brigadier/app/seller/dashboard/bookings/upcoming_view.dart';
import 'package:home_brigadier/app/seller/dashboard/profile/user_profile/controllers/jobs_controller.dart';
import 'package:home_brigadier/consts/media_query.dart';
import 'package:home_brigadier/generated/locales.g.dart';

import '../../../../../../consts/app_color.dart';
import '../../../../../../widget/cText.dart';

class MyJobsView extends GetView<MyJobsController> {
  const MyJobsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final titleMedium = Theme.of(context).textTheme.titleMedium!.fontSize;
    final txtTheme = Theme.of(context).textTheme.titleMedium!.color;
    //  final txtTheme = Theme.of(context).textTheme.titleMedium!.color;
    final titleSmall = Theme.of(context).textTheme.titleSmall!.fontSize;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            leading: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/icons/ic_launcher_icon.png")),
                  borderRadius: BorderRadius.all(Radius.circular(6))),
            ),
            title: CText(
                text: LocaleKeys.user_profile_item_jobs.tr,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontsize: mediaQueryHeight(context) * 0.025),
            bottom: TabBar(
                labelStyle: TextStyle(
                    fontSize: titleSmall, fontWeight: FontWeight.bold),
                unselectedLabelStyle:
                    TextStyle(fontSize: titleSmall, color: AppColor.grey),
                padding: EdgeInsets.symmetric(
                    horizontal: mediaQueryWidth(context) * 0.05),
                automaticIndicatorColorAdjustment: true,
                indicatorWeight: 3,
                tabs: [

                  Tab(text: LocaleKeys.user_profile_item_completed.tr),
                  Tab(text: LocaleKeys.user_profile_item_upcoming.tr),

                ])),
        body: const TabBarView(children: [CompletedView(), UpcomingView()]),
      ),
    );
  }
}
