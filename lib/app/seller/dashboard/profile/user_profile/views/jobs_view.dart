import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/seller/dashboard/profile/user_profile/controllers/jobs_controller.dart';
import 'package:home_brigadier/app/seller/dashboard/profile/user_profile/controllers/user_profile_controller.dart';
import 'package:home_brigadier/consts/media_query.dart';
import 'package:home_brigadier/generated/locales.g.dart';
import 'package:intl/intl.dart';

import '../../../../../../consts/app_color.dart';
import '../../../../../../model/user_services_models/my_booking_booking_model.dart';
import '../../../../../../widget/cText.dart';
import '../../../../../../widget/shimmer.dart';

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
            leading: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/icons/launcher_icon.png")),
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(Radius.circular(6))),
              ),
            ),
            title: CText(
                text: LocaleKeys.user_profile_item_jobs.tr,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontsize: mediaQueryHeight(context) * 0.025),
            bottom: TabBar(
                labelStyle: TextStyle(fontSize: titleSmall, fontWeight: FontWeight.bold),
                unselectedLabelStyle: TextStyle(fontSize: titleSmall, color: AppColor.grey),
                padding: EdgeInsets.symmetric(horizontal: mediaQueryWidth(context) * 0.05),
                automaticIndicatorColorAdjustment: true,
                indicatorWeight: 3,
                tabs: const [
                  Tab(text: "Completed"),
                  Tab(text: "Upcoming"),
                  // Tab(text: LocaleKeys.user_profile_item_booking.tr)
                ])),
        body: TabBarView(children: [
          GetBuilder(
              init: Get.put(MyJobsController()),
              builder: (context) {
                return FutureBuilder(
                  future: controller.fetchJobs(), // Call your fetch data function
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SizedBox(
                          width: mediaQueryWidth(context) * 0.95,
                          child: Column(
                            children: [
                              SizedBox(
                                height: mediaQueryHeight(context) * 0.1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const ShimmerWidget.circular(width: 70, height: 70),
                                    ShimmerWidget.rectangular(
                                      height: mediaQueryHeight(context) * 0.07,
                                      width: mediaQueryWidth(context) * 0.7,
                                    ),
                                  ],
                                ),
                              ),
                              ShimmerWidget.rectangular(
                                height: mediaQueryHeight(context) * 0.08,
                              ),
                              SizedBox(
                                height: mediaQueryHeight(context) * 0.01,
                              ),
                              ShimmerWidget.rectangular(
                                height: mediaQueryHeight(context) * 0.08,
                              ),
                              SizedBox(
                                height: mediaQueryHeight(context) * 0.01,
                              ),
                              ShimmerWidget.rectangular(
                                height: mediaQueryHeight(context) * 0.08,
                              ),
                              SizedBox(
                                height: mediaQueryHeight(context) * 0.01,
                              ),
                              ShimmerWidget.rectangular(
                                height: mediaQueryHeight(context) * 0.08,
                              ),
                              SizedBox(
                                height: mediaQueryHeight(context) * 0.01,
                              ),
                              ShimmerWidget.rectangular(
                                height: mediaQueryHeight(context) * 0.08,
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(child: Text("Error while loading jobs"));
                    } else if (snapshot.data!.isEmpty) {
                      return const Center(
                        child: CText(text: "No jobs found", color: AppColor.black),
                      );
                    } else {
                      // If data is successfully fetched
                      List<MyServicesBookingModel> item = snapshot.data!;
                      return ListView.builder(
                        itemCount: item.length,
                        itemBuilder: (context, index) {
                          MyServicesBookingModel model = item[index];

                          return Card(
                              elevation: 8,
                              shadowColor: AppColor.greylight,
                              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: ExpansionTile(
                                    childrenPadding: const EdgeInsets.symmetric(horizontal: 15),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12)),
                                    initiallyExpanded: index == 0 ? true : false,
                                    leading: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: CachedNetworkImage(
                                          imageUrl:
                                              "https://homebrigadier.fly.dev${model.service.files[0].file}",
                                          imageBuilder: (context, imageProvider) => Container(
                                              width: 100,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ))),
                                          placeholder: (context, url) =>
                                              const Center(child: CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error)),
                                    ),
                                    title: CText(
                                            fontsize: titleMedium,
                                            textAlign: TextAlign.start,
                                            color: AppColor.black,
                                            text: model.service.category.displayName,
                                            fontWeight: FontWeight.bold)
                                        .paddingOnly(bottom: 10),
                                    subtitle: CText(
                                        textAlign: TextAlign.start,
                                        color: AppColor.black,
                                        text: "${model.user['username']}"),
                                    children: [
                                      const Divider(),
                                      Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CText(
                                                    text: LocaleKeys.my_jobs_date.tr,
                                                    fontsize: titleMedium,
                                                    fontWeight: FontWeight.bold,
                                                  ).marginOnly(bottom: 5),
                                                  CText(
                                                    text: formatDate(model.startAt),
                                                  ).paddingSymmetric(vertical: 5)
                                                ]),
                                            //
                                            Column(children: [
                                              CText(
                                                text: LocaleKeys.my_jobs_time.tr,
                                                fontWeight: FontWeight.bold,
                                              ).marginOnly(bottom: 5),
                                              CText(
                                                      text:
                                                          "${formatTime(model.service.openingHours[0].fromHour)}-"
                                                          "${formatTime(model.service.openingHours[0].toHour)}")
                                                  .paddingSymmetric(vertical: 5)
                                            ])
                                          ]).marginSymmetric(vertical: 5),

                                      //
                                      const Divider(),
                                      Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CText(
                                                    text: LocaleKeys.my_jobs_price.tr,
                                                    fontsize: titleMedium,
                                                    fontWeight: FontWeight.bold,
                                                  ).marginOnly(bottom: 5),
                                                  CText(
                                                    text:
                                                        "${LocaleKeys.my_jobs_aed.tr} ${model.price}",
                                                  ).paddingSymmetric(vertical: 5)
                                                ]),
                                            //
                                            Column(children: [
                                              const CText(
                                                text: '',
                                                fontWeight: FontWeight.bold,
                                              ).marginOnly(bottom: 5),
                                              CText(
                                                text: model.paymentStatus,
                                                fontWeight: FontWeight.bold,
                                                color: AppColor.primary,
                                              ).paddingSymmetric(vertical: 5)
                                            ])
                                          ]).marginSymmetric(vertical: 5),

                                      //
                                      const Divider(),
                                      Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CText(
                                                    text: LocaleKeys.my_jobs_no_of_hours.tr,
                                                    fontsize: titleMedium,
                                                    fontWeight: FontWeight.bold,
                                                  ).marginOnly(bottom: 5),
                                                ]),
                                            Column(children: [
                                              CText(text: '${model.extraInfo['no_of_hours']}')
                                                  .marginOnly(bottom: 5),
                                            ])
                                          ]).marginSymmetric(vertical: 5),

                                      //
                                      const Divider(),
                                      Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CText(
                                                    text: LocaleKeys.my_jobs_description.tr,
                                                    fontsize: titleMedium,
                                                    fontWeight: FontWeight.bold,
                                                  ).marginOnly(bottom: 5),
                                                  CText(
                                                    text: model.description,
                                                  ).paddingSymmetric(vertical: 5)
                                                ]),

                                            Column(children: [
                                              const CText(
                                                text: '',
                                                fontWeight: FontWeight.bold,
                                              ).marginOnly(bottom: 5),
                                              CText(
                                                text: model.paymentStatus,
                                                fontWeight: FontWeight.bold,
                                                color: AppColor.primary,
                                              ).paddingSymmetric(vertical: 5)
                                            ])

                                            ///
                                          ]).marginSymmetric(vertical: 5),

                                      //
                                      const Divider(),
                                      Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CText(
                                                    text: LocaleKeys.my_jobs_booking_status.tr,
                                                    fontsize: titleMedium,
                                                    fontWeight: FontWeight.bold,
                                                  ).marginOnly(bottom: 5),
                                                ]),
                                            //
                                            Column(children: [
                                              Card(
                                                color: AppColor.greylight.withOpacity(0.3),
                                                elevation: 0,
                                                child: CText(text: model.status).paddingAll(5),
                                              )
                                            ]),
                                          ]).marginSymmetric(vertical: 5),

                                      //
                                      const Divider(),
                                      Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            const Icon(Icons.pin_drop_outlined,
                                                color: AppColor.primary),
                                            SizedBox(
                                              width: mediaQueryWidth(context) * 0.7,
                                              child: Text(
                                                softWrap: true,
                                                model.address,
                                              ).paddingSymmetric(vertical: 5),
                                            ),

                                            ///
                                          ]).marginSymmetric(vertical: 5)
                                    ]),
                              ));
                        },
                      );
                    }
                  },
                );
              }),
          GetBuilder(
              init: Get.put(MyJobsController()),
              builder: (context) {
                return FutureBuilder(
                  future: controller.fetchJobs(), // Call your fetch data function
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SizedBox(
                          width: mediaQueryWidth(context) * 0.95,
                          child: Column(
                            children: [
                              SizedBox(
                                height: mediaQueryHeight(context) * 0.1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const ShimmerWidget.circular(width: 70, height: 70),
                                    ShimmerWidget.rectangular(
                                      height: mediaQueryHeight(context) * 0.07,
                                      width: mediaQueryWidth(context) * 0.7,
                                    ),
                                  ],
                                ),
                              ),
                              ShimmerWidget.rectangular(
                                height: mediaQueryHeight(context) * 0.08,
                              ),
                              SizedBox(
                                height: mediaQueryHeight(context) * 0.01,
                              ),
                              ShimmerWidget.rectangular(
                                height: mediaQueryHeight(context) * 0.08,
                              ),
                              SizedBox(
                                height: mediaQueryHeight(context) * 0.01,
                              ),
                              ShimmerWidget.rectangular(
                                height: mediaQueryHeight(context) * 0.08,
                              ),
                              SizedBox(
                                height: mediaQueryHeight(context) * 0.01,
                              ),
                              ShimmerWidget.rectangular(
                                height: mediaQueryHeight(context) * 0.08,
                              ),
                              SizedBox(
                                height: mediaQueryHeight(context) * 0.01,
                              ),
                              ShimmerWidget.rectangular(
                                height: mediaQueryHeight(context) * 0.08,
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(child: Text("Error while loading jobs"));
                    } else if (snapshot.data!.isEmpty) {
                      return const Center(
                        child: CText(text: "No jobs found", color: AppColor.black),
                      );
                    } else {
                      // If data is successfully fetched
                      List<MyServicesBookingModel> item = snapshot.data!;
                      return ListView.builder(
                        itemCount: item.length,
                        itemBuilder: (context, index) {
                          MyServicesBookingModel model = item[index];

                          return Card(
                              elevation: 8,
                              shadowColor: AppColor.greylight,
                              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: ExpansionTile(
                                    childrenPadding: const EdgeInsets.symmetric(horizontal: 15),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12)),
                                    initiallyExpanded: index == 0 ? true : false,
                                    leading: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: CachedNetworkImage(
                                          imageUrl:
                                              "https://homebrigadier.fly.dev${model.service.files[0].file}",
                                          imageBuilder: (context, imageProvider) => Container(
                                              width: 100,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ))),
                                          placeholder: (context, url) =>
                                              const Center(child: CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error)),
                                    ),
                                    title: CText(
                                            fontsize: titleMedium,
                                            textAlign: TextAlign.start,
                                            color: AppColor.black,
                                            text: model.service.category.displayName,
                                            fontWeight: FontWeight.bold)
                                        .paddingOnly(bottom: 10),
                                    subtitle: CText(
                                        textAlign: TextAlign.start,
                                        color: AppColor.black,
                                        text: "${model.user['username']}"),
                                    children: [
                                      const Divider(),
                                      Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CText(
                                                    text: LocaleKeys.my_jobs_date.tr,
                                                    fontsize: titleMedium,
                                                    fontWeight: FontWeight.bold,
                                                  ).marginOnly(bottom: 5),
                                                  CText(
                                                    text: formatDate(model.startAt),
                                                  ).paddingSymmetric(vertical: 5)
                                                ]),
                                            //
                                            Column(children: [
                                              CText(
                                                text: LocaleKeys.my_jobs_time.tr,
                                                fontWeight: FontWeight.bold,
                                              ).marginOnly(bottom: 5),
                                              CText(
                                                      text:
                                                          "${formatTime(model.service.openingHours[0].fromHour)}-"
                                                          "${formatTime(model.service.openingHours[0].toHour)}")
                                                  .paddingSymmetric(vertical: 5)
                                            ])
                                          ]).marginSymmetric(vertical: 5),

                                      //
                                      const Divider(),
                                      Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CText(
                                                    text: LocaleKeys.my_jobs_price.tr,
                                                    fontsize: titleMedium,
                                                    fontWeight: FontWeight.bold,
                                                  ).marginOnly(bottom: 5),
                                                  CText(
                                                    text:
                                                        "${LocaleKeys.my_jobs_aed.tr} ${model.price}",
                                                  ).paddingSymmetric(vertical: 5)
                                                ]),
                                            //
                                            Column(children: [
                                              const CText(
                                                text: '',
                                                fontWeight: FontWeight.bold,
                                              ).marginOnly(bottom: 5),
                                              CText(
                                                text: model.paymentStatus,
                                                fontWeight: FontWeight.bold,
                                                color: AppColor.primary,
                                              ).paddingSymmetric(vertical: 5)
                                            ])
                                          ]).marginSymmetric(vertical: 5),

                                      //
                                      const Divider(),
                                      Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CText(
                                                    text: LocaleKeys.my_jobs_no_of_hours.tr,
                                                    fontsize: titleMedium,
                                                    fontWeight: FontWeight.bold,
                                                  ).marginOnly(bottom: 5),
                                                ]),
                                            Column(children: [
                                              CText(text: '${model.extraInfo['no_of_hours']}')
                                                  .marginOnly(bottom: 5),
                                            ])
                                          ]).marginSymmetric(vertical: 5),

                                      //
                                      const Divider(),
                                      Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CText(
                                                    text: LocaleKeys.my_jobs_description.tr,
                                                    fontsize: titleMedium,
                                                    fontWeight: FontWeight.bold,
                                                  ).marginOnly(bottom: 5),
                                                  CText(
                                                    text: model.description,
                                                  ).paddingSymmetric(vertical: 5)
                                                ]),

                                            Column(children: [
                                              const CText(
                                                text: '',
                                                fontWeight: FontWeight.bold,
                                              ).marginOnly(bottom: 5),
                                              CText(
                                                text: model.paymentStatus,
                                                fontWeight: FontWeight.bold,
                                                color: AppColor.primary,
                                              ).paddingSymmetric(vertical: 5)
                                            ])

                                            ///
                                          ]).marginSymmetric(vertical: 5),

                                      //
                                      const Divider(),
                                      Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CText(
                                                    text: LocaleKeys.my_jobs_booking_status.tr,
                                                    fontsize: titleMedium,
                                                    fontWeight: FontWeight.bold,
                                                  ).marginOnly(bottom: 5),
                                                ]),
                                            //
                                            Column(children: [
                                              Card(
                                                color: AppColor.greylight.withOpacity(0.3),
                                                elevation: 0,
                                                child: CText(text: model.status).paddingAll(5),
                                              )
                                            ]),
                                          ]).marginSymmetric(vertical: 5),

                                      //
                                      const Divider(),
                                      Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            const Icon(Icons.pin_drop_outlined,
                                                color: AppColor.primary),
                                            SizedBox(
                                              width: mediaQueryWidth(context) * 0.7,
                                              child: Text(
                                                softWrap: true,
                                                model.address,
                                              ).paddingSymmetric(vertical: 5),
                                            ),

                                            ///
                                          ]).marginSymmetric(vertical: 5)
                                    ]),
                              ));
                        },
                      );
                    }
                  },
                );
              }),
        ]),
      ),
    );
  }
}

List<MyServicesBookingModel> sortBookingsByStartAt(List<MyServicesBookingModel> bookings) {
  bookings.sort((a, b) {
    // Put large IDs at the top
    if (a.id > b.id) {
      return -1;
    } else if (a.id < b.id) {
      return 1;
    } else {
      return 0;
    }
  });

  return bookings;
}

String formatDate(String dateString) {
  // Parse the date string to DateTime object
  DateTime dateTime = DateTime.parse(dateString);

  // Convert the DateTime to the desired format
  String formattedDate = DateFormat('EEEE, MMM dd').format(dateTime);

  return formattedDate;
}
