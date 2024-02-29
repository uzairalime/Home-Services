import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/modules/login/email_login/forget_password/controllers/pin_controller.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/consts/media_query.dart';
import 'package:home_brigadier/generated/locales.g.dart';
import 'package:home_brigadier/services/apis/toast.dart';
import 'package:home_brigadier/widget/cText.dart';

import '../controllers/forget_password_controller.dart';

class EnterPin extends GetView<PinController> {
  const EnterPin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(PinController());
    final number = Get.arguments;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            LocaleKeys.verifyOtp_items_name.tr,
            style: TextStyle(
                color: Theme.of(context).textTheme.titleMedium!.color,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: GetBuilder(
            init: ForgetPasswordController(),
            builder: (_) {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Center(
                  child: SizedBox(
                      height: mediaQueryHeight(context),
                      width: mediaQueryWidth(context) * 0.9,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(flex: 1),
                          SizedBox(
                              width: double.maxFinite,
                              child: CText(
                                text: "Enter OTP",
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.w500,
                                fontsize: Theme.of(context).textTheme.headlineSmall!.fontSize,
                              )),
                          PinCodeFields(
                            controller: controller.otpController,
                            length: 6,
                            fieldBorderStyle: FieldBorderStyle.square,
                            fieldHeight: 50.0,
                            fieldWidth: 50.0,
                            borderWidth: 1.0,
                            activeBorderColor: AppColor.primary,
                            activeBackgroundColor: AppColor.secondary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10.0),
                            keyboardType: TextInputType.number,
                            autoHideKeyboard: false,
                            fieldBackgroundColor: Colors.grey.withOpacity(0.1),
                            borderColor: const Color.fromARGB(96, 0, 0, 0),
                            textStyle: const TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                            onComplete: (value) {
                              if (controller.otpController.text.isNotEmpty) {
                                controller.generateToken(
                                    phone: number, otp: controller.otpController.text);
                              } else {
                                showsnackbar("Enter a valid OTP", true);
                              }
                            },
                          ),
                          const SizedBox(height: 30),
                          Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CText(text: LocaleKeys.verifyOtp_items_code_msg.tr),
                                CText(text: ' +971-$number', fontWeight: FontWeight.w700)
                              ]),
                          const Spacer(flex: 3)
                        ],
                      )),
                );
              }
            }));
  }
}

// CText(text: LocaleKeys.verifyOtp_items_resend.tr),
// SizedBox(
//     width: MediaQuery.of(context).size.width * 0.9,
//     child: CButton(
//         ontab: () {
//           if (controller.otpController.text.isNotEmpty) {
//             controller.generateToken(
//                 phone: number, otp: controller.otpController.text);
//           } else {
//             showsnackbar("Enter a valid OTP", true);
//           }
//         },
//         text: LocaleKeys.verifyOtp_items_verify.tr))
