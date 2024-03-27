import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/routes/app_pages.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/consts/media_query.dart';
import 'package:home_brigadier/widget/cText.dart';

import '../controllers/chats_controller.dart';

class ChatsView extends GetView<ChatsController> {
  const ChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatsController());
    return ListView.builder(
        itemCount: controller.items.length,
        itemBuilder: (context, index) {
          return Obx(() => Container(
              color: controller.selectedItems.value.contains(index)
                  ? Colors.blue.withOpacity(0.5)
                  : null,
              child: ChatListTile(
                  index: index,
                  title: 'Jenny Wilson',
                  subTitle: 'I have booked your house',
                  leading: const CircleAvatar(
                      radius: 40, backgroundImage: AssetImage("assets/images/img_people.png")),
                  date: '${DateTime.now().hour}:${DateTime.now().minute}',
                  smsCount: index)));
        });
  }
}

// ChatListTile
class ChatListTile extends GetView<ChatsController> {
  const ChatListTile(
      {super.key,
      required this.index,
      required this.title,
      required this.subTitle,
      required this.leading,
      required this.date,
      required this.smsCount});

  final int index;
  final String title;
  final String subTitle;
  final Widget leading;
  final String date;
  final int smsCount;

  @override
  Widget build(BuildContext context) {
    final titleSmall = Theme.of(context).textTheme.titleSmall!.fontSize;
    final labelSmall = Theme.of(context).textTheme.labelSmall!.fontSize;
    return ListTile(
        onTap: () => Get.toNamed(Routes.USER_CHAT),
        onLongPress: () => controller.markItem(index),
        leading: leading,
        title: CText(
          text: title,
          fontsize: titleSmall,
          color: Theme.of(context).textTheme.titleSmall!.color,
          fontWeight: FontWeight.w600,
          textAlign: TextAlign.left,
        ),
        subtitle: CText(
          text: subTitle,
          fontsize: labelSmall,
          color: Theme.of(context).textTheme.labelSmall!.color,
          textAlign: TextAlign.left,
        ),
        trailing: Column(children: [
          Stack(alignment: Alignment.center, children: [
            SvgPicture.asset(
              "assets/icons/ic_circle_filled.svg",
              width: mediaQueryWidth(context) * 0.06,
              fit: BoxFit.scaleDown,
              color: AppColor.secondary,
            ),
            CText(text: "$index", color: AppColor.white, fontsize: labelSmall)
          ]),
          const Spacer(),
          CText(
              text: date,
              color: Theme.of(context).textTheme.labelSmall!.color,
              fontsize: labelSmall)
        ]));
  }
}
