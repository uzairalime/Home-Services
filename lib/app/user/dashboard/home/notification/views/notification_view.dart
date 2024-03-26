import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/utils/style.dart';
import 'package:home_brigadier/widget/cText.dart';

import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Notification",
            style: appbar,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset(
                "assets/icons/ic_more_outlined.svg",
                fit: BoxFit.cover,
                width: appbariconsize,
                height: appbariconsize,
                color: AppColor.black,
              ),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: widht * 0.05,
            right: widht * 0.05,
            top: widht * 0.05,
          ),
          child: SizedBox(
            width: widht,
            height: height,
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: CText(text: "Today", fontWeight: bold6, fontsize: size18)),
                SizedBox(
                  height: height * 0.02,
                ),
                Expanded(
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: 20,
                        itemBuilder: (contect, index) {
                          if (index == 3) {
                            return Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CText(
                                    text: "Yesterday",
                                    fontWeight: FontWeight.bold,
                                    fontsize: widht * 0.045,
                                  ),
                                ));
                          }

                          return notificationTile(index, widht, height, contect);
                        }))
              ],
            ),
          ),
        ));
  }

  InkWell notificationTile(int index, double widht, double height, context) {
    return InkWell(
      onTap: () {
        print("click item ${index.toString()}");
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Container(
          width: widht,
          height: height * 0.125,
          decoration: BoxDecoration(
              color: const Color(0xffEEEEEE), borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/ic_person_bubble.svg",
                  fit: BoxFit.contain,
                  width: widht * 0.085,
                  height: height * 0.085,
                ),
                const Spacer(
                  flex: 1,
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CText(
                      text: "Payment Successful!",
                      fontWeight: bold6,
                      fontsize: size16,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    CText(
                      text: "Now the plumbing service is available",
                      fontsize: size12,
                      fontWeight: bold3,
                      color: AppColor.grey,
                    ),
                  ],
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
