import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../consts/app_color.dart';
import '../../../../../../consts/media_query.dart';
import '../../../../../../widget/cText.dart';
import '../../../../../routes/app_pages.dart';
import '../controllers/calls_controller.dart';

class CallsView extends GetView<CallsController> {
  const CallsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CallsController());
    return ListView.builder(
        itemCount: controller.callItems.length,
        itemBuilder: (context, index) {
          return CallListTile(
            index: index,
            title: 'Jenny Wilson',
            subTitle: 'I have booked your house',
            leading: const CircleAvatar(
                radius: 40, backgroundImage: AssetImage("assets/images/img_people.png")),
            date: '${DateTime.now().hour}:${DateTime.now().minute}',
            callType: CallType.Incomming,
            callIcon: const Icon(Icons.archive_rounded, color: Colors.green, size: 20),
          );
        });
  }
}

class CallListTile extends GetView<CallsController> {
  const CallListTile(
      {super.key,
      required this.index,
      required this.title,
      required this.subTitle,
      required this.leading,
      required this.date,
      required this.callType,
      this.onPressed,
      required this.callIcon});

  final int index;
  final String title;
  final String subTitle;
  final Widget leading;
  final String date;
  final CallType callType;
  final Widget callIcon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final titleSmall = Theme.of(context).textTheme.titleSmall!.fontSize;
    final labelSmall = Theme.of(context).textTheme.labelSmall!.fontSize;
    return ListTile(
        onTap: () => Get.toNamed(Routes.USER_CALL),
        leading: leading,
        title: CText(
            text: title,
            fontsize: titleSmall,
            color: Theme.of(context).textTheme.titleSmall!.color,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.left),
        subtitle: Row(children: [
          Row(children: [
            callIcon,
            CText(
                text: callType.name,
                color: Theme.of(context).textTheme.labelSmall!.color,
                fontsize: labelSmall)
          ]),
          CText(
              text: " | $date",
              fontsize: labelSmall,
              color: Theme.of(context).textTheme.labelSmall!.color,
              textAlign: TextAlign.left)
        ]),
        trailing: SvgPicture.asset("assets/icons/ic_phone_outlined.svg",
            width: mediaQueryWidth(context) * 0.06,
            fit: BoxFit.scaleDown,
            color: AppColor.secondary));
  }
}

enum CallType { Incomming, Outgoning, Missed }
