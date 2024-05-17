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
import '../controllers/painting_controller.dart';

class PaintingBookingView extends GetView<PaintingController> {
  final bookingcontrolle = Get.put(BookingController());
  PaintingBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    // BookingController.to.claculateBill();

    Get.put(PaintingController());
    // final bookingcontroller = Get.put(BookingController());

    final titlelarge = Theme.of(context).textTheme.titleLarge!.fontSize;

    final titleSmall = Theme.of(context).textTheme.titleSmall!.fontSize;
    // final titlelarge = Theme.of(context).textTheme.titlelarge!.fontSize;
    // final titlelarge = Theme.of(context).textTheme.titleLarge!.fontSize;
    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    // final ServicesModel model = ServicesModel();

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
                      "${LocaleKeys.painting_items_continue_button.tr} AED ${bookingcontrolle.total.value}",
                  fontWeight: FontWeight.bold,
                  ontab: () {
                    _ongo();
                  },
                  // ontab: () => Get.to(() => BookingDetailsView(
                  //       model: model,
                  //     )),
                ),
              ),
            ),
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
          title: Text(
            LocaleKeys.painting_items_painting.tr,
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
                            text: LocaleKeys.painting_items_how_many_hours.tr,
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
                                      text: LocaleKeys.painting_items_hours.tr,
                                      fontWeight: bold6,
                                      fontsize: 16,
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        bookingcontrolle.hours_decrese();
                                        bookingcontrolle.claculateBill();
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
                                      text: bookingcontrolle.hours.value
                                          .toString(),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    SizedBox(
                                      width: widht * 0.04,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        bookingcontrolle.hours.value++;
                                        bookingcontrolle.claculateBill();
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
                            text:
                                LocaleKeys.painting_items_size_of_your_home.tr,
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
                                            'Studio'
                                        ? AppColor.white
                                        : AppColor.black,
                                    text: LocaleKeys.painting_items_studio.tr),
                                selected: controller.selectedweekplan.value ==
                                    'Studio',
                                onSelected: (bool selected) {
                                  controller.selectWeekplan('Studio');
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
                                            '1 BR'
                                        ? AppColor.white
                                        : AppColor.black,
                                    text: LocaleKeys.painting_items_1_br.tr),
                                selected:
                                    controller.selectedweekplan.value == '1 BR',
                                onSelected: (bool selected) {
                                  controller.selectWeekplan('1 BR');
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
                                            '2 BR'
                                        ? AppColor.white
                                        : AppColor.black,
                                    text: LocaleKeys.painting_items_2_br.tr),
                                selected:
                                    controller.selectedweekplan.value == '2 BR',
                                onSelected: (bool selected) {
                                  controller.selectWeekplan('2 BR');
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
                                            '3 BR'
                                        ? AppColor.white
                                        : AppColor.black,
                                    text: LocaleKeys.painting_items_3_br.tr),
                                selected:
                                    controller.selectedweekplan.value == '3 BR',
                                onSelected: (bool selected) {
                                  controller.selectWeekplan('3 BR');
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
                                            '4 BR'
                                        ? AppColor.white
                                        : AppColor.black,
                                    text: LocaleKeys.painting_items_4_br.tr),
                                selected:
                                    controller.selectedweekplan.value == '4 BR',
                                onSelected: (bool selected) {
                                  controller.selectWeekplan('4 BR');
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
                                            'Villa'
                                        ? AppColor.white
                                        : AppColor.black,
                                    text: LocaleKeys.painting_items_villa.tr),
                                selected: controller.selectedweekplan.value ==
                                    'Villa',
                                onSelected: (bool selected) {
                                  controller.selectWeekplan('Villa');
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
                                controller: bookingcontrolle.instruction,
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
    if (bookingcontrolle.hours.value == 0) {
      logger.d(bookingcontrolle.hours.value);
      showSnackBar(LocaleKeys.snack_bars_select_hours.tr, true);
    } else if (bookingcontrolle.instruction.value.text == "") {
      showSnackBar(LocaleKeys.snack_bars_add_discription.tr, true);
    } else if (controller.selectedweekplan.value == "") {
      showSnackBar(LocaleKeys.snack_bars_select_house_size.tr, true);
    } else {
      Get.to(() => BookingDetailsView(
            model: BookingController.to.servicemodel,
          ));
    }
  }
}
