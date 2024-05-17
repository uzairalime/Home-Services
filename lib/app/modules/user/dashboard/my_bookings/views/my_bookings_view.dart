import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/consts/media_query.dart';
import 'package:home_brigadier/generated/locales.g.dart';
import 'package:home_brigadier/widget/cText.dart';

import '../../../../../../consts/app_color.dart';
import '../controllers/my_bookings_controller.dart';
import 'completed_bookings.dart';
import 'upcoming_bookings.dart';

class MyBookingsView extends GetView<MyBookingController> {
  const MyBookingsView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(MyBookingController());
    final txtTheme = Theme.of(context).textTheme.titleMedium!.color;
    return GetBuilder<MyBookingController>(
        init: Get.put(MyBookingController()),
        builder: (builderContext) {
          return DefaultTabController(
              length: 2,
              child: Scaffold(
                  appBar: AppBar(
                      leading: Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(8.0),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              color: AppColor.secondary),
                          child: SvgPicture.asset("assets/icons/ic_logo.svg")),
                      title: CText(
                          text: LocaleKeys.dashboard_items_bookings.tr,
                          fontWeight: FontWeight.bold,
                          color: txtTheme,
                          fontsize: mediaQueryHeight(context) * 0.025),
                      bottom: TabBar(
                          physics: const ClampingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              horizontal: mediaQueryWidth(context) * 0.05),
                          automaticIndicatorColorAdjustment: true,
                          indicatorWeight: 2,
                          tabs: const [
                            Tab(text: 'Pending'),
                            Tab(text: 'Accepted'),
                          ])),
                  body: const TabBarView(children: [
                    UpcomingBookings(),
                    CompletedBookings(),
                  ])));
        });

    // GetBuilder(
    //   init: Get.put(MyBookingController()),
    //   builder: (context) {
    //     return FutureBuilder(
    //       future: controller.fetchData(), // Call your fetch data function
    //       builder: (context, snapshot) {
    //         if (snapshot.connectionState == ConnectionState.waiting) {
    //           return Center(
    //               child: SizedBox(
    //             width: mediaQueryWidth(context) * 0.95,
    //             child: ListView(
    //               children: [
    //                 SizedBox(
    //                   height: 100,
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                     children: [
    //                       const ShimmerWidget.circular(width: 70, height: 70),
    //                       ShimmerWidget.rectangular(
    //                         height: 70,
    //                         width: mediaQueryWidth(context) * 0.7,
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 const ShimmerWidget.rectangular(height: 70),
    //                 SizedBox(
    //                   height: mediaQueryHeight(context) * 0.01,
    //                 ),
    //                 const ShimmerWidget.rectangular(height: 70),
    //                 SizedBox(
    //                     width: mediaQueryWidth(context) * 0.9,
    //                     height: 70,
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                       children: [
    //                         ShimmerWidget.rectangular(
    //                           height: 30,
    //                           width: mediaQueryWidth(context) * 0.3,
    //                         ),
    //                         ShimmerWidget.rectangular(
    //                           height: 30,
    //                           width: mediaQueryWidth(context) * 0.3,
    //                         )
    //                       ],
    //                     )),
    //                 SizedBox(
    //                   height: 100,
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                     children: [
    //                       const ShimmerWidget.circular(width: 70, height: 70),
    //                       ShimmerWidget.rectangular(
    //                         height: 70,
    //                         width: mediaQueryWidth(context) * 0.7,
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 const ShimmerWidget.rectangular(height: 70),
    //                 SizedBox(
    //                   height: mediaQueryHeight(context) * 0.01,
    //                 ),
    //                 const ShimmerWidget.rectangular(height: 70),
    //                 SizedBox(
    //                     width: mediaQueryWidth(context) * 0.9,
    //                     height: 70,
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                       children: [
    //                         ShimmerWidget.rectangular(
    //                           height: 30,
    //                           width: mediaQueryWidth(context) * 0.3,
    //                         ),
    //                         ShimmerWidget.rectangular(
    //                           height: 30,
    //                           width: mediaQueryWidth(context) * 0.3,
    //                         )
    //                       ],
    //                     )),
    //               ],
    //             ),
    //           ));
    //         } else if (snapshot.data!.isEmpty) {
    //           return const Center(
    //             child: Text("You have not any booking yet."),
    //           );
    //         } else if (snapshot.hasError) {
    //           return Center(
    //             child: Text(snapshot.error.toString()),
    //           );
    //         } else {
    //           List<MyServicesBookingModel> data = snapshot.data!;
    //           List<MyServicesBookingModel> item = sortBookingsByStartAt(data);
    //           return ListView.builder(
    //             physics: const BouncingScrollPhysics(),
    //             itemCount: item.length,
    //             itemBuilder: (context, index) {
    //               MyServicesBookingModel model = item[index];
    //
    //               return Card(
    //                   elevation: 8,
    //                   shadowColor: AppColor.greylight,
    //                   margin: const EdgeInsets.symmetric(
    //                       horizontal: 10, vertical: 10),
    //                   child: ExpansionTile(
    //                       shape: RoundedRectangleBorder(
    //                           borderRadius: BorderRadius.circular(12)),
    //                       initiallyExpanded: index == 0 ? true : false,
    //                       leading: CachedNetworkImage(
    //                           filterQuality: FilterQuality.medium,
    //                           width: 50,
    //                           imageUrl:
    //                               "${ApiEndpoints.IMGBASE}${item[index].service.files[0].file}",
    //                           imageBuilder: (context, imageProvider) =>
    //                               Container(
    //                                   decoration: BoxDecoration(
    //                                       shape: BoxShape.circle,
    //                                       image: DecorationImage(
    //                                         image: imageProvider,
    //                                         fit: BoxFit.contain,
    //                                       ))),
    //                           placeholder: (context, url) => const Center(
    //                               child: CircularProgressIndicator()),
    //                           errorWidget: (context, url, error) =>
    //                               const Icon(Icons.error)),
    //                       title: CText(
    //                               fontsize: titleMedium,
    //                               textAlign: TextAlign.start,
    //                               text: item[index]
    //                                   .service
    //                                   .category
    //                                   .code
    //                                   .capitalizeFirst
    //                                   .toString(),
    //                               color: AppColor.black,
    //                               fontWeight: FontWeight.bold)
    //                           .paddingOnly(bottom: 10),
    //                       subtitle: CText(
    //                           textAlign: TextAlign.start,
    //                           color: AppColor.black,
    //                           text: item[index].service.name),
    //                       children: [
    //                         Column(children: [
    //                           const Divider(),
    //                           Row(
    //                               mainAxisSize: MainAxisSize.max,
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.spaceBetween,
    //                               children: [
    //                                 Column(
    //                                     crossAxisAlignment:
    //                                         CrossAxisAlignment.start,
    //                                     children: [
    //                                       CText(
    //                                         text:
    //                                             LocaleKeys.my_booking_date.tr,
    //                                         fontsize: titleMedium,
    //                                         fontWeight: FontWeight.bold,
    //                                       ).marginOnly(bottom: 5),
    //                                       CText(
    //                                         text: formatDate(model.startAt),
    //                                       ).paddingSymmetric(vertical: 5)
    //                                     ]),
    //                                 Column(children: [
    //                                   CText(
    //                                     text: LocaleKeys.my_booking_time.tr,
    //                                     fontWeight: FontWeight.bold,
    //                                   ).marginOnly(bottom: 5),
    //                                   CText(
    //                                       text:
    //                                           "${formatTime(model.service.openingHours[0].fromHour)}-"
    //                                           "${formatTime(model.service.openingHours[0].toHour)}")
    //                                 ])
    //                               ]).marginSymmetric(vertical: 5),
    //                           const Divider(),
    //                           Row(
    //                               mainAxisSize: MainAxisSize.max,
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.spaceBetween,
    //                               children: [
    //                                 Column(
    //                                     crossAxisAlignment:
    //                                         CrossAxisAlignment.start,
    //                                     children: [
    //                                       CText(
    //                                         text: LocaleKeys.my_booking_price
    //                                             .tr.capitalizeFirst
    //                                             .toString(),
    //                                         fontsize: titleMedium,
    //                                         fontWeight: FontWeight.bold,
    //                                       ).marginOnly(bottom: 5),
    //                                       CText(
    //                                         text:
    //                                             "${LocaleKeys.my_booking_aed.tr} ${item[index].price}",
    //                                       ).paddingSymmetric(vertical: 5)
    //                                     ]),
    //                                 Column(children: [
    //                                   const CText(
    //                                     text: '',
    //                                     fontWeight: FontWeight.bold,
    //                                   ).marginOnly(bottom: 5),
    //                                   CText(
    //                                     text: item[index]
    //                                         .paymentStatus
    //                                         .capitalizeFirst
    //                                         .toString(),
    //                                     fontWeight: FontWeight.bold,
    //                                     color: CupertinoColors.activeGreen,
    //                                   ).paddingSymmetric(vertical: 5)
    //                                 ])
    //                               ]).marginSymmetric(vertical: 5),
    //                           const Divider(),
    //                           Row(
    //                               mainAxisSize: MainAxisSize.max,
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.spaceBetween,
    //                               children: [
    //                                 Column(
    //                                     crossAxisAlignment:
    //                                         CrossAxisAlignment.start,
    //                                     children: [
    //                                       CText(
    //                                         text: LocaleKeys
    //                                             .my_booking_booking_status.tr,
    //                                         fontsize: titleMedium,
    //                                         fontWeight: FontWeight.bold,
    //                                       ).marginOnly(bottom: 5),
    //                                     ]),
    //                                 Column(children: [
    //                                   Card(
    //                                     color: AppColor.greylight
    //                                         .withOpacity(0.3),
    //                                     elevation: 0,
    //                                     child: CText(
    //                                             text: item[index]
    //                                                 .status
    //                                                 .capitalizeFirst!)
    //                                         .paddingAll(5),
    //                                   )
    //                                 ]),
    //                               ]).marginSymmetric(vertical: 5),
    //                         ]).marginSymmetric(
    //                             horizontal: mediaQueryWidth(context) * 0.1)
    //                       ]));
    //             },
    //           );
    //         }
    //       },
    //     );
    //   });
  }
}
