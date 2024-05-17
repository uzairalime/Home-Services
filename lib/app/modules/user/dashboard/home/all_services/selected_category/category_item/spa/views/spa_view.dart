import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../../../../consts/app_color.dart';
import '../../../../../../../../../../generated/locales.g.dart';
import '../../../../../../../../../../services/apis/toast.dart';
import '../../../../../../../../../../utils/logger.dart';
import '../../../../../../../../../../utils/style.dart';
import '../../../../../../../../../../widget/cText.dart';
import '../../../../../../../../../../widget/c_filled_btn.dart';
import '../../house_cleaning/controllers/booking_controller.dart';
import '../../house_cleaning/views/booking_details_view.dart';
import '../controllers/spa_controller.dart';

class SpaView extends GetView<BookingController> {
  const SpaView({super.key});

  @override
  Widget build(BuildContext context) {
    // BookingController.to.claculateBill();

    // controller.claculateBill();
    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final titleSmall = Theme.of(context).textTheme.titleSmall!.fontSize;
    final titlelarge = Theme.of(context).textTheme.titleLarge!.fontSize;

    final obj = Get.put(SpaController());

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
            LocaleKeys.spa_spa.tr,
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
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CText(
                      text: LocaleKeys.house_cleaning_items_how_many_hours.tr,
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
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CText(
                                text: LocaleKeys.house_cleaning_items_hours.tr,
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
                    // CText(
                    //   text: "How many number of rooms",
                    //   fontsize: titlelarge,
                    //   fontWeight: bold4,
                    // ),
                    // SizedBox(
                    //   height: height * 0.01,
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.only(bottom: height * 0.02),
                    //   child: Container(
                    //     width: widht,
                    //     height: height * 0.075,
                    //     decoration: BoxDecoration(
                    //         color: const Color(0xffF5F5F5),
                    //         borderRadius: BorderRadius.circular(8)),
                    //     child: Padding(
                    //       padding: const EdgeInsets.only(left: 12, right: 12),
                    //       child: Row(
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         children: [
                    //           CText(
                    //             text: "Rooms",
                    //             fontWeight: bold6,
                    //             fontsize: 16,
                    //           ),
                    //           const Spacer(),
                    //           InkWell(
                    //             onTap: () {
                    //               controller.cleaner_decrese();
                    //               controller.claculateBill();
                    //             },
                    //             child: Container(
                    //               width: widht * 0.1,
                    //               height: height * 0.055,
                    //               decoration: const BoxDecoration(
                    //                   color: Color(0xffF1E7FF), shape: BoxShape.circle),
                    //               child: const Center(
                    //                 child: Icon(
                    //                   Icons.remove,
                    //                   size: 16,
                    //                   color: AppColor.primary,
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //           SizedBox(
                    //             width: widht * 0.04,
                    //           ),
                    //           CText(
                    //             text: controller.cleaner.value.toString(),
                    //             fontWeight: FontWeight.bold,
                    //           ),
                    //           SizedBox(
                    //             width: widht * 0.04,
                    //           ),
                    //           InkWell(
                    //             onTap: () {
                    //               controller.cleaner.value++;
                    //               controller.claculateBill();
                    //             },
                    //             child: Container(
                    //               width: widht * 0.1,
                    //               height: height * 0.055,
                    //               decoration: const BoxDecoration(
                    //                   color: Color(0xffF1E7FF), shape: BoxShape.circle),
                    //               child: const Center(
                    //                 child: Icon(
                    //                   Icons.add,
                    //                   size: 16,
                    //                   color: AppColor.primary,
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    //
                    SizedBox(
                      height: height * 0.01,
                    ),
                    CText(
                      text: LocaleKeys.spa_services.tr,
                      fontsize: titlelarge,
                      fontWeight: bold4,
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),

                    SizedBox(
                      width: double.maxFinite,
                      child: Wrap(
                        children: obj.serviceslabel.map((insect) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: ChoiceChip(
                              shape: StadiumBorder(
                                  side: BorderSide(
                                      color:
                                          obj.selectedServices.contains(insect)
                                              ? Colors.transparent
                                              : AppColor.primary)),
                              labelPadding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 3),
                              backgroundColor: AppColor.white,
                              selectedColor: AppColor.primary,
                              showCheckmark: false,
                              label: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(insect,
                                    style: TextStyle(
                                        color: obj.selectedServices
                                                .contains(insect)
                                            ? AppColor.white
                                            : Colors.black)),
                              ),
                              selected: obj.selectedServices.contains(insect),
                              onSelected: (isSelected) {
                                obj.toggleSelection(insect);
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      child: CText2(
                          textAlign: TextAlign.start,
                          fontsize: titleSmall,
                          text: LocaleKeys
                              .house_cleaning_items_addditional_charges_aed.tr),
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
                                  .house_cleaning_items_example_insutruction.tr,
                              hintStyle: TextStyle(fontSize: titleSmall),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: const BorderSide(
                                      color: AppColor.secondary)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0)))),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
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
