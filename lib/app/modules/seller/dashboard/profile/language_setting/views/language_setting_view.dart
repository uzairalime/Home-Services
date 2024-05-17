import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/generated/locales.g.dart';

import '../../../../../../../consts/media_query.dart';
import '../../../../../../../widget/cText.dart';
import '../../../../../../../widget/c_icon_btn.dart';
import '../controllers/language_setting_controller.dart';

class LanguageSettingView extends GetView<LanguageSettingController> {
  const LanguageSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme.titleMedium!.color;
    final titleLarge = Theme.of(context).textTheme.titleLarge!.fontSize;
    Get.put(LanguageSettingController());
    return Scaffold(
      appBar: AppBar(
          leading: CIconBtn(
              onPressed: () => Get.back(),
              child: Icon(Icons.adaptive.arrow_back)),
          title: CText(
              text: LocaleKeys.dashboard_profile_language.tr,
              color: txtTheme,
              fontsize: titleLarge,
              fontWeight: FontWeight.w500)),
      body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: mediaQueryWidth(context) * 0.05, vertical: 20),
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [];
            },
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(thickness: 0.1),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.languages.length,
                    itemBuilder: (context, index) => NotificationListTile(
                      title: controller.languages[index],
                      // btn: Radio.adaptive(
                      //   value: controller.languages[index],
                      //   groupValue: controller.selectedLanguage.value,
                      //   onChanged: (value) {
                      //     controller.setSelectedLanguage(value);
                      //   },
                      // ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class NotificationListTile extends StatelessWidget {
  const NotificationListTile({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final LanguageSettingController controller = Get.find();
    final txtTheme = Theme.of(context).textTheme.titleMedium!.color;
    final bodyMedium = Theme.of(context).textTheme.bodyMedium!.fontSize;

    return SizedBox(
      height: mediaQueryHeight(context) * 0.075,
      child: ListTile(
        dense: true,
        title: CText(
          text: title,
          color: txtTheme,
          fontsize: bodyMedium,
          textAlign: TextAlign.left,
          fontWeight: FontWeight.w500,
        ),
        onTap: () {
          controller.setSelectedLanguage(title);
        },
        trailing: Obx(() => Transform.scale(
              scale: 0.8,
              child: Radio<String>(
                value: title,
                groupValue: controller.selectedLanguage.value,
                onChanged: (value) {
                  controller.setSelectedLanguage(value);
                },
              ),
            )),
      ),
    );
  }
}

// class NotificationListTile extends StatelessWidget {
//   const NotificationListTile({super.key, required this.title, required this.btn});
//
//   final String title;
//   final Widget btn;
//
//   @override
//   Widget build(BuildContext context) {
//     final txtTheme = Theme.of(context).textTheme.titleMedium!.color;
//     final bodyMedium = Theme.of(context).textTheme.bodyMedium!.fontSize;
//     return SizedBox(
//       height: mediaQueryHeight(context) * 0.075,
//       child: ListTile(
//           dense: true,
//           title: CText(
//             text: title,
//             color: txtTheme,
//             fontsize: bodyMedium,
//             textAlign: TextAlign.left,
//             fontWeight: FontWeight.w500,
//           ),
//           trailing: Transform.scale(scale: 0.8, child: btn)),
//     );
//   }
// }
