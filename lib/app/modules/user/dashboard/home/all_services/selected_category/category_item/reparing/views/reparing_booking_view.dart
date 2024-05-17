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
import '../controllers/reparing_controller.dart';

class RepairingBookingView extends GetView<ReparingController> {
  final bookingcontroller = Get.put(BookingController());
  RepairingBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    // BookingController.to.claculateBill();

    Get.put(ReparingController());
    final titlelarge = Theme.of(context).textTheme.titleLarge!.fontSize;

    final titleSmall = Theme.of(context).textTheme.titleSmall!.fontSize;

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
            LocaleKeys.ac_reparing_items_reparing.tr,
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
                          // CText(
                          //   text: LocaleKeys.painting_items_how_many_hours.tr,
                          //   fontsize: titlelarge,
                          //   fontWeight: bold4,
                          // ),

                          CText(
                            text: LocaleKeys
                                .ac_reparing_items_what_kind_of_service.tr,
                            fontsize: titlelarge,
                            fontWeight: bold4,
                          ),
                          SizedBox(
                            height: height * 0.01,
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
                                            'Ac Service'
                                        ? AppColor.white
                                        : AppColor.black,
                                    text: LocaleKeys
                                        .ac_reparing_items_ac_service.tr),
                                selected: controller.selectedweekplan.value ==
                                    'Ac Service',
                                onSelected: (bool selected) {
                                  controller.selectWeekplan('Ac Service');
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
                                            'Ac Repair'
                                        ? AppColor.white
                                        : AppColor.black,
                                    text: LocaleKeys
                                        .ac_reparing_items_ac_repaire.tr),
                                selected: controller.selectedweekplan.value ==
                                    'Ac Repair',
                                onSelected: (bool selected) {
                                  controller.selectWeekplan('Ac Repair');
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
                                            'Ac Install'
                                        ? AppColor.white
                                        : AppColor.black,
                                    text: LocaleKeys
                                        .ac_reparing_items_ac_install.tr),
                                selected: controller.selectedweekplan.value ==
                                    'Ac Install',
                                onSelected: (bool selected) {
                                  controller.selectWeekplan('Ac Install');
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
                                            'Ac Uninstall'
                                        ? AppColor.white
                                        : AppColor.black,
                                    text: LocaleKeys
                                        .ac_reparing_items_ac_uninstall.tr),
                                selected: controller.selectedweekplan.value ==
                                    'Ac Uninstall',
                                onSelected: (bool selected) {
                                  controller.selectWeekplan('Ac Uninstall');
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
                                    color: controller.selectedweekplan ==
                                            'Gas Refil'
                                        ? AppColor.white
                                        : AppColor.black,
                                    text: LocaleKeys
                                        .ac_reparing_items_gas_refil.tr),
                                selected: controller.selectedweekplan.value ==
                                    'Gas Refil',
                                onSelected: (bool selected) {
                                  controller.selectWeekplan('Gas Refil');
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.02,
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
