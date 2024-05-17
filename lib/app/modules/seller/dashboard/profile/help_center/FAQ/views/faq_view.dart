import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/generated/locales.g.dart';
import 'package:home_brigadier/utils/style.dart';
import 'package:home_brigadier/widget/cText.dart';

import '../../../../../../../../consts/media_query.dart';
import '../controllers/faq_controller.dart';

class FaqView extends GetView<FaqController> {
  const FaqView({super.key});

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme.titleMedium!.color;

    // final titleSmall = Theme.of(context).textTheme.titleSmall!.fontSize;
    // final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return GetBuilder<FaqController>(
        init: Get.put(FaqController()),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              leading: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/icons/ic_launcher_icon.png")),
                    borderRadius: BorderRadius.all(Radius.circular(6))),
              ),
              title: CText(
                  text: LocaleKeys.faq_items_faq.tr,
                  fontWeight: FontWeight.bold,
                  color: txtTheme,
                  fontsize: mediaQueryHeight(context) * 0.025),
            ),
            body: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: mediaQueryHeight(context) * 0.012,
                  horizontal: mediaQueryWidth(context) * 0.05,
                ),
                child: Column(children: [
                  DefaultTabController(
                      length: 7,
                      initialIndex: 0,
                      animationDuration: const Duration(milliseconds: 3),
                      child: Column(children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                          height: height * 0.04,
                          child: ButtonsTabBar(
                              radius: 35,
                              buttonMargin:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              contentPadding: const EdgeInsets.only(
                                  left: 18, right: 18, top: 0, bottom: 0),
                              backgroundColor: AppColor.primary,
                              borderWidth: 1,
                              borderColor: AppColor.primary,
                              unselectedBackgroundColor: Colors.transparent,
                              unselectedLabelStyle: unselectedtab,
                              unselectedBorderColor: AppColor.primary,
                              labelStyle: selectedtab,
                              tabs: [
                                Tab(
                                    text: LocaleKeys
                                        .faq_items_tabba_items_general.tr),
                                Tab(
                                    text: LocaleKeys
                                        .faq_items_tabba_items_account.tr),
                                Tab(
                                    text: LocaleKeys
                                        .faq_items_tabba_items_service.tr),
                                Tab(
                                    text: LocaleKeys
                                        .faq_items_tabba_items_payment.tr),
                                Tab(
                                    text: LocaleKeys
                                        .faq_items_tabba_items_appliance.tr),
                                Tab(
                                    text: LocaleKeys
                                        .faq_items_tabba_items_Plumbing.tr),
                                Tab(
                                    text: LocaleKeys
                                        .faq_items_tabba_items_shifting.tr),
                              ]),
                        ),
                        SizedBox(height: mediaQueryHeight(context) * 0.02)
                      ])),
                  // CTextField(
                  //     hint: LocaleKeys.faq_items_enter_search.tr,
                  //     controller: TextEditingController(),
                  //     borderColor: Colors.transparent,
                  //     filled: true,
                  //     contentPadding: 15,
                  //     fillColor: AppColor.grey.withOpacity(0.1),
                  //     suffix: SvgPicture.asset("assets/icons/ic_filter.svg",
                  //         fit: BoxFit.scaleDown),
                  //     borderRadius: 12),
                  // const SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        ExpandedTile(
                            title: LocaleKeys
                                .faq_items_questions_item_what_hamb.tr,
                            detail: LocaleKeys
                                .faq_items_questions_item_what_hamb_detail.tr),
                        ExpandedTile(
                            title:
                                LocaleKeys.faq_items_questions_item_why_hamb.tr,
                            detail: LocaleKeys
                                .faq_items_questions_item_why_hamb_detail.tr),
                        ExpandedTile(
                            title: LocaleKeys
                                .faq_items_questions_item_booking_hamo.tr,
                            detail: LocaleKeys
                                .faq_items_questions_item_booking_hamo_detail
                                .tr),
                        ExpandedTile(
                            title: LocaleKeys
                                .faq_items_questions_item_how_pay_service.tr,
                            detail: LocaleKeys
                                .faq_items_questions_item_how_pay_service_detail
                                .tr),
                        ExpandedTile(
                            title: LocaleKeys
                                .faq_items_questions_item_cancel_change_service
                                .tr,
                            detail: LocaleKeys
                                .faq_items_questions_item_cancel_change_service_detail
                                .tr),
                        ExpandedTile(
                            title: LocaleKeys
                                .faq_items_questions_item_personal_info.tr,
                            detail: LocaleKeys
                                .faq_items_questions_item_personal_info_detail
                                .tr),
                      ],
                    ),
                  )
                ])),
          );
        });
  }
}

class ExpandedTile extends StatelessWidget {
  const ExpandedTile({super.key, required this.title, required this.detail});

  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 10,
        child: ExpansionTile(
          trailing: const Icon(Icons.arrow_drop_down_rounded,
              color: AppColor.secondary),
          childrenPadding: const EdgeInsets.all(15),
          shape: const RoundedRectangleBorder(side: BorderSide.none),
          backgroundColor: Colors.transparent,
          title: CText2(text: title, textAlign: TextAlign.left),
          children: [CText2(text: detail, textAlign: TextAlign.left)],
        ));
  }
}
