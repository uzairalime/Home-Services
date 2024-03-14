// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:home_brigadier/app/seller/dashboard/bookings/upcoming_view.dart';
//
// import '../../../../consts/app_color.dart';
// import '../../../../consts/media_query.dart';
// import '../../../../widget/cText.dart';
// import '../../../../widget/c_filled_btn.dart';
// import 'controllers/bookings_controller.dart';
//
// class CancelledView extends GetView<BookingsController> {
//   const CancelledView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final titleLarge = Theme.of(context).textTheme.titleLarge!.fontSize;
//     final titleSmall = Theme.of(context).textTheme.titleSmall!.fontSize;
//     final labelLarge = Theme.of(context).textTheme.labelLarge!.fontSize;
//
//     return ListView.builder(
//         itemCount: 2,
//         itemBuilder: (context, index) {
//           return Card(
//               margin: EdgeInsets.symmetric(
//                   vertical: mediaQueryHeight(context) * 0.012,
//                   horizontal: mediaQueryWidth(context) * 0.05),
//               child: CustomExpansionTile(
//                   fistChild: Row(children: [
//                     Expanded(
//                         child: Container(
//                             height: 100,
//                             decoration: const BoxDecoration(
//                                 image: DecorationImage(
//                                     image: AssetImage(
//                                         "assets/images/img_people.png"),
//                                     fit: BoxFit.cover),
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(25))))),
//                     Expanded(
//                         flex: 2,
//                         child: Padding(
//                             padding: const EdgeInsets.only(left: 20),
//                             child: Column(
//                                 mainAxisSize: MainAxisSize.max,
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   CText(text: "Plumber", fontsize: titleLarge),
//                                   CText(
//                                       text: "text",
//                                       fontsize: labelLarge,
//                                       color: AppColor.grey),
//                                   SizedBox(
//                                       width: mediaQueryWidth(context) * 0.22,
//                                       height: mediaQueryHeight(context) * 0.035,
//                                       child: CButton(
//                                           ontab: () {},
//                                           fontsize: labelLarge,
//                                           text: "Cancelled",
//                                           borderradius: 7,
//                                           bgcolor: AppColor.red))
//                                 ]))),
//                     Expanded(
//                         child: CircleAvatar(
//                             backgroundColor: AppColor.grey.withOpacity(0.3),
//                             child: SizedBox(
//                                 width: 20,
//                                 height: 20,
//                                 child: SvgPicture.asset(
//                                     "assets/icons/ic_message.svg"))))
//                   ]),
//                   children: [
//                     Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               CText(
//                                   text: "Date & Time",
//                                   fontsize: labelLarge,
//                                   color: AppColor.grey),
//                               CText(
//                                   text: "${DateTime.now()}",
//                                   fontsize: titleSmall)
//                             ])),
//                     Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(children: [
//                           Row(
//                               mainAxisSize: MainAxisSize.max,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 CText(
//                                     text: "Location",
//                                     fontsize: labelLarge,
//                                     color: AppColor.grey),
//                                 CText(
//                                     text: "1691 Carpenter Pass",
//                                     fontsize: titleSmall)
//                               ]),
//                           Container(
//                               margin: const EdgeInsets.symmetric(vertical: 10),
//                               decoration: const BoxDecoration(
//                                   image: DecorationImage(
//                                       fit: BoxFit.cover,
//                                       image:
//                                           AssetImage("assets/images/map.png")),
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(15))),
//                               height: mediaQueryHeight(context) * 0.25),
//                           CFilledBtn(
//                               text: "View E-Receipt",
//                               onPressed: () {},
//                               height: 40,
//                               width: mediaQueryWidth(context) * 0.8,
//                               btnBg: AppColor.secondary)
//                         ]))
//                   ]));
//         });
//   }
// }
