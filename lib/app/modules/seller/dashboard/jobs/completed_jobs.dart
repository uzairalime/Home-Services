import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../consts/app_color.dart';
import '../../../../../consts/media_query.dart';
import '../../../../../generated/locales.g.dart';
import '../../../../../model/user_services_models/my_booking_booking_model.dart';
import '../../../../../services/apis/api_endpoints.dart';
import '../../../../../widget/cText.dart';
import 'controllers/jobs_controller.dart';

class CompletedJobs extends GetView<JobsController> {
  const CompletedJobs({super.key});

  @override
  Widget build(BuildContext context) {
    final titleMedium = Theme.of(context).textTheme.titleMedium!.fontSize;

    return GetBuilder(
        init: Get.put(JobsController()),
        builder: (context) {
          return FutureBuilder(
            future: controller.fetchCompletedJobs(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text("Error while loading jobs"));
              } else if (snapshot.data!.isEmpty) {
                return Center(
                  child: CText(
                      text: LocaleKeys.no_jobs_found.tr, color: AppColor.black),
                );
              } else {
                // If data is successfully fetched
                List<MyServicesBookingModel> item = snapshot.data!;
                item.sort((a, b) => b.startAt.compareTo(a.startAt));
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    MyServicesBookingModel model = item[index];

                    return Card(
                        elevation: 8,
                        color: const Color(0xfff8f8f8),
                        shadowColor: AppColor.greylight,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: ExpansionTile(
                              childrenPadding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              initiallyExpanded: index == 0 ? true : false,
                              leading: SizedBox(
                                height: 100,
                                width: 100,
                                child: CachedNetworkImage(
                                    imageUrl:
                                        "${ApiEndpoints.IMGBASE}${model.service.files[0].file}",
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ))),
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator()),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CText(
                                              text: LocaleKeys.my_jobs_date.tr,
                                              fontsize: titleMedium,
                                              fontWeight: FontWeight.bold,
                                            ).marginOnly(bottom: 5),
                                            CText(
                                              color: AppColor.black
                                                  .withOpacity(0.6),
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
                                                color: AppColor.black
                                                    .withOpacity(0.6),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CText(
                                              text: LocaleKeys.my_jobs_price.tr,
                                              fontsize: titleMedium,
                                              fontWeight: FontWeight.bold,
                                            ).marginOnly(bottom: 5),
                                            CText(
                                              color: AppColor.black
                                                  .withOpacity(0.6),
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
                                          text: model.paymentStatus
                                              .toString()
                                              .capitalizeFirst!,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.primary,
                                        ).paddingSymmetric(vertical: 5)
                                      ])
                                    ]).marginSymmetric(vertical: 5),

                                //
                                const Divider(),
                                Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CText(
                                              text: LocaleKeys
                                                  .my_jobs_no_of_hours.tr,
                                              fontsize: titleMedium,
                                              fontWeight: FontWeight.bold,
                                            ).marginOnly(bottom: 5),
                                          ]),
                                      Column(children: [
                                        CText(
                                                color: AppColor.black
                                                    .withOpacity(0.6),
                                                text:
                                                    '${model.extraInfo['no_of_hours']}')
                                            .marginOnly(bottom: 5),
                                      ])
                                    ]).marginSymmetric(vertical: 5),

                                //
                                const Divider(),
                                Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CText(
                                              text: LocaleKeys
                                                  .my_jobs_description.tr,
                                              fontsize: titleMedium,
                                              fontWeight: FontWeight.bold,
                                            ).marginOnly(bottom: 5),
                                            CText(
                                              color: AppColor.black
                                                  .withOpacity(0.6),
                                              text: model.description,
                                            ).paddingSymmetric(vertical: 5)
                                          ]),

                                      ///
                                    ]).marginSymmetric(vertical: 5),

                                //
                                const Divider(),
                                Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CText(
                                              text: LocaleKeys
                                                  .my_jobs_booking_status.tr,
                                              fontsize: titleMedium,
                                              fontWeight: FontWeight.bold,
                                            ).marginOnly(bottom: 5),
                                          ]),
                                      //
                                      Column(children: [
                                        Card(
                                          color: AppColor.greylight
                                              .withOpacity(0.3),
                                          elevation: 0,
                                          child: CText(
                                                  text: model
                                                      .status.capitalizeFirst!)
                                              .paddingAll(5),
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
        });
  }
}
