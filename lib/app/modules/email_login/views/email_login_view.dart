import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/consts/media_query.dart';
import 'package:home_brigadier/generated/locales.g.dart';
import 'package:home_brigadier/main.dart';
import 'package:home_brigadier/widget/c_text_field.dart';

import '../../../../../services/apis/toast.dart';
import '../../../../../widget/cText.dart';
import '../../../../../widget/c_filled_btn.dart';
import '../controllers/email_login_controller.dart';
import '../forget_password/controllers/pin_controller.dart';
import '../forget_password/views/forgot_pin_entering.dart';

class EmailLoginView extends GetView<EmailLoginController> {
  // final String? role;

  // const EmailLoginView({super.key, this.role});
  const EmailLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EmailLoginController());

    Get.put(PinController());
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: CText(
          text: LocaleKeys.log_in_item_msg.tr,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.start,
          fontsize: Theme.of(context).textTheme.headlineSmall!.fontSize,
          color: AppColor.black,
        ),
      ),
      body: GetBuilder(
          init: Get.put(EmailLoginController()),
          builder: (_) {
            return controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : Center(
                    child: SizedBox(
                      width: width * 0.95,
                      height: height * .85,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: Image.asset(
                            "assets/icons/ic_login.png",
                            width: 150,
                            height: 150,
                          )),
                          SizedBox(height: mediaQueryHeight(context) * 0.05),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                LocalsBtn(
                                    onTap: () {
                                      controller.setSelectedLanguage("English");
                                    },
                                    icon: Icons.language,
                                    txt: "English",
                                    borderColor: localeValue() != "العربية"
                                        ? AppColor.secondary
                                        : null),
                                SizedBox(
                                  width: mediaQueryWidth(context) * 0.10,
                                ),
                                LocalsBtn(
                                    onTap: () {
                                      controller.setSelectedLanguage("العربية");
                                    },
                                    icon: Icons.translate,
                                    txt: "العربية",
                                    borderColor: localeValue() == "العربية"
                                        ? AppColor.secondary
                                        : null)
                              ],
                            ),
                          ),
                          SizedBox(height: mediaQueryHeight(context) * 0.05),
                          Focus(
                            onFocusChange: (value) {
                              controller.onRateFocus(value);
                            },
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: Container(
                                  height: 56,
                                  decoration: BoxDecoration(
                                    color: AppColor.greylight.withOpacity(0.1),
                                    border: Border.all(
                                      color: controller.phoneFocus.value
                                          ? AppColor.secondary
                                          : Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: AppColor.greylight
                                              .withOpacity(0.2),
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(12),
                                            topLeft: Radius.circular(12),
                                          ),
                                        ),
                                        height: double.maxFinite,
                                        width: 60,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "+971",
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                      ),
                                      Expanded(
                                        child: CTextField(
                                          maxlength: 9,
                                          focusBorderColor: Colors.transparent,
                                          hint: LocaleKeys
                                              .log_in_item_enter_phone.tr,
                                          keyboardType: TextInputType.phone,
                                          controller:
                                              controller.phoneController,
                                          borderColor: Colors.transparent,
                                          counterText: '',
                                          contentPadding: 5,
                                          borderRadius: 12,
                                          onChanged: (p0) {
                                            if (controller.phoneController.text
                                                    .length ==
                                                9) {
                                              FocusScope.of(context).unfocus();
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                          const Spacer(),
                          Center(
                            child: CButton(
                                btnheight: 50,
                                btnwidth: mediaQueryWidth(context) * 0.8,
                                text: LocaleKeys.log_in_item_sign_in.tr,
                                fontsize: 14,
                                borderradius: 50,
                                fontWeight: FontWeight.w500,
                                shadow: true,
                                ontab: () {
                                  if (controller
                                          .phoneController.text.isNotEmpty &&
                                      controller.phoneController.text.length ==
                                          9) {
                                    controller.generateOTP().then((value) {
                                      if (value == 200) {
                                        // showSnackBar(LocaleKeys.snack_bar_enter_valid_otp.tr);
                                        Get.to(() => const EnterPin(),
                                            duration:
                                                const Duration(seconds: 1),
                                            transition: Transition.native,
                                            arguments: controller
                                                .phoneController.text);
                                      } else {
                                        showSnackBar(
                                            LocaleKeys.snack_bar_opt_failed.tr,
                                            true);
                                      }
                                    });
                                  } else {
                                    showSnackBar(
                                        LocaleKeys
                                            .snack_bar_enter_valid_number.tr,
                                        true);
                                  }
                                }),
                          ),
                          SizedBox(height: height * 0.02),
                        ],
                      ),
                    ),
                  );
          }),
    );
  }
}

class LocalsBtn extends StatelessWidget {
  const LocalsBtn(
      {super.key,
      required this.icon,
      required this.txt,
      this.bg,
      this.onTap,
      this.borderColor});

  final Color? borderColor;
  final IconData icon;
  final String txt;
  final Color? bg;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: mediaQueryHeight(context) * 0.16,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: borderColor ?? AppColor.greylight,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          onPressed: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(icon,
                  color: borderColor != null ? AppColor.white : AppColor.black),
              const Spacer(),
              Text(
                txt,
                style: TextStyle(
                    color:
                        borderColor != null ? AppColor.white : AppColor.black,
                    fontWeight: borderColor != null ? FontWeight.w700 : null),
              )
            ],
          )),
    );
  }
}
