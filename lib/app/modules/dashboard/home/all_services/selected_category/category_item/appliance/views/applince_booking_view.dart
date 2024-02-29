import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/modules/dashboard/home/all_services/selected_category/category_item/house_cleaning/controllers/booking_controller.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/generated/locales.g.dart';
// import 'package:home_brigadier/app/modules/dashboard/home/views/home_view.dart';
import 'package:home_brigadier/model/service_model.dart';
import 'package:home_brigadier/services/apis/toast.dart';
import 'package:home_brigadier/widget/cText.dart';

import '../../../../../../../../../consts/media_query.dart';
import '../../../../../../../../../widget/c_filled_btn.dart';
import '../../house_cleaning/views/booking_details_view.dart';
import '../controllers/appliance_controller.dart';

class ApplianceBookingView extends GetView<ApplianceController> {
  final ServicesModel? model;
  const ApplianceBookingView({super.key, this.model});

  @override
  Widget build(BuildContext context) {
    
    Get.put(ApplianceController());
    BookingController.to.claculateBill();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      bottomNavigationBar: InkWell(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              border: Border(
                  top: BorderSide(
                color: AppColor.greylight.withOpacity(0.2),
              ))),
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Obx(
                () => CButton(
                  btnwidth: mediaQueryWidth(context) * 0.9,
                  text:
                      "${LocaleKeys.painting_items_continue_button.tr} AED ${BookingController.to.total.value}",
                  shadow: true,
                  ontab: () {
                    atleastone();
                  },
                  // ontab: () =>
                ),
              )),
        ),
      ),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          SizedBox(
            width: 55.0,
            child: SvgPicture.asset(
              'assets/icons/ic_more_outlined.svg',
              fit: BoxFit.scaleDown,
            ),
          ),
        ],
        title: Text(
          LocaleKeys.applience_items_applience_service.tr,
          style: TextStyle(
              color: Theme.of(context).textTheme.titleMedium!.color,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: Column(
          children: [
            SizedBox(
              width: width * 0.9,
              child: CText(
                  textAlign: TextAlign.start,
                  text: LocaleKeys.applience_items_choose_applience.tr),
            ),
            //paypal
            Expanded(
              child: SizedBox(
                child: ListView(
                  children: [
                    Obx(
                      () => Card(
                        color: Theme.of(context).cardColor,
                        margin: EdgeInsets.symmetric(
                            vertical: mediaQueryHeight(context) * 0.012,
                            horizontal: mediaQueryWidth(context) * 0.05),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          height: height * 0.09,
                          child: Center(
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14.0, vertical: 0.0),
                              title: CText(
                                fontsize: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .fontSize,
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.bold,
                                text:
                                    LocaleKeys.applience_items_washing_mach.tr,
                              ),
                              trailing: Checkbox.adaptive(
                                value: controller.iswashingmachine.value,
                                activeColor: AppColor.primary,
                                onChanged: (value) {
                                  controller.changemac(value);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    //googlepay
                    Obx(
                      () => Card(
                        color: Theme.of(context).cardColor,
                        margin: EdgeInsets.symmetric(
                            vertical: mediaQueryHeight(context) * 0.012,
                            horizontal: mediaQueryWidth(context) * 0.05),
                        child: InkWell(
                          onTap: () async {},
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            height: height * 0.09,
                            child: Center(
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 14.0, vertical: 0.0),
                                title: CText(
                                  fontsize: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .fontSize,
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeight.bold,
                                  text: LocaleKeys.applience_items_refrig.tr,
                                ),
                                trailing: Checkbox.adaptive(
                                  value: controller.isrefrigetaor.value,
                                  activeColor: AppColor.primary,
                                  onChanged: (value) {
                                    controller.changeref(value);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    //applepay
                    Obx(
                      () => Card(
                        color: Theme.of(context).cardColor,
                        margin: EdgeInsets.symmetric(
                            vertical: mediaQueryHeight(context) * 0.012,
                            horizontal: mediaQueryWidth(context) * 0.05),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          height: height * 0.09,
                          child: Center(
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14.0, vertical: 0.0),
                              title: CText(
                                fontsize: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .fontSize,
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.bold,
                                text: LocaleKeys.applience_items_dispancer.tr,
                              ),
                              trailing: Checkbox.adaptive(
                                value: controller.isdis_.value,
                                activeColor: AppColor.primary,
                                onChanged: (value) {
                                  controller.changedis(value);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Obx(
                      () => Card(
                        color: Theme.of(context).cardColor,
                        margin: EdgeInsets.symmetric(
                            vertical: mediaQueryHeight(context) * 0.012,
                            horizontal: mediaQueryWidth(context) * 0.05),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          height: height * 0.09,
                          child: Center(
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14.0, vertical: 0.0),
                              title: CText(
                                fontsize: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .fontSize,
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.bold,
                                text: LocaleKeys.applience_items_air_condi.tr,
                              ),
                              trailing: Checkbox.adaptive(
                                value: controller.iscond_.value,
                                activeColor: AppColor.primary,
                                onChanged: (value) {
                                  controller.changecond(value);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => Card(
                        color: Theme.of(context).cardColor,
                        margin: EdgeInsets.symmetric(
                            vertical: mediaQueryHeight(context) * 0.012,
                            horizontal: mediaQueryWidth(context) * 0.05),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          height: height * 0.09,
                          child: Center(
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14.0, vertical: 0.0),
                              title: CText(
                                fontsize: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .fontSize,
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.bold,
                                text: LocaleKeys
                                    .applience_items_grilling_machine.tr,
                              ),
                              trailing: Checkbox.adaptive(
                                value: controller.isgrilli_.value,
                                activeColor: AppColor.primary,
                                onChanged: (value) {
                                  controller.changegrilli(value);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => Card(
                        color: Theme.of(context).cardColor,
                        margin: EdgeInsets.symmetric(
                            vertical: mediaQueryHeight(context) * 0.012,
                            horizontal: mediaQueryWidth(context) * 0.05),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          height: height * 0.09,
                          child: Center(
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14.0, vertical: 0.0),
                              title: CText(
                                fontsize: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .fontSize,
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.bold,
                                text: LocaleKeys.applience_items_washers.tr,
                              ),
                              trailing: Checkbox.adaptive(
                                value: controller.iswasher.value,
                                activeColor: AppColor.primary,
                                onChanged: (value) {
                                  controller.changewasher(value);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => Card(
                        color: Theme.of(context).cardColor,
                        margin: EdgeInsets.symmetric(
                            vertical: mediaQueryHeight(context) * 0.012,
                            horizontal: mediaQueryWidth(context) * 0.05),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          height: height * 0.09,
                          child: Center(
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14.0, vertical: 0.0),
                              title: CText(
                                fontsize: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .fontSize,
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.bold,
                                text: LocaleKeys.applience_items_drayer.tr,
                              ),
                              trailing: Checkbox.adaptive(
                                value: controller.isdrayer_.value,
                                activeColor: AppColor.primary,
                                onChanged: (value) {
                                  controller.changedrayer(value);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Obx(
                      () => Card(
                        color: Theme.of(context).cardColor,
                        margin: EdgeInsets.symmetric(
                            vertical: mediaQueryHeight(context) * 0.012,
                            horizontal: mediaQueryWidth(context) * 0.05),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          height: height * 0.09,
                          child: Center(
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14.0, vertical: 0.0),
                              title: CText(
                                fontsize: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .fontSize,
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.bold,
                                text: LocaleKeys.applience_items_machnic.tr,
                              ),
                              trailing: Checkbox.adaptive(
                                value: controller.isngmachine_.value,
                                activeColor: AppColor.primary,
                                onChanged: (value) {
                                  BookingController.to.claculateBill();
                                  controller.changemachine(value);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  atleastone() {
    if (controller.isdis_.value == false &&
        controller.iswashingmachine.value == false &&
        controller.isrefrigetaor.value == false &&
        controller.isngmachine_.value == false &&
        controller.isdrayer_.value == false &&
        controller.iscond_.value == false &&
        controller.isgrilli_.value == false &&
        controller.iswasher.value == false) {
      showsnackbar("Please Select at least one ");
    } else {
      Get.to(() => BookingDetailsView(
            model: model,
          ));
    }
  }
}
