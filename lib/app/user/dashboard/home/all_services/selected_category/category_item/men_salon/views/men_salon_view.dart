import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/house_cleaning/controllers/booking_controller.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/house_cleaning/views/booking_details_view.dart';

import '../../../../../../../../../consts/app_color.dart';
import '../../../../../../../../../generated/locales.g.dart';
import '../../../../../../../../../services/apis/toast.dart';
import '../../../../../../../../../utils/logger.dart';
import '../../../../../../../../../utils/style.dart';
import '../../../../../../../../../widget/cText.dart';
import '../../../../../../../../../widget/c_filled_btn.dart';
import '../controllers/men_salon_controller.dart';

class MenSalonView extends GetView<BookingController> {
  const MenSalonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    BookingController.to.claculateBill();
    final obj = Get.put(MenSalonController());

    controller.claculateBill();
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
                  padding: const EdgeInsets.only(top: 30, bottom: 20, left: 20, right: 20),
                  child: CButton(
                      borderradius: width * 0.075,
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
              "Men Saloon",
              style: appbar,
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              width: width,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.025),
                  child: Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: height * 0.01,
                          ),
                          CText(
                            text: "Which Service do you need?",
                            fontsize: titlelarge,
                            fontWeight: bold4,
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          SizedBox(
                            // color: Colors.amber,
                            child: Wrap(
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
                                      color: obj.selectedweekplan.value == 'Haircut for Men & Kids'
                                          ? AppColor.white
                                          : AppColor.black,
                                      text: "Haircut for Men & Kids"),
                                  selected: obj.selectedweekplan.value == 'Haircut for Men & Kids',
                                  onSelected: (bool selected) {
                                    obj.selectedweekplan.value = 'Shave/beard Gromming';
                                    obj.selectWeekplan('Haircut for Men & Kids');
                                  },
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
                                      color: obj.selectedweekplan == 'Shave/beard Gromming'
                                          ? AppColor.white
                                          : AppColor.black,
                                      text: "Shave/beard Gromming"),
                                  selected: obj.selectedweekplan.value == 'Shave/beard Gromming',
                                  onSelected: (bool selected) {
                                    obj.selectedweekplan.value = 'Shave/beard Gromming';
                                    obj.selectWeekplan('Shave/beard Gromming');
                                  },
                                ),
                                SizedBox(
                                  width: width * 0.01,
                                ),
                                ChoiceChip(
                                  labelPadding:
                                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                  backgroundColor: AppColor.white,
                                  selectedColor: AppColor.secondary,
                                  shape: StadiumBorder(
                                      side: BorderSide(
                                          color: obj.selectedweekplan.value == 'Face Waxing'
                                              ? AppColor.secondary
                                              : AppColor.secondary)),
                                  label: CText(
                                      color: obj.selectedweekplan == 'Face Waxing'
                                          ? AppColor.white
                                          : AppColor.black,
                                      text: "Face Waxing"),
                                  selected: obj.selectedweekplan.value == 'Face Waxing',
                                  onSelected: (bool selected) {
                                    obj.selectedweekplan.value = 'Shave/beard Gromming';
                                    obj.selectWeekplan('Face Waxing');
                                  },
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
                                      color: obj.selectedweekplan.value == 'Pedicure & Menicure'
                                          ? AppColor.white
                                          : AppColor.black,
                                      text: "Pedicure & Menicure".tr),
                                  selected: obj.selectedweekplan.value == 'Pedicure & Menicure',
                                  onSelected: (bool selected) {
                                    obj.selectedweekplan.value = 'Shave/beard Gromming';
                                    obj.selectWeekplan('Pedicure & Menicure');
                                  },
                                ),
                                SizedBox(
                                  width: width * 0.01,
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
                                      color: obj.selectedweekplan.value == 'Face Care'
                                          ? AppColor.white
                                          : AppColor.black,
                                      text: "Face Care".tr),
                                  selected: obj.selectedweekplan.value == 'Face Care',
                                  onSelected: (bool selected) {
                                    obj.selectedweekplan.value = 'Shave/beard Gromming';
                                    obj.selectWeekplan('Face Care');
                                  },
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
                                      color: obj.selectedweekplan.value == 'Express Massage'
                                          ? AppColor.white
                                          : AppColor.black,
                                      text: "Express Massage".tr),
                                  selected: obj.selectedweekplan.value == 'Express Massage',
                                  onSelected: (bool selected) {
                                    obj.selectedweekplan.value = 'Shave/beard Gromming';
                                    obj.selectWeekplan('Express Massage');
                                  },
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
                                      color: obj.selectedweekplan.value == 'Chest/back Trimming'
                                          ? AppColor.white
                                          : AppColor.black,
                                      text: "Chest/back Trimming".tr),
                                  selected: obj.selectedweekplan.value == 'Chest/back Trimming',
                                  onSelected: (bool selected) {
                                    obj.selectedweekplan.value = 'Shave/beard Gromming';
                                    obj.selectWeekplan('Chest/back Trimming');
                                  },
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
                                      color: obj.selectedweekplan.value == 'Hair & Beard Color'
                                          ? AppColor.white
                                          : AppColor.black,
                                      text: "Hair & Beard Color".tr),
                                  selected: obj.selectedweekplan.value == 'Hair & Beard Color',
                                  onSelected: (bool selected) {
                                    obj.selectedweekplan.value = 'Shave/beard Gromming';
                                    obj.selectWeekplan('Hair & Beard Color');
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
                                text: LocaleKeys.house_cleaning_items_addditional_charges_aed.tr),
                          ),
                          SizedBox(
                            height: height * 0.01,
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
                            width: width,
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
    } else if (MenSalonController.to.selectedweekplan.value.isEmpty) {
      showsnackbar("please select Service", true);
    } else if (controller.selectedmaterial.isEmpty) {
      showsnackbar("please select materials", true);
    } else {
      Get.to(() => BookingDetailsView(
            model: BookingController.to.servicemodel,
          ));
    }
  }
}
