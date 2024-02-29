import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/widget/cText.dart';

class MessegeView extends GetView {
  const MessegeView({super.key});

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: CText(
            text: "Jenny Wilson",
            fontWeight: FontWeight.bold,
            fontsize: widht * 0.05,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: SvgPicture.asset(
                "assets/icons/ic_phone_outlined.svg",
                fit: BoxFit.cover,
                width: 20,
                height: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset(
                "assets/icons/ic_more_outlined.svg",
                fit: BoxFit.scaleDown,
                width: 20,
                height: 20,
              ),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(widht * 0.03),
          child: SizedBox(
            width: widht,
            height: height,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(widht * 0.04),
                        bottomLeft: Radius.circular(widht * 0.04),
                        bottomRight: Radius.circular(widht * 0.04),
                      ),
                      gradient: AppColor.primaryGradient),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: widht * 0.03,
                      vertical: widht * 0.03,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Expanded(
                          child: Text(
                            "Good morning ",
                            style: TextStyle(color: AppColor.white),
                          ),
                        ),
                        SizedBox(
                          width: widht * 0.03,
                        ),
                        const Text(
                          "10:00",
                          style: TextStyle(color: AppColor.white),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
