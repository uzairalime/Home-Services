import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/generated/locales.g.dart';

import '../../../../../../../consts/app_color.dart';
import '../../../../../../../consts/media_query.dart';
import '../../../../../../../widget/cText.dart';
import '../../../../../../../widget/c_icon_btn.dart';
import '../controllers/invite_friend_controller.dart';

class InviteFriendView extends GetView<InviteFriendController> {
  const InviteFriendView({super.key});

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme.titleMedium!.color;
    final titleMedium = Theme.of(context).textTheme.titleMedium!.fontSize;

    return GetBuilder(
      init: InviteFriendController(),
      builder: (_) {
        return Scaffold(
            appBar: AppBar(
                leading: CIconBtn(
                    onPressed: () => Get.back(),
                    child: Icon(Icons.adaptive.arrow_back)),
                title: InkWell(
                  onTap: () {
                    controller.getPhoneData();
                  },
                  child: CText(
                      text: LocaleKeys
                          .dashboard_profile__invite_a_friend_invite_friend.tr,
                      color: txtTheme,
                      fontsize: titleMedium,
                      fontWeight: FontWeight.bold),
                )),
            body: FutureBuilder(
              future: controller.getPhoneData(),
              builder: (context, snapshot) {
                print(snapshot.data);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  const Center(child: Text("No Contact found"));
                } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                  const Center(child: Text("No Contact found"));
                } else if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Uint8List? image = snapshot.data![index].photo;
                        String num = (snapshot.data![index].phones.isNotEmpty)
                            ? (snapshot.data![index].phones.first.number)
                            : "--";
                        String name = (snapshot
                                .data![index].name.first.isNotEmpty)
                            ? "${snapshot.data![index].name.first}${snapshot.data![index].name.middle}${snapshot.data![index].name.last}"
                            : "--";

                        return Container(
                          height: 70,
                          width: double.infinity,
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              (snapshot.data![index].photo == null)
                                  ? const CircleAvatar(
                                      child: Icon(Icons.person))
                                  : CircleAvatar(
                                      backgroundImage: MemoryImage(image!)),
                              const SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                height: 70,
                                width: mediaQueryWidth(context) * 0.45,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      snapshot.data![index].displayName,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(num),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: mediaQueryWidth(context) * 0.1,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    showCustomAlertDialog(context, num, name);
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: AppColor.grey.withOpacity(0.2),
                                    ),
                                    child: Center(
                                      child: CText(
                                        text: LocaleKeys
                                            .dashboard_profile__invite_a_friend_invite
                                            .tr,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      });
                }
                return const Center(child: Text("No Contact found"));
              },
            ));
      },
    );
  }

  showCustomAlertDialog(BuildContext context, String number, String name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: const Text('Invite Your friends'),
          content: SizedBox(
            height: 200,
            width: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Image.asset("assets/images/invitee.png"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShareBtn(
                      onTap: () => controller.whatsappLauncher(number),
                      controller: controller,
                      color: Colors.green,
                      number: number,
                      txt: "WhatsApp",
                      icon: FontAwesomeIcons.whatsapp,
                    ),
                    ShareBtn(
                      onTap: () => controller.launchMessenger(number, name),
                      controller: controller,
                      color: Colors.blue,
                      number: number,
                      txt: "Messenger",
                      icon: FontAwesomeIcons.facebookMessenger,
                    ),
                    ShareBtn(
                      onTap: () => controller.sendSMS(number),
                      controller: controller,
                      color: AppColor.black,
                      number: number,
                      txt: "Sms",
                      icon: FontAwesomeIcons.message,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ShareBtn extends StatelessWidget {
  const ShareBtn(
      {super.key,
      required this.controller,
      required this.number,
      required this.txt,
      required this.icon,
      this.onTap,
      required this.color});
  final InviteFriendController controller;
  final String number;
  final String txt;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColor.grey.withOpacity(0.2), shape: BoxShape.circle),
            child: Center(child: FaIcon(icon, size: 37, color: color)),
          ),
          const SizedBox(height: 10),
          CText(
            text: txt,
            fontsize: 12,
          ),
        ],
      ),
    );
  }
}
