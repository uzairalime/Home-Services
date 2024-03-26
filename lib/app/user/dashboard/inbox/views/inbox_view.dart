import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/user/dashboard/inbox/calls/views/calls_view.dart';
import 'package:home_brigadier/app/user/dashboard/inbox/chats/controllers/chats_controller.dart';
import 'package:home_brigadier/app/user/dashboard/inbox/chats/views/chats_view.dart';

import '../../../../../consts/app_color.dart';
import '../../../../../consts/media_query.dart';
import '../../../../../widget/cText.dart';
import '../../../../../widget/c_icon_btn.dart';
import '../controllers/inbox_controller.dart';

class InboxView extends GetView<InboxController> {
  const InboxView({super.key});

  @override
  Widget build(BuildContext context) {
    final svgTheme = Theme.of(context).textTheme.titleMedium!.color;
    final txtTheme = Theme.of(context).textTheme.titleMedium!.color;
    final chatObj = Get.put(ChatsController());
    return GetBuilder<InboxController>(
        init: Get.put(InboxController()),
        builder: (builderContext) {
          return DefaultTabController(
              length: 2,
              child: Scaffold(
                  appBar: AppBar(
                      leading: Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(8.0),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              color: AppColor.secondary),
                          child: SvgPicture.asset("assets/icons/ic_logo.svg")),
                      title: CText(
                          text: "Inbox",
                          fontWeight: FontWeight.bold,
                          color: txtTheme,
                          fontsize: mediaQueryHeight(context) * 0.025),
                      actions: [
                        CIconBtn(
                            onPressed: () {},
                            child: SvgPicture.asset(
                                "assets/icons/ic_search.svg",
                                height: 20,
                                color: svgTheme)),
                        Obx(() => chatObj.selectedItems.value.isEmpty
                            ? CIconBtn(
                                onPressed: () {},
                                child: SvgPicture.asset(
                                    "assets/icons/ic_more_outlined.svg",
                                    color: svgTheme))
                            : TextButton(
                                onPressed: () {
                                  chatObj.selectedItems.value.clear();
                                },
                                child: const CText(text: "Cancel")))
                      ],
                      bottom: TabBar(
                          padding: EdgeInsets.symmetric(
                              horizontal: mediaQueryWidth(context) * 0.05),
                          automaticIndicatorColorAdjustment: true,
                          indicatorWeight: 3,
                          tabs: const [
                            Tab(text: 'Chats'),
                            Tab(text: 'Calls')
                          ])),
                  body: const TabBarView(children: [ChatsView(), CallsView()]),
                  floatingActionButton: FloatingActionButton(
                      onPressed: () {},
                      child: const Icon(Icons.add, color: AppColor.white))));
        });
  }
}
