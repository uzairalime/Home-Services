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
    // BookingController.to.claculateBill();
    final obj = Get.put(MenSalonController());

    // controller.claculateBill();
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
              LocaleKeys.men_saloon_men_saloon.tr,
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
                            text: LocaleKeys.men_saloon_which_type_service.tr,
                            fontsize: titlelarge,
                            fontWeight: bold4,
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            child: Wrap(
                              children: obj.insectlabel.map((insect) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  child: ChoiceChip(
                                    shape: StadiumBorder(
                                        side: BorderSide(
                                            color: obj.selectedInsects.contains(insect)
                                                ? Colors.transparent
                                                : AppColor.primary)),
                                    labelPadding:
                                        const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                                    backgroundColor: AppColor.white,
                                    selectedColor: AppColor.primary,
                                    showCheckmark: false,
                                    label: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text(insect,
                                          style: TextStyle(
                                              color: obj.selectedInsects.contains(insect)
                                                  ? AppColor.white
                                                  : Colors.black)),
                                    ),
                                    selected: obj.selectedInsects.contains(insect),
                                    onSelected: (isSelected) {
                                      obj.toggleSelection(insect);
                                      obj.update();
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
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
      showSnackBar(LocaleKeys.snack_bars_select_hours.tr, true);
    } else if (controller.cleaner.value == 0) {
      showSnackBar(LocaleKeys.snack_bars_select_cleanrs.tr, true);
    } else if (MenSalonController.to.selectedInsects.value.isEmpty) {
      showSnackBar(LocaleKeys.snack_bars_select_service.tr, true);
    } else if (controller.selectedmaterial.isEmpty) {
      showSnackBar(LocaleKeys.snack_bars_select_materials.tr, true);
    } else {
      Get.to(() => BookingDetailsView(
            model: BookingController.to.servicemodel,
          ));
    }
  }
}
