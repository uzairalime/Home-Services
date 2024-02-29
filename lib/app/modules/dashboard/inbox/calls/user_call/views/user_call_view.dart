import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/consts/media_query.dart';
import 'package:home_brigadier/widget/cText.dart';

import '../controllers/user_call_controller.dart';

class UserCallView extends GetView<UserCallController> {
  const UserCallView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleLarge = Theme.of(context).textTheme.titleLarge!.fontSize;
    final titleSmall = Theme.of(context).textTheme.titleSmall!.fontSize;
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: mediaQueryHeight(context) * 0.1),
              child: SvgPicture.asset("assets/icons/ic_person_bubble.svg"),
            ),
            CText(
                text: "Jenny Wilson",
                fontsize: titleLarge,
                fontWeight: FontWeight.w500),
            CText(
                text: "${DateTime.now().hour}:${DateTime.now().minute} Minutes",
                fontsize: titleSmall)
          ]),
        ),
        floatingActionButton: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset("assets/icons/ic_circle_filled.svg",
                  height: 65, color: Colors.pinkAccent.shade100),
              SvgPicture.asset("assets/icons/ic_circle_filled.svg",
                  height: 65, color: Colors.deepPurpleAccent.shade100),
              SvgPicture.asset("assets/icons/ic_circle_filled.svg",
                  height: 65, color: Colors.orange.shade300)
            ]));
  }
}
