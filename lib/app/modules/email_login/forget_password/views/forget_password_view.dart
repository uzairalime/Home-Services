import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/widget/cText.dart';
import 'package:home_brigadier/widget/c_filled_btn.dart';

import '../../../../../../consts/app_color.dart';
import '../../../../../../consts/media_query.dart';
import '../../../../../../widget/c_app_bar.dart';
import '../controllers/forget_password_controller.dart';
import 'forgot_pin_entering.dart';

class ForgetPasswordView extends GetView<ForgetPasswordController> {
  const ForgetPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordController>(builder: (obj) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CAppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Get.back();
              },
            ),
            title: 'Forgot Password',
          ),
        ),
        body: Center(
          child: SizedBox(
            width: mediaQueryWidth(context) * 0.9,
            height: mediaQueryHeight(context),
            child: Column(
              children: [
                const Image(
                    image: AssetImage('assets/images/forget_pass.png'),
                    fit: BoxFit.scaleDown),
                SizedBox(
                  height: mediaQueryHeight(context) * 0.01,
                ),
                SizedBox(
                  height: mediaQueryHeight(context) * 0.06,
                  child: const CText(
                    text:
                        'Select which contact detail should we use to reset your password',
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: mediaQueryHeight(context) * 0.01,
                ),
                InkWell(
                  onTap: () {
                    obj.sms();
                  },
                  child: Container(
                    height: mediaQueryHeight(context) * 0.08,
                    padding: EdgeInsets.all(mediaQueryHeight(context) * 0.001),
                    decoration: BoxDecoration(
                        // color: Colors.grey.withOpacity(0.1),
                        border: Border.all(
                            color: obj.issms ? AppColor.primary : Colors.grey),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width * 0.25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color.fromRGBO(158, 158, 158, 1)
                                .withOpacity(0.1),
                          ),
                          child: Center(
                              child: SvgPicture.asset(
                                  "assets/icons/ic_message.svg")),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CText(
                              text: 'Via SMS',
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            const CText(
                              text: '*923*******98',
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: mediaQueryHeight(context) * 0.05,
                ),
                InkWell(
                  onTap: () {
                    // print("heloo");
                    obj.email();
                  },
                  child: Container(
                    height: mediaQueryHeight(context) * 0.08,
                    padding: EdgeInsets.all(mediaQueryHeight(context) * 0.001),
                    decoration: BoxDecoration(
                        // color: Colors.grey.withOpacity(0.1),
                        border: Border.all(
                            width: 0.9,
                            color:
                                obj.isemail ? AppColor.primary : Colors.grey),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width * 0.25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color.fromRGBO(158, 158, 158, 1)
                                .withOpacity(0.1),
                          ),
                          child: Center(
                              child: SvgPicture.asset(
                                  "assets/icons/ic_email.svg")),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CText(
                              text: 'Via Email',
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            const CText(
                              text: '*john*****@gmail.com',
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Flexible(
                    child: SizedBox(
                  height: mediaQueryHeight(context) * 0.16,
                )),
                CButton(
                  ontab: () {
                    Get.to(() => const EnterPin());
                  },
                  text: "Continue",
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
