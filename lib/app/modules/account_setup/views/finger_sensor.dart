import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/consts/media_query.dart';
import 'package:home_brigadier/widget/cText.dart';

import '../../../../widget/c_filled_btn.dart';
import '../controllers/account_setup_controller.dart';

class AddFinger extends GetView<AccountSetupController> {
  const AddFinger({super.key});

  @override
  Widget build(BuildContext context) {
    final titleMedium = Theme.of(context).textTheme.titleMedium!.fontSize;
    return GetBuilder<AccountSetupController>(builder: (obj) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
          actions: const [],
          title: Text(
            'Set Your Finger',
            style: TextStyle(
                color: Theme.of(context).textTheme.titleMedium!.color,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: SizedBox(
          height: mediaQueryHeight(context),
          width: mediaQueryWidth(context),
          child: Column(
            children: [
              SizedBox(
                height: mediaQueryHeight(context) * 0.1,
              ),
              const CText(
                text: 'Add a pin number to make your account\n more secure',
              ),
              SizedBox(
                height: mediaQueryHeight(context) * 0.1,
              ),
              SizedBox(
                height: mediaQueryHeight(context) * 0.15,
                width: mediaQueryWidth(context) * 0.4,
                // child: SvgPicture.asset('assets/icons/ic_fingerprint.svg'),
              ),
              Flexible(
                  child: SizedBox(
                height: mediaQueryHeight(context) * 0.3,
              )),
              Flexible(
                  child: SizedBox(
                height: mediaQueryHeight(context) * 0.3,
              )),
              Flexible(
                  child: SizedBox(
                height: mediaQueryHeight(context) * 0.3,
              )),
              Flexible(
                child: SizedBox(
                  height: mediaQueryHeight(context) * 0.39,
                ),
              ),
              Flexible(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: CButton(
                        ontab: () {
                          Get.to(() => const AddFinger());
                        },
                        text: "Skip",
                        fontsize: titleMedium,
                        fontWeight: FontWeight.w500,
                        shadow: true,
                        btnheight: kToolbarHeight * 0.9,
                        btnwidth: double.infinity,
                      )),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: CButton(
                        ontab: () {
                          Get.to(() => const AddFinger());
                        },
                        text: "Continue",
                        fontsize: titleMedium,
                        fontWeight: FontWeight.w500,
                        shadow: true,
                        btnheight: kToolbarHeight * 0.9,
                        btnwidth: double.infinity,
                      )),
                ],
              )),
            ],
          ),
        ),
      );
    });
  }
}
