import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../../consts/app_color.dart';
import '../../../../../../../consts/media_query.dart';
import '../../../../../../../widget/cText.dart';
import '../../../../../../../widget/c_icon_btn.dart';
import '../FAQ/views/faq_view.dart';
import '../contact_us/views/contact_us_view.dart';
import '../controllers/help_center_controller.dart';

class HelpCenterView extends GetView<HelpCenterController> {
  const HelpCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    final svgTheme = Theme.of(context).textTheme.titleMedium!.color;
    final txtTheme = Theme.of(context).textTheme.titleMedium!.color;
    final bodyLarge = Theme.of(context).textTheme.bodyLarge!.fontSize;
    return GetBuilder<HelpCenterController>(
        init: Get.put(HelpCenterController()),
        builder: (builderContext) {
          return DefaultTabController(
              length: 2,
              child: Scaffold(
                  appBar: AppBar(
                      leading: CIconBtn(
                          onPressed: () => Get.back(),
                          child: Icon(Icons.adaptive.arrow_back)),
                      title: CText(
                          text: "Notification",
                          color: txtTheme,
                          fontsize: bodyLarge,
                          fontWeight: FontWeight.w500),
                      actions: [
                        CIconBtn(
                            onPressed: () {},
                            child: SvgPicture.asset(
                                "assets/icons/ic_more_outlined.svg",
                                color: svgTheme))
                      ],
                      bottom: TabBar(
                          padding: EdgeInsets.symmetric(
                              horizontal: mediaQueryWidth(context) * 0.05),
                          automaticIndicatorColorAdjustment: true,
                          indicatorWeight: 3,
                          tabs: const [
                            Tab(text: 'FAQ'),
                            Tab(text: 'Contact us')
                          ])),
                  body:
                      const TabBarView(children: [FaqView(), ContactUsView()]),
                  floatingActionButton: FloatingActionButton(
                      onPressed: () {},
                      child: const Icon(Icons.add, color: AppColor.white))));
        });
  }
}
