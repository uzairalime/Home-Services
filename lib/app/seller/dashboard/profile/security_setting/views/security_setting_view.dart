import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/widget/c_filled_btn.dart';

import '../../../../../../consts/app_color.dart';
import '../../../../../../consts/media_query.dart';
import '../../../../../../widget/cText.dart';
import '../../../../../../widget/c_icon_btn.dart';
import '../controllers/security_setting_controller.dart';

class SecuritySettingView extends GetView<SecuritySettingController> {
  const SecuritySettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme.titleMedium!.color;
    final titleMedium = Theme.of(context).textTheme.titleMedium!.fontSize;
    final titleLarge = Theme.of(context).textTheme.titleLarge!.fontSize;
    return Scaffold(
        appBar: AppBar(
            leading: CIconBtn(onPressed: () => Get.back(), child: Icon(Icons.adaptive.arrow_back)),
            title: CText(
                text: "Security",
                color: txtTheme,
                fontsize: titleLarge,
                fontWeight: FontWeight.w500)),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: mediaQueryWidth(context) * 0.05,
            ),
            child: Obx(() => Column(children: [
                  NotificationListTile(
                      title: "Remember me",
                      btn: Switch.adaptive(
                          activeTrackColor: AppColor.secondary,
                          value: controller.rememberSwitch.value,
                          onChanged: (value) {
                            controller.securitySwitch(value: value, title: "Remember me");
                          })),
                  NotificationListTile(
                      title: "Face ID",
                      btn: Switch.adaptive(
                          activeTrackColor: AppColor.secondary,
                          value: controller.faceIdSwitch.value,
                          onChanged: (value) {
                            controller.securitySwitch(value: value, title: "Face ID");
                          })),
                  NotificationListTile(
                      title: "Biometric ID",
                      btn: Switch.adaptive(
                          activeTrackColor: AppColor.secondary,
                          value: controller.bioMetricSwitch.value,
                          onChanged: (value) {
                            controller.securitySwitch(value: value, title: "Biometric ID");
                          })),
                  const NotificationListTile(
                      title: "Google Authentication", btn: Icon(Icons.arrow_forward_ios, size: 20)),
                  CButton(
                    text: "Change PIN",
                    btnheight: kToolbarHeight,
                    bgcolor: AppColor.grey.withOpacity(0.2),
                    fontsize: titleMedium,
                    txtcolor: AppColor.secondary,
                    borderradius: 50,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 20),
                  CButton(
                    text: "Change Password",
                    btnheight: kToolbarHeight,
                    bgcolor: AppColor.grey.withOpacity(0.2),
                    fontsize: titleMedium,
                    txtcolor: AppColor.secondary,
                    borderradius: 50,
                    fontWeight: FontWeight.w500,
                  ),
                ]))));
  }
}

class NotificationListTile extends StatelessWidget {
  const NotificationListTile({super.key, required this.title, required this.btn});

  final String title;
  final Widget btn;

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme.titleMedium!.color;
    final titleMedium = Theme.of(context).textTheme.titleMedium!.fontSize;
    return SizedBox(
      height: mediaQueryHeight(context) * 0.075,
      child: ListTile(
          title: CText(
            text: title,
            color: txtTheme,
            fontsize: titleMedium,
            textAlign: TextAlign.left,
            fontWeight: FontWeight.w500,
          ),
          trailing: Transform.scale(scale: 0.8, child: btn)),
    );
  }
}
