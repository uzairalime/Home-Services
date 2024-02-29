import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/seller/dashboard/profile/user_profile/controllers/booking_controller.dart';
import 'package:home_brigadier/generated/locales.g.dart';

import '../../../../../../consts/app_color.dart';
import '../../../../../../consts/media_query.dart';
import '../../../../../../model/user_services_models/my_booking_booking_model.dart';
import '../../../../../../widget/cText.dart';
import '../../../../../../widget/shimmer.dart';
import '../controllers/user_profile_controller.dart';
import 'jobs_view.dart';

class MyBookingsView extends GetView<MyBookingController> {
  const MyBookingsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(MyBookingController());
    final titleMedium = Theme.of(context).textTheme.titleMedium!.fontSize;
    return GetBuilder(
        init: Get.put(MyBookingController()),
        builder: (context) {
          return FutureBuilder(
            future: controller.fetchData(), // Call your fetch data function
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: SizedBox(
                  width: mediaQueryWidth(context) * 0.95,
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const ShimmerWidget.circular(width: 70, height: 70),
                            ShimmerWidget.rectangular(
                              height: 70,
                              width: mediaQueryWidth(context) * 0.7,
                            ),
                          ],
                        ),
                      ),
                      const ShimmerWidget.rectangular(height: 70),
                      SizedBox(
                        height: mediaQueryHeight(context) * 0.01,
                      ),
                      const ShimmerWidget.rectangular(height: 70),
                      SizedBox(
                          width: mediaQueryWidth(context) * 0.9,
                          height: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ShimmerWidget.rectangular(
                                height: 30,
                                width: mediaQueryWidth(context) * 0.3,
                              ),
                              ShimmerWidget.rectangular(
                                height: 30,
                                width: mediaQueryWidth(context) * 0.3,
                              )
                            ],
                          )),
                      SizedBox(
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const ShimmerWidget.circular(width: 70, height: 70),
                            ShimmerWidget.rectangular(
                              height: 70,
                              width: mediaQueryWidth(context) * 0.7,
                            ),
                          ],
                        ),
                      ),
                      const ShimmerWidget.rectangular(height: 70),
                      SizedBox(
                        height: mediaQueryHeight(context) * 0.01,
                      ),
                      const ShimmerWidget.rectangular(height: 70),
                      SizedBox(
                          width: mediaQueryWidth(context) * 0.9,
                          height: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ShimmerWidget.rectangular(
                                height: 30,
                                width: mediaQueryWidth(context) * 0.3,
                              ),
                              ShimmerWidget.rectangular(
                                height: 30,
                                width: mediaQueryWidth(context) * 0.3,
                              )
                            ],
                          )),
                    ],
                  ),
                ));
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                List<MyServicesBookingModel> item = snapshot.data!;
                return ListView.builder(
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    MyServicesBookingModel model = item[index];

                    return Card(
                        elevation: 8,
                        shadowColor: AppColor.greylight,
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: ExpansionTile(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            initiallyExpanded: index == 0 ? true : false,
                            leading: CachedNetworkImage(
                                filterQuality: FilterQuality.medium,
                                width: 50,
                                imageUrl:
                                    "https://homebrigadier.fly.dev${item[index].service.files[0].file}",
                                imageBuilder: (context, imageProvider) => Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.contain,
                                        ))),
                                placeholder: (context, url) =>
                                    const Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => const Icon(Icons.error)),
                            title: CText(
                                    fontsize: titleMedium,
                                    textAlign: TextAlign.start,
                                    text: item[index].service.category.code,
                                    color: AppColor.black,
                                    fontWeight: FontWeight.bold)
                                .paddingOnly(bottom: 10),
                            subtitle: CText(
                                textAlign: TextAlign.start,
                                color: AppColor.black,
                                text: item[index].service.name),
                            children: [
                              Column(children: [
                                const Divider(),
                                Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CText(
                                              text: LocaleKeys.my_booking_date.tr,
                                              fontsize: titleMedium,
                                              fontWeight: FontWeight.bold,
                                            ).marginOnly(bottom: 5),
                                            CText(
                                              text: formatDate(model.startAt),
                                            ).paddingSymmetric(vertical: 5)
                                          ]),
                                      Column(children: [
                                        CText(
                                          text: LocaleKeys.my_booking_time.tr,
                                          fontWeight: FontWeight.bold,
                                        ).marginOnly(bottom: 5),
                                        CText(
                                            text:
                                                "${formatTime(model.service.openingHours[0].fromHour)}-"
                                                "${formatTime(model.service.openingHours[0].toHour)}")
                                      ])
                                    ]).marginSymmetric(vertical: 5),
                                const Divider(),
                                Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CText(
                                              text: LocaleKeys.my_booking_price.tr,
                                              fontsize: titleMedium,
                                              fontWeight: FontWeight.bold,
                                            ).marginOnly(bottom: 5),
                                            CText(
                                              text:
                                                  "${LocaleKeys.my_booking_aed.tr} ${item[index].price}",
                                            ).paddingSymmetric(vertical: 5)
                                          ]),
                                      Column(children: [
                                        const CText(
                                          text: '',
                                          fontWeight: FontWeight.bold,
                                        ).marginOnly(bottom: 5),
                                        CText(
                                          text: item[index].paymentStatus,
                                          fontWeight: FontWeight.bold,
                                          color: CupertinoColors.activeGreen,
                                        ).paddingSymmetric(vertical: 5)
                                      ])
                                    ]).marginSymmetric(vertical: 5),
                                const Divider(),
                                Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CText(
                                              text: LocaleKeys.my_booking_booking_status.tr,
                                              fontsize: titleMedium,
                                              fontWeight: FontWeight.bold,
                                            ).marginOnly(bottom: 5),
                                          ]),
                                      Column(children: [
                                        Card(
                                          color: AppColor.greylight.withOpacity(0.3),
                                          elevation: 0,
                                          child: CText(text: item[index].status).paddingAll(5),
                                        )
                                      ]),
                                    ]).marginSymmetric(vertical: 5),
                              ]).marginSymmetric(horizontal: mediaQueryWidth(context) * 0.1)
                            ]));
                  },
                );
              }
            },
          );
        });
  }
}
