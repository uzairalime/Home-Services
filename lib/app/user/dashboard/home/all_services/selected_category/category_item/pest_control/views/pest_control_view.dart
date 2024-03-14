import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/pest_control/controllers/pest_control_controller.dart';

import '../../../../../../../../../consts/app_color.dart';
import '../../../../../../../../../generated/locales.g.dart';
import '../../../../../../../../../services/apis/toast.dart';
import '../../../../../../../../../utils/logger.dart';
import '../../../../../../../../../utils/style.dart';
import '../../../../../../../../../widget/cText.dart';
import '../../../../../../../../../widget/c_filled_btn.dart';
import '../../house_cleaning/controllers/booking_controller.dart';
import '../../house_cleaning/views/booking_details_view.dart';

class PestControlBookingView extends GetView<BookingController> {
  const PestControlBookingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BookingController.to.claculateBill();

    controller.claculateBill();
    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final titleSmall = Theme.of(context).textTheme.titleSmall!.fontSize;
    final titlelarge = Theme.of(context).textTheme.titleLarge!.fontSize;

    final obj = Get.put(PestControlController());

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
                  padding: const EdgeInsets.only(top: 30, bottom: 20, left: 20, right: 20),
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
              "Pest Control",
              style: appbar,
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              width: widht,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: widht * 0.05, vertical: height * 0.025),
                  child: Obx(() => Column(
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
                                            color: Color(0xffF1E7FF), shape: BoxShape.circle),
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
                                            color: Color(0xffF1E7FF), shape: BoxShape.circle),
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
                            text: "How many number of rooms",
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
                                      text: "Rooms",
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
                                            color: Color(0xffF1E7FF), shape: BoxShape.circle),
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
                                            color: Color(0xffF1E7FF), shape: BoxShape.circle),
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
                            text: LocaleKeys.house_cleaning_items_how_often_need_claning.tr,
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
                                      labelPadding:
                                          const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
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
                                          color: controller.selectedweekplan.value == 'General'
                                              ? AppColor.white
                                              : AppColor.black,
                                          text: LocaleKeys.house_cleaning_items_once.tr),
                                      selected: controller.selectedweekplan.value == 'General',
                                      onSelected: (bool selected) {
                                        controller.selectWeekplan('General');
                                      },
                                    ),
                                    SizedBox(
                                      width: widht * 0.05,
                                    ),
                                    ChoiceChip(
                                      labelPadding:
                                          const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
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
                                          color: controller.selectedweekplan.value == 'Cockroaches'
                                              ? AppColor.white
                                              : AppColor.black,
                                          text: LocaleKeys.house_cleaning_items_weekly.tr),
                                      selected: controller.selectedweekplan.value == 'Cockroaches',
                                      onSelected: (bool selected) {
                                        controller.selectWeekplan('Cockroaches');
                                      },
                                    ),
                                    SizedBox(
                                      width: widht * 0.05,
                                    ),
                                    ChoiceChip(
                                      labelPadding:
                                          const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                      backgroundColor: AppColor.white,
                                      selectedColor: AppColor.secondary,
                                      shape: StadiumBorder(
                                          side: BorderSide(
                                              color: controller.selectedmaterial.value == 'Big Bugs'
                                                  ? AppColor.secondary
                                                  : AppColor.secondary)),
                                      label: CText(
                                          color: controller.selectedweekplan.value == 'Big Bugs'
                                              ? AppColor.white
                                              : AppColor.black,
                                          text: LocaleKeys.house_cleaning_items_Bi_weekly.tr),
                                      selected: controller.selectedweekplan.value == 'Big Bugs',
                                      onSelected: (bool selected) {
                                        controller.selectWeekplan('Big Bugs');
                                      },
                                    ),
                                  ],
                                ),
                                ChoiceChip(
                                  labelPadding:
                                      const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
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
                                      color: controller.selectedweekplan.value == 'Rodents'
                                          ? AppColor.white
                                          : AppColor.black,
                                      text: LocaleKeys.house_cleaning_items_Mutilple_time.tr),
                                  selected: controller.selectedweekplan.value == 'Rodents',
                                  onSelected: (bool selected) {
                                    controller.selectWeekplan('Rodents');
                                  },
                                ),
                              ],
                            ),
                          ),

                          // SizedBox(
                          //   height: height * 0.01
                          // ),
                          // CText(
                          //   text: LocaleKeys.house_cleaning_items_did_need_material.tr,
                          //   fontsize: titlelarge,
                          //   fontWeight: bold4,
                          // ),
                          // SizedBox(
                          //   height: height * 0.01,
                          // ),
                          //
                          // SizedBox(
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     children: [
                          //       ChoiceChip(
                          //         label: CText(
                          //             color: controller.selectedmaterial == 'Yes'
                          //                 ? AppColor.white
                          //                 : AppColor.black,
                          //             text: LocaleKeys.house_cleaning_items_yes.tr),
                          //         selected: controller.selectedmaterial.value == 'Yes',
                          //         onSelected: (bool selected) {
                          //           controller.selectMaterials('Yes');
                          //           controller.claculateBill();
                          //         },
                          //         labelPadding:
                          //             const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                          //         backgroundColor: AppColor.white,
                          //         selectedColor: AppColor.secondary,
                          //         shape: StadiumBorder(
                          //             side: BorderSide(
                          //                 color: controller.selectedmaterial.value == 'Yes'
                          //                     ? AppColor.secondary
                          //                     : AppColor.secondary)),
                          //       ),
                          //       SizedBox(
                          //         width: widht * 0.05,
                          //       ),
                          //       ChoiceChip(
                          //         labelPadding:
                          //             const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                          //         backgroundColor: AppColor.white,
                          //         selectedColor: AppColor.secondary,
                          //         shape: StadiumBorder(
                          //             side: BorderSide(
                          //                 color: controller.selectedmaterial.value == 'No'
                          //                     ? AppColor.secondary
                          //                     : AppColor.secondary)),
                          //         label: CText(
                          //             color: controller.selectedmaterial == 'No'
                          //                 ? AppColor.white
                          //                 : AppColor.black,
                          //             text: LocaleKeys.house_cleaning_items_no.tr),
                          //         selected: controller.selectedmaterial.value == 'No',
                          //         onSelected: (bool selected) {
                          //           controller.selectMaterials('No');
                          //           controller.claculateBill();
                          //         },
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          SizedBox(
                            child: CText(
                                textAlign: TextAlign.start,
                                fontsize: titleSmall,
                                text: LocaleKeys.house_cleaning_items_addditional_charges_aed.tr),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          CText(
                            text: LocaleKeys.house_cleaning_items_special_insutuction.tr,
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
                                    hintText:
                                        LocaleKeys.house_cleaning_items_example_insutruction.tr,
                                    hintStyle: TextStyle(fontSize: titleSmall),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                        borderSide: const BorderSide(color: AppColor.secondary)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0)))),
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
      showsnackbar("please select hours", true);
    } else if (controller.cleaner.value == 0) {
      showsnackbar("please select cleaners", true);
    } else if (controller.selectedweekplan.value.isEmpty) {
      showsnackbar("please select subscription", true);
    } else if (controller.selectedmaterial.isEmpty) {
      showsnackbar("please select materials", true);
    } else {
      Get.to(() => BookingDetailsView(
            model: BookingController.to.servicemodel,
          ));
    }
  }
}
