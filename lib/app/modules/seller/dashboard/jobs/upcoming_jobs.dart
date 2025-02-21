import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/consts/media_query.dart';
import 'package:home_brigadier/widget/cText.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../../model/user_services_models/my_booking_booking_model.dart';
import '../../../../../services/apis/api_endpoints.dart';
import 'controllers/jobs_controller.dart';

class UpcomingJobs extends GetView<JobsController> {
  const UpcomingJobs({super.key});

  @override
  Widget build(BuildContext context) {
    bool isRemained = false;
    Get.put(JobsController());
    final titleMedium = Theme.of(context).textTheme.titleMedium!.fontSize;
    final labelLarge = Theme.of(context).textTheme.labelLarge!.fontSize;
    final labelMedium = Theme.of(context).textTheme.labelMedium!.fontSize;

    return GetBuilder(
        init: Get.put(JobsController()),
        builder: (_) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: SizedBox(
                  height: 30,
                  width: mediaQueryWidth(context),
                  child: Row(
                    children: [
                      Obx(() => IconButton(
                            onPressed: controller.isAtStart.value
                                ? null
                                : controller.scrollBack,
                            iconSize: 15,
                            splashRadius: 20,
                            icon: const Icon(Icons.arrow_back_ios),
                          )),
                      Expanded(
                        child: ListView(
                          controller: controller.scrollController,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: controller.status.map((status) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: ChoiceChip(
                                backgroundColor: AppColor.white,
                                selectedColor: AppColor.greylight,
                                showCheckmark: false,
                                label: CText(
                                  color:
                                      controller.selectedStatus.contains(status)
                                          ? AppColor.black
                                          : AppColor.grey,
                                  text: status,
                                  fontsize:
                                      controller.selectedStatus.contains(status)
                                          ? labelLarge
                                          : labelMedium,
                                ),
                                selected: controller.selectedStatus.value
                                    .contains(status),
                                onSelected: (isSelected) {
                                  controller.toggleSelection(status);
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Obx(() => IconButton(
                            onPressed: controller.isAtEnd.value
                                ? null
                                : controller.scrollForward,
                            iconSize: 15,
                            splashRadius: 20,
                            icon: const Icon(Icons.arrow_forward_ios),
                          )),
                    ],
                  ),
                ).paddingOnly(top: 10),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: controller.fetchFilteredJobs().asStream(),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(
                          child: Text("Error while loading jobs"));
                    } else if (snapshot.data!.isEmpty) {
                      return Center(
                        child: CText(
                            text: LocaleKeys.no_jobs_found.tr,
                            color: AppColor.black),
                      );
                    } else {
                      // If data is successfully fetched
                      List<MyServicesBookingModel> item = snapshot.data!;
                      item.sort((a, b) => b.startAt.compareTo(a.startAt));
                      return ListView.builder(
                        itemCount: item.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (_, index) {
                          MyServicesBookingModel model = item[index];
                          if (item[0].status.contains("pending") &&
                              !isRemained) {
                            jobsReminder(item.length);
                            isRemained = true;
                          }
                          return Card(
                              color: const Color(0xfff8f8f8),
                              elevation: 8,
                              shadowColor: AppColor.greylight,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: ExpansionTile(
                                    childrenPadding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    initiallyExpanded:
                                        index == 0 ? true : false,
                                    leading: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: CachedNetworkImage(
                                          imageUrl:
                                              "${ApiEndpoints.IMGBASE}${model.service.files[0].file}",
                                          imageBuilder: (context,
                                                  imageProvider) =>
                                              Container(
                                                  width: 100,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                      ))),
                                          placeholder: (context, url) =>
                                              const Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error)),
                                    ),
                                    title: CText(
                                            fontsize: titleMedium,
                                            textAlign: TextAlign.start,
                                            color: AppColor.black,
                                            text: model
                                                .service.category.displayName,
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
                                                    text: LocaleKeys
                                                        .my_jobs_date.tr,
                                                    fontsize: titleMedium,
                                                    fontWeight: FontWeight.bold,
                                                  ).marginOnly(bottom: 5),
                                                  CText(
                                                    color: AppColor.black
                                                        .withOpacity(0.6),
                                                    text: formatDate(
                                                        model.startAt),
                                                  ).paddingSymmetric(
                                                      vertical: 5)
                                                ]),
                                            //
                                            Column(children: [
                                              CText(
                                                text:
                                                    LocaleKeys.my_jobs_time.tr,
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
                                                    text: LocaleKeys
                                                        .my_jobs_price.tr,
                                                    fontsize: titleMedium,
                                                    fontWeight: FontWeight.bold,
                                                  ).marginOnly(bottom: 5),
                                                  CText(
                                                    color: AppColor.black
                                                        .withOpacity(0.6),
                                                    text:
                                                        "${LocaleKeys.my_jobs_aed.tr} ${model.price}",
                                                  ).paddingSymmetric(
                                                      vertical: 5)
                                                ]),
                                            //
                                            Column(children: [
                                              const CText(
                                                text: '',
                                                fontWeight: FontWeight.bold,
                                              ).marginOnly(bottom: 5),
                                              CText(
                                                text: model.paymentStatus
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
                                                  ).paddingSymmetric(
                                                      vertical: 5)
                                                ]),

                                            ///
                                          ]).marginSymmetric(vertical: 5),

                                      //
                                      const Divider(),
                                      SizedBox(
                                        height: 55,
                                        child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CText(
                                                  text: LocaleKeys
                                                      .my_jobs_booking_status
                                                      .tr,
                                                  fontsize: titleMedium,
                                                  fontWeight: FontWeight.bold),
                                              //

                                              InkWell(
                                                onTap: () {
                                                  if (controller.selectedStatus.value != "Canceled" &&
                                                      controller.selectedStatus
                                                              .value !=
                                                          "Rejected" &&
                                                      controller.selectedStatus
                                                              .value !=
                                                          "Completed") {
                                                    statusDialog(
                                                        context: context,
                                                        controller: controller,
                                                        jobId: model.id);
                                                  }
                                                },
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7)),
                                                  color: AppColor.greylight
                                                      .withOpacity(0.3),
                                                  elevation: 0,
                                                  child: Row(
                                                    children: [
                                                      CText(
                                                          text: model.status
                                                              .capitalizeFirst!),
                                                      const SizedBox(width: 10),
                                                      controller.selectedStatus
                                                                      .value !=
                                                                  "Canceled" &&
                                                              controller
                                                                      .selectedStatus
                                                                      .value !=
                                                                  "Rejected" &&
                                                              controller
                                                                      .selectedStatus
                                                                      .value !=
                                                                  "Completed"
                                                          ? SvgPicture.asset(
                                                              height: 20,
                                                              width: 20,
                                                              "assets/icons/ic_pic_edit.svg")
                                                          : const SizedBox()
                                                    ],
                                                  ).paddingSymmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                                ),
                                              )
                                            ]).marginSymmetric(vertical: 5),
                                      ),

                                      //
                                      const Divider(),
                                      Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Icon(Icons.pin_drop_outlined,
                                                color: AppColor.primary),
                                            SizedBox(
                                              width: mediaQueryWidth(context) *
                                                  0.7,
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
                ),
              ),
            ],
          );
        });
  }

  jobsReminder(int length) {
    print("$length Jobs are pending");
    Fluttertoast.showToast(
      msg: "$length ${LocaleKeys.pending_jobs.tr}",
      backgroundColor: AppColor.secondary,
    );
  }
}

