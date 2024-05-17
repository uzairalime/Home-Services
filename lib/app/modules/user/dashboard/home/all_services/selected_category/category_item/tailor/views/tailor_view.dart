// ignore_for_file: unused_local_variable, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/generated/locales.g.dart';
import 'package:home_brigadier/services/apis/toast.dart';
import 'package:home_brigadier/utils/logger.dart';
import 'package:home_brigadier/utils/style.dart';
import 'package:home_brigadier/widget/cText.dart';
import 'package:home_brigadier/widget/c_filled_btn.dart';

import '../../house_cleaning/controllers/booking_controller.dart';
import '../../house_cleaning/views/booking_details_view.dart';
import '../controllers/tailor_controller.dart';

// ignore: must_be_immutable
class TailorView extends GetView<TailorController> {
  final con = Get.put(TailorController);
  final bookingcontroller = Get.put(BookingController());
  TailorView({super.key});

  @override
  Widget build(BuildContext context) {
    // BookingController.to.claculateBill();

    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final con = Get.put(TailorController());

    final titleSmall = Theme.of(context).textTheme.titleSmall!.fontSize;
    final titlelarge = Theme.of(context).textTheme.titleLarge!.fontSize;

    return PopScope(
      canPop: true,
      onPopInvoked: (val) {},
      child: Scaffold(
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
                child: CButton(
                    borderradius: widht * 0.075,
                    text:
                        "${LocaleKeys.house_cleaning_items_cont_button.tr} AED ${bookingcontroller.total.value}",
                    fontWeight: FontWeight.bold,
                    ontab: () {
                      onContinue();
                    }),
              ),
            ),
          ),
          appBar: AppBar(
            title: Text(
              LocaleKeys.tailor_items_tailor.tr,
              style: appbar,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 12, left: 12, right: 18, bottom: 12),
                child: SvgPicture.asset(
                  "assets/icons/ic_more_outlined.svg",
                  fit: BoxFit.scaleDown,
                  width: appbariconsize,
                  height: appbariconsize,
                ),
              )
            ],
          ),
          body: PopScope(
            canPop: true,
            onPopInvoked: (val) {
              TailorController.to.clearONCleaningPageRemove();
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                width: widht,
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: widht * 0.05, vertical: height * 0.025),
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                      text: LocaleKeys.tailor_items_pieces.tr,
                                      fontWeight: bold6,
                                      fontsize: 16,
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        controller.piecesdecrease();
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
                                      text: controller.pieces.value.toString(),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    SizedBox(
                                      width: widht * 0.04,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        controller.pieces.value++;
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
                            text:
                                LocaleKeys.tailor_items_what_kind_of_service.tr,
                            fontsize: titlelarge,
                            fontWeight: bold4,
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),

                          Wrap(
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
                                    color: controller.selectedweekplan ==
                                            'New Stitching'
                                        ? AppColor.white
                                        : AppColor.black,
                                    text: LocaleKeys
                                        .tailor_items_new_stitching.tr),
                                selected: controller.selectedweekplan.value ==
                                    'New Stitching',
                                onSelected: (bool selected) {
                                  controller.selectWeekplan('New Stitching');
                                },
                              ),
                              SizedBox(
                                width: widht * 0.02,
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
                                            'Alteration'
                                        ? AppColor.white
                                        : AppColor.black,
                                    text:
                                        LocaleKeys.tailor_items_alteration.tr),
                                selected: controller.selectedweekplan.value ==
                                    'Alteration',
                                onSelected: (bool selected) {
                                  controller.selectWeekplan('Alteration');
                                },
                              ),
                              SizedBox(
                                width: widht * 0.02,
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
                                    color:
                                        controller.selectedweekplan == 'Others'
                                            ? AppColor.white
                                            : AppColor.black,
                                    text: LocaleKeys.tailor_items_others.tr),
                                selected: controller.selectedweekplan.value ==
                                    'Others',
                                onSelected: (bool selected) {
                                  controller.selectWeekplan('Others');
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
                      ),
                    )),
              ),
            ),
          )),
    );
  }

  onContinue() {
    if (controller.hours.value == 0) {
      logger.d(controller.hours.value);
      showSnackBar(LocaleKeys.snack_bars_select_hours.tr, true);
    } else if (controller.pieces.value == 0) {
      showSnackBar(LocaleKeys.snack_bars_select_piecec.tr, true);
    } else if (controller.selectedweekplan.value.isEmpty) {
      showSnackBar(LocaleKeys.snack_bars_select_service.tr, true);
    } else {
      // print()
      // print(
      //     "++++++++++++++++++${booki.servicemodel!.openingHours![0].fromHour}");
      Get.to(() => BookingDetailsView(
            model: BookingController.to.servicemodel,
          ));
    }
  }
}
