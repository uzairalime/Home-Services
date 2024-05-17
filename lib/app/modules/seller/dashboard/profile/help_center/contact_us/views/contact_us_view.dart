import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/consts/app_color.dart';

import '../../../../../../../../consts/media_query.dart';
import '../../../../../../../../widget/cText.dart';
import '../controllers/contact_us_controller.dart';

class ContactUsView extends GetView<ContactUsController> {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: mediaQueryWidth(context) * 0.05),
        child: ListView(children: const [
          ContactUsListTile(
              title: "Customer Service",
              leading: Icon(Icons.headset_mic, color: AppColor.secondary)),
          ContactUsListTile(
              title: "WhatsApp",
              leading: Icon(Icons.camera_alt, color: AppColor.secondary)),
          ContactUsListTile(
              title: "Website",
              leading: Icon(Icons.language, color: AppColor.secondary)),
          ContactUsListTile(
              title: "Facebook",
              leading: Icon(Icons.sensor_occupied, color: AppColor.secondary)),
          ContactUsListTile(
              title: "Twitter",
              leading: Icon(Icons.biotech_rounded, color: AppColor.secondary)),
          ContactUsListTile(
              title: "Instagram",
              leading: Icon(Icons.camera, color: AppColor.secondary)),
        ]));
  }
}

class ContactUsListTile extends StatelessWidget {
  const ContactUsListTile({
    super.key,
    required this.title,
    required this.leading,
  });

  final String title;
  final Widget leading;

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme.titleMedium!.color;
    final titleMedium = Theme.of(context).textTheme.titleMedium!.fontSize;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: mediaQueryHeight(context) * 0.01),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 10,
        child: ListTile(
            leading: leading,
            title: CText(
                text: title,
                color: txtTheme,
                fontsize: titleMedium,
                textAlign: TextAlign.left,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