statusDialog(
    {required BuildContext context,
    required JobsController controller,
    required int jobId,
    bool? cancel}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog.adaptive(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          title: const Text("Booking Status"),
          content: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                6,
                (index) => ListTile(
                    title: Text(controller.dialogStatus[index]),
                    onTap: () async {
                      Get.back();
                      if (JobsController.to.selectedStatus.toLowerCase() !=
                          controller.dialogStatus[index].toLowerCase()) {
                        showConfirmationBottomSheet(
                            index: index,
                            label: controller.dialogStatus[index].toLowerCase(),
                            status: controller.dialogStatus[index],
                            jobId: jobId,
                            cancel: cancel);
                      }
                    }),
              )));
    },
  );
}

void showConfirmationBottomSheet(
    {required int index,
    required String label,
    required String status,
    jobId,
    bool? cancel}) {
  Get.bottomSheet(
    Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (index == 5) ...[
            Text(
              'Are you $label the job?',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            // Add other widgets as needed
          ] else ...[
            Text(
              'Are you sure you want to $label?',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            // Add other widgets as needed
          ],
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.back(); // Close the bottom sheet
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  child: Text(
                    'No',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  JobsController.to
                      .updateBookingStatus(
                          status: status, jobId: jobId, cancel: cancel)
                      .whenComplete(() {
                    if (status != "Completed") {
                      JobsController.to
                          .toggleSelection(status.capitalizeFirst!);
                    } else {
                      JobsController.to.tabController.animateTo(1);
                    }
                  });
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  child: Text(
                    'Yes',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ),
    barrierColor:
        Colors.black.withOpacity(0.5), // Add a semi-transparent background
  );
}
