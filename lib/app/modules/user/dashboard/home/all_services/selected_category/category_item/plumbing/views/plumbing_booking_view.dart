// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/generated/locales.g.dart';
import 'package:home_brigadier/widget/cText.dart';

import '../../../../../../../../../../consts/app_color.dart';
import '../../../../../../../../../../services/apis/toast.dart';
import '../../../../../../../../../../utils/logger.dart';
import '../../../../../../../../../../utils/style.dart';
import '../../../../../../../../../../widget/c_filled_btn.dart';
import '../../house_cleaning/controllers/booking_controller.dart';
import '../../house_cleaning/views/booking_details_view.dart';
import '../controllers/plumbing_controller.dart';

// import 'consts/app_color.dart';
class PlumbingBookingView extends GetView<PlumbingController> {
  final bookingcontroller = Get.put(BookingController());
  PlumbingBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PlumbingController());
    // BookingController.to.claculateBill();

    final titlelarge = Theme.of(context).textTheme.titleLarge!.fontSize;

    final titleSmall = Theme.of(context).textTheme.titleSmall!.fontSize;
    // final titlelarge = Theme.of(context).textTheme.titlelarge!.fontSize;
    // final titlelarge = Theme.of(context).textTheme.titleLarge!.fontSize;
    final widht = MediaQuery.of(context).size.width;
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
                  color: AppColor.greylight,
                ))),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 30, bottom: 20, left: 20, right: 20),
              child: Obx(
                () => CButton(
                  borderradius: widht * 0.075,
                  text:
                      "${LocaleKeys.painting_items_continue_button.tr} AED ${bookingcontroller.total.value}",
                  fontWeight: FontWeight.bold,
                  ontab: () {
                    _ongo();
                  },
                ),
              ),
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.adaptive.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            LocaleKeys.plumbing_repairing_item_plumbing_reparing.tr,
            style: TextStyle(
                color: Theme.of(context).textTheme.titleMedium!.color,
                fontSize: titlelarge,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: PopScope(
          canPop: true,
          onPopInvoked: (v) {
            BookingController.to.clearONCleaningPageRemove();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              width: widht,
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: widht * 0.05, vertical: height * 0.025),
                  child: Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CText(
                            text: LocaleKeys
                                .plumbing_repairing_item_how_many_hours.tr,
                            fontsize: titlelarge,
                            fontWeight: bold4,
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: height * 0.02),
                            child: Container(
                              width: widht,
                              height: height * 0.075,
                              decoration: BoxDecoration(
                                  color: const Color(0xffF5F5F5),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, right: 12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CText(
                                      text: LocaleKeys
                                          .plumbing_repairing_item_hours.tr,
                                      fontWeight: bold6,
                                      fontsize: 16,
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        bookingcontroller.hours_decrese();
                                        Get.find<BookingController>()
                                            .claculateBill();
                                        // bookingcontroller.claculateBill();
                                        print(
                                            "=======================================${bookingcontroller.total}");
                                        print(
                                            "=======================================${bookingcontroller.hours}");
                                      },
                                      child: Container(
                                        width: widht * 0.1,
                                        height: height * 0.055,
                                        decoration: BoxDecoration(
                                            color: const Color(0xffF1E7FF),
                                            shape: BoxShape.circle),
                                        child: Center(
                                          child: Icon(
                                            Icons.remove,
                                            size: 16,
                                            color: AppColor.primary,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: widht * 0.04,
                                    ),
                                    CText(
                                      text: bookingcontroller.hours.value
                                          .toString(),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    SizedBox(
                                      width: widht * 0.04,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        bookingcontroller.hours.value++;
                                        bookingcontroller.claculateBill();
                                      },
                                      child: Container(
                                        width: widht * 0.1,
                                        height: height * 0.055,
                                        decoration: BoxDecoration(
                                            color: const Color(0xffF1E7FF),
                                            shape: BoxShape.circle),
                                        child: Center(
                                          child: Icon(
                                            Icons.add,
                                            size: 16,
                                            color: AppColor.primary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          CText(
                            text: LocaleKeys
                                .plumbing_repairing_item_what_kind_of_service
                                .tr,
                            fontsize: titlelarge,
                            fontWeight: bold4,
                          ),
                          Wrap(
                            spacing: 10,
                            children: [
                              ChoiceChip(
                                labelPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                backgroundColor: AppColor.white,
                                selectedColor: AppColor.secondary,
                                shape: const StadiumBorder(
                                    side:
                                        BorderSide(color: AppColor.secondary)),
                                label: CText(
                                    color: controller.selectedweekplan.value ==
                                            'Basin & Sink'
                                        ? AppColor.white
                                        : AppColor.black,
                                    text: LocaleKeys
                                        .plumbing_repairing_item_basin_sink.tr),
                                selected: controller.selectedweekplan.value ==
                                    'Basin & Sink',
                                onSelected: (bool selected) {
                                  controller.selectWeekplan('Basin & Sink');
                                },
                              ),
                              ChoiceChip(
                                labelPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                backgroundColor: AppColor.white,
                                selectedColor: AppColor.secondary,
                                shape: const StadiumBorder(
                                    side:
                                        BorderSide(color: AppColor.secondary)),
                                label: CText(
                                    color: controller.selectedweekplan.value ==
                                            'Grouting'
                                        ? AppColor.white
                                        : AppColor.black,
                                    text: LocaleKeys
                                        .plumbing_repairing_item_grouting.tr),
                                selected: controller.selectedweekplan.value ==
                                    'Grouting',
                                onSelected: (bool selected) {
                                  controller.selectWeekplan('Grouting');
                                },
                              ),
                              ChoiceChip(
                                labelPadding: const EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 10),
                                backgroundColor: AppColor.white,
                                selectedColor: AppColor.secondary,
                                shape: const StadiumBorder(
                                    side:
                                        BorderSide(color: AppColor.secondary)),
                                label: CText(
                                    color: controller.selectedweekplan.value ==
                                            'Bath Fitting'
                                        ? AppColor.white
                                        : AppColor.black,
                                    text: LocaleKeys
                                        .plumbing_repairing_item_bath_fiting
                                        .tr),
                                selected: controller.selectedweekplan.value ==
                                    'Bath Fitting',
                                onSelected: (bool selected) {
                                  controller.selectWeekplan('Bath Fitting');
                                },
                              ),
                              ChoiceChip(
                                labelPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                backgroundColor: AppColor.white,
                                selectedColor: AppColor.secondary,
                                shape: const StadiumBorder(
                                    side:
                                        BorderSide(color: AppColor.secondary)),
                                label: CText(
                                    color: controller.selectedweekplan.value ==
                                            'Motors'
                                        ? AppColor.white
                                        : AppColor.black,
                                    text: LocaleKeys
                                        .plumbing_repairing_item_motors.tr),
                                selected: controller.selectedweekplan.value ==
                                    'Motors',
                                onSelected: (bool selected) {
                                  controller.selectWeekplan('Motors');
                                },
                              ),
                              ChoiceChip(
                                labelPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                backgroundColor: AppColor.white,
                                selectedColor: AppColor.secondary,
                                shape: const StadiumBorder(
                                    side:
                                        BorderSide(color: AppColor.secondary)),
                                label: CText(
                                    color: controller.selectedweekplan.value ==
                                            'Toilets'
                                        ? AppColor.white
                                        : AppColor.black,
                                    text: LocaleKeys
                                        .plumbing_repairing_item_toilets.tr),
                                selected: controller.selectedweekplan.value ==
                                    'Toilets',
                                onSelected: (bool selected) {
                                  controller.selectWeekplan('Toilets');
                                },
                              ),
                              ChoiceChip(
                                labelPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                backgroundColor: AppColor.white,
                                selectedColor: AppColor.secondary,
                                shape: const StadiumBorder(
                                    side:
                                        BorderSide(color: AppColor.secondary)),
                                label: CText(
                                    color: controller.selectedweekplan.value ==
                                            'Tap & Mixer'
                                        ? AppColor.white
                                        : AppColor.black,
                                    text: LocaleKeys
                                        .plumbing_repairing_item_tap_mixer.tr),
                                selected: controller.selectedweekplan.value ==
                                    'Tap & Mixer',
                                onSelected: (bool selected) {
                                  controller.selectWeekplan('Tap & Mixer');
                                },
                              ),
                              ChoiceChip(
                                labelPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                backgroundColor: AppColor.white,
                                selectedColor: AppColor.secondary,
                                shape: const StadiumBorder(
                                    side:
                                        BorderSide(color: AppColor.secondary)),
                                label: CText(
                                    color: controller.selectedweekplan.value ==
                                            'Draining Pipes'
                                        ? AppColor.white
                                        : AppColor.black,
                                    text: LocaleKeys
                                        .plumbing_repairing_item_draining_pipes
                                        .tr),
                                selected: controller.selectedweekplan.value ==
                                    'Draining Pipes',
                                onSelected: (bool selected) {
                                  controller.selectWeekplan('Draining Pipes');
                                },
                              ),
                              ChoiceChip(
                                labelPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                backgroundColor: AppColor.white,
                                selectedColor: AppColor.secondary,
                                shape: const StadiumBorder(
                                    side:
                                        BorderSide(color: AppColor.secondary)),
                                label: CText(
                                    color: controller.selectedweekplan.value ==
                                            'Water Tank'
                                        ? AppColor.white
                                        : AppColor.black,
                                    text: LocaleKeys
                                        .plumbing_repairing_item_water_tank.tr),
                                selected: controller.selectedweekplan.value ==
                                    'Water Tank',
                                onSelected: (bool selected) {
                                  controller.selectWeekplan('Water Tank');
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          CText(
                            text: LocaleKeys
                                .house_cleaning_items_special_insutuction.tr,
                            textAlign: TextAlign.start,
                            fontsize: titlelarge,
                            fontWeight: bold4,
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          SizedBox(
                            height: height * 0.2,
                            width: widht,
                            child: TextField(
                                textInputAction: TextInputAction.done,
                                controller: bookingcontroller.instruction,
                                maxLines: 10,
                                decoration: InputDecoration(
                                    hintText: LocaleKeys
                                        .house_cleaning_items_example_insutruction
                                        .tr,
                                    hintStyle: TextStyle(fontSize: titleSmall),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        borderSide: const BorderSide(
                                            color: AppColor.secondary)),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0)))),
                          )
                        ],
                      ))),
            ),
          ),
        ));
  }

  _ongo() {
    if (bookingcontroller.hours.value == 0) {
      logger.d(bookingcontroller.hours.value);
      showSnackBar(LocaleKeys.snack_bars_select_hours.tr, true);
    } else if (controller.selectedweekplan.value == "") {
      showSnackBar(LocaleKeys.snack_bars_select_service.tr, true);
    } else if (bookingcontroller.instruction.value.text == "") {
      showSnackBar(LocaleKeys.snack_bars_add_discription.tr, true);
    } else {
      Get.to(() => BookingDetailsView(
            model: BookingController.to.servicemodel,
          ));
    }
  }
}
