import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/seller/dashboard/profile/user_profile/views/bookings_view.dart';
import 'package:home_brigadier/consts/media_query.dart';
import 'package:home_brigadier/consts/static_data.dart';
import 'package:home_brigadier/generated/locales.g.dart';
import 'package:home_brigadier/widget/cText.dart';

import '../controllers/bookings_controller.dart';

class BookingsView extends GetView<BookingsController> {
  const BookingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme.titleMedium!.color;
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Center(child: Image.asset("assets/images/app_icon.jpg"))),
          ),
          title: CText(
              text: LocaleKeys.dashboard_items_bookings.tr,
              fontWeight: FontWeight.bold,
              color: txtTheme,
              fontsize: mediaQueryHeight(context) * 0.025),
        ),
        body: StaticData.refreshToken.isNotEmpty
            ? const MyBookingsView()
            : const Center(
                child: Text("No Bookings"),
              ));

    // GetBuilder<BookingsController>(
    //   init: Get.put(BookingsController()),
    //   builder: (builderContext) {
    //     return DefaultTabController(
    //         length: 3,
    //         child: Scaffold(
    //             appBar: AppBar(
    //                 leading: Container(
    //                     margin: const EdgeInsets.all(10),
    //                     padding: const EdgeInsets.all(8.0),
    //                     decoration: const BoxDecoration(
    //                         borderRadius:
    //                             BorderRadius.all(Radius.circular(12)),
    //                         color: AppColor.secondary),
    //                     child: SvgPicture.asset("assets/icons/ic_logo.svg")),
    //                 title: CText(
    //                     text: "My Bookings",
    //                     fontWeight: FontWeight.bold,
    //                     color: txtTheme,
    //                     fontsize: mediaQueryHeight(context) * 0.025),
    //                 actions: [
    //                   CIconBtn(
    //                       onPressed: () {},
    //                       child: SvgPicture.asset(
    //                           "assets/icons/ic_search.svg",
    //                           color: svgTheme)),
    //                   CIconBtn(
    //                       onPressed: () {},
    //                       child: SvgPicture.asset(
    //                           "assets/icons/ic_more_outlined.svg",
    //                           color: svgTheme))
    //                 ],
    //                 bottom: TabBar(
    //                     padding: EdgeInsets.symmetric(
    //                         horizontal: mediaQueryWidth(context) * 0.05),
    //                     automaticIndicatorColorAdjustment: true,
    //                     indicatorWeight: 3,
    //                     tabs: const [
    //                       Tab(text: 'Upcoming'),
    //                       Tab(text: 'Completed'),
    //                       Tab(text: 'Cancelled')
    //                     ])),
    //             body: const TabBarView(children: [
    //               UpcomingView(),
    //               CompletedView(),
    //               CancelledView()
    //             ])));
    //   });
  }
}
