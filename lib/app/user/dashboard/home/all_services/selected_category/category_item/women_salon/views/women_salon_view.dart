import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../../../consts/app_color.dart';
import '../../../../../../../../../generated/locales.g.dart';
import '../../../../../../../../../services/apis/toast.dart';
import '../../../../../../../../../utils/logger.dart';
import '../../../../../../../../../utils/style.dart';
import '../../../../../../../../../widget/cText.dart';
import '../../../../../../../../../widget/c_filled_btn.dart';
import '../../house_cleaning/controllers/booking_controller.dart';
import '../../house_cleaning/views/booking_details_view.dart';
import '../controllers/women_salon_controller.dart';

class WomenSalonView extends GetView<BookingController> {
  WomenSalonView({Key? key}) : super(key: key);
  final bookingcontroller = Get.put(BookingController());
  @override
  Widget build(BuildContext context) {
    final womencontoller = Get.put(WomenSalonController());
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    BookingController.to.claculateBill();

    bookingcontroller.claculateBill();
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
                      borderradius: width * 0.075,
                      text:
                          "${LocaleKeys.house_cleaning_items_cont_button.tr} ${bookingcontroller.total.value} AED ",
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
              LocaleKeys.women_saloon_women_saloon.tr,
              style: appbar,
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              width: width,
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05, vertical: height * 0.025),
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
                            // color: Colors.amber,
                            child: Wrap(
                              spacing: width * 0.02,
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
                                    borderRadius: BorderRadius.circular(22.0),
                                  ),
                                  label: CText(
                                      color: womencontoller
                                                  .selectedweekplan.value ==
                                              'Bridal packages'
                                          ? AppColor.white
                                          : AppColor.black,
                                      text: LocaleKeys
                                          .women_saloon_bridal_package.tr),
                                  selected:
                                      womencontoller.selectedweekplan.value ==
                                          'Bridal packages',
                                  onSelected: (bool selected) {
                                    womencontoller.selectedweekplan.value =
                                        'Shave/beard Gromming';
                                    womencontoller
                                        .selectWeekplan('Bridal packages');
                                    womencontoller.update();
                                  },
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
                                    borderRadius: BorderRadius.circular(22.0),
                                  ),
                                  label: CText(
                                      color: womencontoller
                                                  .selectedweekplan.value ==
                                              'Skin treatments'
                                          ? AppColor.white
                                          : AppColor.black,
                                      text: LocaleKeys
                                          .women_saloon_skin_treatment.tr),
                                  selected:
                                      womencontoller.selectedweekplan.value ==
                                          'Skin treatments',
                                  onSelected: (bool selected) {
                                    womencontoller.selectedweekplan.value =
                                        'Skin treatments';
                                    womencontoller
                                        .selectWeekplan('Skin treatments');
                                    womencontoller.update();
                                  },
                                ),
                                SizedBox(
                                  width: width * 0.01,
                                ),
                                ChoiceChip(
                                  labelPadding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 3),
                                  backgroundColor: AppColor.white,
                                  selectedColor: AppColor.secondary,
                                  shape: StadiumBorder(
                                      side: BorderSide(
                                          color: womencontoller
                                                      .selectedweekplan.value ==
                                                  'Face Waxing'
                                              ? AppColor.secondary
                                              : AppColor.secondary)),
                                  label: CText(
                                      color: womencontoller
                                                  .selectedweekplan.value ==
                                              'Face Waxing'
                                          ? AppColor.white
                                          : AppColor.black,
                                      text: LocaleKeys
                                          .women_saloon_face_waxing.tr),
                                  selected:
                                      womencontoller.selectedweekplan.value ==
                                          'Face Waxing',
                                  onSelected: (bool selected) {
                                    womencontoller.selectedweekplan.value =
                                        'Shave/beard Gromming';
                                    womencontoller
                                        .selectWeekplan('Face Waxing');
                                    womencontoller.update();
                                  },
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
                                      color: womencontoller
                                                  .selectedweekplan.value ==
                                              'Pedicure & Menicure'
                                          ? AppColor.white
                                          : AppColor.black,
                                      text:
                                          LocaleKeys.women_saloon_pedicure.tr),
                                  selected:
                                      womencontoller.selectedweekplan.value ==
                                          'Pedicure & Menicure',
                                  onSelected: (bool selected) {
                                    womencontoller.selectedweekplan.value =
                                        'Shave/beard Gromming';
                                    womencontoller
                                        .selectWeekplan('Pedicure & Menicure');
                                    womencontoller.update();
                                  },
                                ),
                                SizedBox(
                                  width: width * 0.01,
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
                                      color: womencontoller
                                                  .selectedweekplan.value ==
                                              'Face Care'
                                          ? AppColor.white
                                          : AppColor.black,
                                      text:
                                          LocaleKeys.women_saloon_face_care.tr),
                                  selected:
                                      womencontoller.selectedweekplan.value ==
                                          'Face Care',
                                  onSelected: (bool selected) {
                                    womencontoller.selectedweekplan.value =
                                        'Shave/beard Gromming';
                                    womencontoller.selectWeekplan('Face Care');
                                    womencontoller.update();
                                  },
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
                                      color: womencontoller
                                                  .selectedweekplan.value ==
                                              'Express Massage'
                                          ? AppColor.white
                                          : AppColor.black,
                                      text: LocaleKeys
                                          .women_saloon_express_massage.tr),
                                  selected:
                                      womencontoller.selectedweekplan.value ==
                                          'Express Massage',
                                  onSelected: (bool selected) {
                                    womencontoller.selectedweekplan.value =
                                        'Shave/beard Gromming';
                                    womencontoller
                                        .selectWeekplan('Express Massage');
                                    womencontoller.update();
                                  },
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
                                      color: womencontoller
                                                  .selectedweekplan.value ==
                                              'Hair Removing'
                                          ? AppColor.white
                                          : AppColor.black,
                                      text: LocaleKeys
                                          .women_saloon_hair_removing.tr),
                                  selected:
                                      womencontoller.selectedweekplan.value ==
                                          'Hair Removing',
                                  onSelected: (bool selected) {
                                    womencontoller.selectedweekplan.value =
                                        'Hair Removing';
                                    womencontoller
                                        .selectWeekplan('Hair Removing');
                                    womencontoller.update();
                                  },
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
                                      color: womencontoller
                                                  .selectedweekplan.value ==
                                              'Threading'
                                          ? AppColor.white
                                          : AppColor.black,
                                      text:
                                          LocaleKeys.women_saloon_threading.tr),
                                  selected:
                                      womencontoller.selectedweekplan.value ==
                                          'Threading',
                                  onSelected: (bool selected) {
                                    womencontoller.selectedweekplan.value =
                                        'Threading';
                                    womencontoller.selectWeekplan('Threading');
                                    womencontoller.update();
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
                            height: height * 0.01,
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
                            width: width,
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
          )),
    );
  }

  _onContinue() {
    if (bookingcontroller.hours.value == 0) {
      logger.d(bookingcontroller.hours.value);
      showsnackbar("please select hours", true);
    } else if (bookingcontroller.cleaner.value == 0) {
      showsnackbar("please select cleaners", true);
    } else if (controller.selectedweekplan.value.isEmpty) {
      showsnackbar("please select Service", true);
    } else {
      Get.to(() => BookingDetailsView(
            model: BookingController.to.servicemodel,
          ));
    }
  }
}
