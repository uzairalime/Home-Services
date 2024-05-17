import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../../../consts/media_query.dart';
import '../../../../../../../generated/locales.g.dart';
import '../../../../../../../widget/cText.dart';
import '../../../services/views/services_view.dart';
import '../controllers/user_profile_controller.dart';

class UserProfileView extends GetView<UserProfileController> {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme.titleMedium!.color;
    Get.put(UserProfileController());
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: CText(
              text: LocaleKeys.user_profile_item_services.tr,
              fontWeight: FontWeight.bold,
              color: txtTheme,
              fontsize: mediaQueryHeight(context) * 0.025),
        ),
        body: const MyServicesView());
  }
}

class ProfilePic extends StatelessWidget {
  const ProfilePic({super.key, required this.image});

  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CircleAvatar(
          backgroundImage: image, radius: mediaQueryWidth(context) * 0.13),
      Positioned(
          bottom: mediaQueryHeight(context) * 0.005,
          right: mediaQueryWidth(context) * 0.02,
          child: SvgPicture.asset(
              width: mediaQueryWidth(context) * 0.06,
              "assets/icons/ic_pic_edit.svg",
              fit: BoxFit.scaleDown))
    ]);
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:home_brigadier/app/seller/dashboard/profile/user_profile/views/jobs_view.dart';
// import 'package:home_brigadier/app/seller/dashboard/profile/user_profile/views/services_view.dart';
//
// import '../../../../../../consts/app_color.dart';
// import '../../../../../../consts/media_query.dart';
// import '../../../../../../generated/locales.g.dart';
// import '../../../../../../widget/cText.dart';
// import '../controllers/user_profile_controller.dart';
//
// class UserProfileView extends GetView<UserProfileController> {
//   const UserProfileView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final txtTheme = Theme.of(context).textTheme.titleMedium!.color;
//     final titleSmall = Theme.of(context).textTheme.titleSmall!.fontSize;
//     Get.put(UserProfileController());
//     return DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           appBar: AppBar(
//               centerTitle: true,
//               title: CText(
//                   text: LocaleKeys.user_profile_item_user_ptofile.tr,
//                   fontWeight: FontWeight.bold,
//                   color: txtTheme,
//                   fontsize: mediaQueryHeight(context) * 0.025),
//               bottom: TabBar(
//                   labelStyle: TextStyle(
//                       fontSize: titleSmall, fontWeight: FontWeight.bold),
//                   unselectedLabelStyle:
//                       TextStyle(fontSize: titleSmall, color: AppColor.grey),
//                   padding: EdgeInsets.symmetric(
//                       horizontal: mediaQueryWidth(context) * 0.05),
//                   automaticIndicatorColorAdjustment: true,
//                   indicatorWeight: 3,
//                   tabs: [
//                     Tab(text: LocaleKeys.user_profile_item_jobs.tr),
//                     Tab(text: LocaleKeys.user_profile_item_services.tr),
//                     // Tab(text: LocaleKeys.user_profile_item_booking.tr)
//                   ])),
//           body: const TabBarView(children: [
//             MyJobsView(), MyServicesView(),
//
//             //  MyBookingsView()
//           ]),
//         ));
//   }
// }
//
// class ProfilePic extends StatelessWidget {
//   const ProfilePic({super.key, required this.image});
//
//   final ImageProvider image;
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(children: [
//       CircleAvatar(
//           backgroundImage: image, radius: mediaQueryWidth(context) * 0.13),
//       Positioned(
//           bottom: mediaQueryHeight(context) * 0.005,
//           right: mediaQueryWidth(context) * 0.02,
//           child: SvgPicture.asset(
//               width: mediaQueryWidth(context) * 0.06,
//               "assets/icons/ic_pic_edit.svg",
//               fit: BoxFit.scaleDown))
//     ]);
//   }
// }
