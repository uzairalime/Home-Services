import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/generated/locales.g.dart';
import 'package:home_brigadier/services/apis/toast.dart';
import 'package:home_brigadier/utils/logger.dart';
import 'package:home_brigadier/utils/style.dart';
import 'package:home_brigadier/widget/cText.dart';
import 'package:home_brigadier/widget/c_filled_btn.dart';

import '../controllers/booking_controller.dart';
import 'booking_details_view.dart';

// ignore: must_be_immutable
class HouseCleaningBookingView extends GetView<BookingController> {
  const HouseCleaningBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    // BookingController.to.claculateBill();

    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final titleSmall = Theme.of(context).textTheme.titleSmall!.fontSize;
    final titlelarge = Theme.of(context).textTheme.titleLarge!.fontSize;

    return PopScope(
      canPop: true,
      onPopInvoked: (val) {
        BookingController.to.clearONCleaningPageRemove();
      },
      child: Scaffold(
          bottomNavigationBar: InkWell(
            child: Obx(
              () => Container(
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
                  child: CButton(
                      borderradius: widht * 0.075,
                      text:
                          "${LocaleKeys.house_cleaning_items_cont_button.tr} ${controller.total.value} AED ",
                      fontWeight: FontWeight.bold,
                      ontab: () {
                        _onContinue();
                      }),
                ),
              ),
            ),
          ),
          appBar: AppBar(
            title: Text(
              LocaleKeys.house_cleaning_items_house_cleaning.tr,
              style: appbar,
            ),
          ),
          body: SingleChildScrollView(
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
                                .house_cleaning_items_how_many_hours.tr,
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
                                          .house_cleaning_items_hours.tr,
                                      fontWeight: bold6,
                                      fontsize: 16,
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        controller.hours_decrese();
                                        controller.claculateBill();
                                      },
                                      child: Container(
                                        width: widht * 0.1,
                                        height: height * 0.055,
                                        decoration: const BoxDecoration(
                                            color: Color(0xffF1E7FF),
                                            shape: BoxShape.circle),
                                        child: const Center(
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
                                      text: controller.hours.value.toString(),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    SizedBox(
                                      width: widht * 0.04,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        controller.hours.value++;
                                        controller.claculateBill();
                                      },
                                      child: Container(
                                        width: widht * 0.1,
                                        height: height * 0.055,
                                        decoration: const BoxDecoration(
                                            color: Color(0xffF1E7FF),
                                            shape: BoxShape.circle),
                                        child: const Center(
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
                                .house_cleaning_items_how_many_cleaner.tr,
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
                                          .house_cleaning_items_cleaners.tr,
                                      fontWeight: bold6,
                                      fontsize: 16,
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        controller.cleaner_decrese();
                                        controller.claculateBill();
                                      },
                                      child: Container(
                                        width: widht * 0.1,
                                        height: height * 0.055,
                                        decoration: const BoxDecoration(
                                            color: Color(0xffF1E7FF),
                                            shape: BoxShape.circle),
                                        child: const Center(
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
                                      text: controller.cleaner.value.toString(),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    SizedBox(
                                      width: widht * 0.04,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        controller.cleaner.value++;
                                        controller.claculateBill();
                                      },
                                      child: Container(
                                        width: widht * 0.1,
                                        height: height * 0.055,
                                        decoration: const BoxDecoration(
                                            color: Color(0xffF1E7FF),
                                            shape: BoxShape.circle),
                                        child: const Center(
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
                          //
                          SizedBox(
                            height: height * 0.01,
                          ),
                          CText(
                            text: LocaleKeys
                                .house_cleaning_items_how_often_need_claning.tr,
                            fontsize: titlelarge,
                            fontWeight: bold4,
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),

                          SizedBox(
                            // color: Colors.amber,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ChoiceChip(
                                      labelPadding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 3),
                                      backgroundColor: AppColor.white,
                                      selectedColor: AppColor.secondary,
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                          color: AppColor.secondary,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(22.0),
                                      ),
                                      label: CText(
                                          color: controller
                                                      .selectedweekplan.value ==
                                                  'Once'
                                              ? AppColor.white
                                              : AppColor.black,
                                          text: LocaleKeys
                                              .house_cleaning_items_once.tr),
                                      selected:
                                          controller.selectedweekplan.value ==
                                              'Once',
                                      onSelected: (bool selected) {
                                        controller.selectWeekplan('Once');
                                      },
                                    ),
                                    SizedBox(
                                      width: widht * 0.05,
                                    ),
                                    ChoiceChip(
                                      labelPadding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 3),
                                      backgroundColor: AppColor.white,
                                      selectedColor: AppColor.secondary,
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                          color: AppColor.secondary,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(22.0),
                                      ),
                                      label: CText(
                                          color: controller
                                                      .selectedweekplan.value ==
                                                  'Weekly'
                                              ? AppColor.white
                                              : AppColor.black,
                                          text: LocaleKeys
                                              .house_cleaning_items_weekly.tr),
                                      selected:
                                          controller.selectedweekplan.value ==
                                              'Weekly',
                                      onSelected: (bool selected) {
                                        controller.selectWeekplan('Weekly');
                                      },
                                    ),
                                    SizedBox(
                                      width: widht * 0.05,
                                    ),
                                    ChoiceChip(
                                      labelPadding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 3),
                                      backgroundColor: AppColor.white,
                                      selectedColor: AppColor.secondary,
                                      shape: StadiumBorder(
                                          side: BorderSide(
                                              color: controller.selectedmaterial
                                                          .value ==
                                                      'Bi-Weekly'
                                                  ? AppColor.secondary
                                                  : AppColor.secondary)),
                                      label: CText(
                                          color: controller
                                                      .selectedweekplan.value ==
                                                  'Bi-Weekly'
                                              ? AppColor.white
                                              : AppColor.black,
                                          text: LocaleKeys
                                              .house_cleaning_items_Bi_weekly
                                              .tr),
                                      selected:
                                          controller.selectedweekplan.value ==
                                              'Bi-Weekly',
                                      onSelected: (bool selected) {
                                        controller.selectWeekplan('Bi-Weekly');
                                      },
                                    ),
                                  ],
                                ),
                                ChoiceChip(
                                  labelPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 3),
                                  backgroundColor: AppColor.white,
                                  selectedColor: AppColor.secondary,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      color: AppColor.secondary,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(22.0),
                                  ),
                                  label: CText(
                                      color:
                                          controller.selectedweekplan.value ==
                                                  'Multiple Times a Week'
                                              ? AppColor.white
                                              : AppColor.black,
                                      text: LocaleKeys
                                          .house_cleaning_items_Mutilple_time
                                          .tr),
                                  selected: controller.selectedweekplan.value ==
                                      'Multiple Times a Week',
                                  onSelected: (bool selected) {
                                    controller.selectWeekplan(
                                        'Multiple Times a Week');
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          CText(
                            text: LocaleKeys
                                .house_cleaning_items_did_need_material.tr,
                            fontsize: titlelarge,
                            fontWeight: bold4,
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),

                          SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ChoiceChip(
                                  label: CText(
                                      color:
                                          controller.selectedmaterial.value ==
                                                  'Yes'
                                              ? AppColor.white
                                              : AppColor.black,
                                      text: LocaleKeys
                                          .house_cleaning_items_yes.tr),
                                  selected: controller.selectedmaterial.value ==
                                      'Yes',
                                  onSelected: (bool selected) {
                                    controller.selectMaterials('Yes');
                                    controller.claculateBill();
                                  },
                                  labelPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 3),
                                  backgroundColor: AppColor.white,
                                  selectedColor: AppColor.secondary,
                                  shape: StadiumBorder(
                                      side: BorderSide(
                                          color: controller
                                                      .selectedmaterial.value ==
                                                  'Yes'
                                              ? AppColor.secondary
                                              : AppColor.secondary)),
                                ),
                                SizedBox(
                                  width: widht * 0.05,
                                ),
                                ChoiceChip(
                                  labelPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 3),
                                  backgroundColor: AppColor.white,
                                  selectedColor: AppColor.secondary,
                                  shape: StadiumBorder(
                                      side: BorderSide(
                                          color: controller
                                                      .selectedmaterial.value ==
                                                  'No'
                                              ? AppColor.secondary
                                              : AppColor.secondary)),
                                  label: CText(
                                      color:
                                          controller.selectedmaterial.value ==
                                                  'No'
                                              ? AppColor.white
                                              : AppColor.black,
                                      text: LocaleKeys
                                          .house_cleaning_items_no.tr),
                                  selected:
                                      controller.selectedmaterial.value == 'No',
                                  onSelected: (bool selected) {
                                    controller.selectMaterials('No');
                                    controller.claculateBill();
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          SizedBox(
                            child: CText(
                                textAlign: TextAlign.start,
                                fontsize: titleSmall,
                                text: LocaleKeys
                                    .house_cleaning_items_addditional_charges_aed
                                    .tr),
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
                                controller: controller.instruction,
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
          )),
    );
  }

  _onContinue() {
    if (controller.hours.value == 0) {
      logger.d(controller.hours.value);
      showSnackBar(LocaleKeys.snack_bars_select_hours.tr, true);
    } else if (controller.cleaner.value == 0) {
      showSnackBar(LocaleKeys.snack_bars_select_cleanrs.tr, true);
    } else if (controller.selectedweekplan.value.isEmpty) {
      showSnackBar(LocaleKeys.snack_bars_select_subscription.tr, true);
    } else if (controller.selectedmaterial.isEmpty) {
      showSnackBar(LocaleKeys.snack_bars_select_materials.tr, true);
    } else {
      Get.to(() => BookingDetailsView(
            model: BookingController.to.servicemodel,
          ));
    }
  }
}
