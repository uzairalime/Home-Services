import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/consts/media_query.dart';
import 'package:home_brigadier/widget/cText.dart';
import 'package:home_brigadier/widget/c_text_field.dart';

import '../../../../../../../consts/app_color.dart';
import '../../../../../../../widget/c_icon_btn.dart';
import '../controllers/user_chat_controller.dart';

class UserChatView extends GetView<UserChatController> {
  const UserChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final svgTheme = Theme.of(context).textTheme.titleMedium!.color;
    final txtTheme = Theme.of(context).textTheme.titleMedium!.color;
    final titleLarge = Theme.of(context).textTheme.titleLarge!.fontSize;

    return Scaffold(
        appBar: AppBar(
            leading: CIconBtn(
                onPressed: () => Get.back(),
                child: Icon(Icons.adaptive.arrow_back)),
            title: CText(
                text: "Jenny Wilson", color: txtTheme, fontsize: titleLarge),
            actions: [
              CIconBtn(
                  onPressed: () {},
                  child: SvgPicture.asset("assets/icons/ic_phone_outlined.svg",
                      height: 20, color: svgTheme)),
              CIconBtn(
                  onPressed: () {},
                  child: SvgPicture.asset("assets/icons/ic_more_outlined.svg",
                      color: svgTheme))
            ]),
        floatingActionButton: SizedBox(
            height: mediaQueryHeight(context) * 0.09,
            width: mediaQueryWidth(context) * 0.9,
            child: Row(children: [
              Expanded(
                  child: CTextField(
                      hint: "Message",
                      controller: controller.smsController,
                      borderColor: Colors.transparent,
                      filled: true,
                      fillColor: AppColor.grey.withOpacity(0.1),
                      focusBorderColor: AppColor.secondary,
                      suffix: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(25),
                          child: SvgPicture.asset(
                              color: svgTheme,
                              fit: BoxFit.scaleDown,
                              "assets/icons/ic_gallery_outlined.svg")),
                      borderRadius: 12)),
              CIconBtn(
                  onPressed: () {},
                  child: Stack(alignment: Alignment.center, children: [
                    SvgPicture.asset("assets/icons/ic_circle_filled.svg",
                        color: AppColor.secondary),
                    SvgPicture.asset("assets/icons/ic_mic_light.svg")
                  ]))
            ])));
  }
}
