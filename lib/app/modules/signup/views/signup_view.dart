import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/utils/validation.dart';
import 'package:home_brigadier/widget/cText.dart';
import 'package:home_brigadier/widget/c_filled_btn.dart';
import 'package:home_brigadier/widget/c_text_field.dart';

import '../../../../consts/media_query.dart';
import '../../../routes/app_pages.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.adaptive.arrow_back)),
        ),
        body: GetBuilder<SignupController>(builder: (obj) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: widht * 0.05, vertical: height * 0.03),
            child: SizedBox(
              width: widht,
              height: height,
              child: Column(
                children: [
                  SizedBox(height: mediaQueryHeight(context) * 0.03),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CText(
                      text: "Create your\n Account",
                      textAlign: TextAlign.left,
                      fontWeight: FontWeight.bold,
                      fontsize: widht * 0.09,
                    ),
                  ),
                  SizedBox(height: mediaQueryHeight(context) * 0.10),
                  CTextField(
                    validator: (p0) {
                      return GetValidation.emaiValidation(obj.emailcontroller);
                    },
                    contentPadding: 15,
                    prefexIcon: Icons.email_rounded,
                    hint: 'Email',
                    controller: obj.emailcontroller,
                    borderColor: Colors.transparent,
                    borderRadius: 12,
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.1),
                  ),
                  const SizedBox(height: 20),
                  CTextField(
                    validator: (p0) {
                      return GetValidation.psdValidation(p0!);
                    },
                    contentPadding: 15,
                    prefexIcon: Icons.lock,
                    hint: 'Password',
                    psdObs: obj.isobx ? true : false,
                    controller: obj.passwordcontroller,
                    borderColor: Colors.transparent,
                    borderRadius: 12,
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.1),
                    suffix: InkWell(
                      onTap: () {
                        obj.changeObx();
                        obj.update();
                      },
                      child: Icon(
                        obj.isobx ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey.withOpacity(0.75),
                      ),
                    ),
                  ),
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.scale(
                            scale: 0.8,
                            child: Checkbox.adaptive(
                                value: obj.isremindme,
                                side: const BorderSide(
                                    color: AppColor.primary,
                                    width: 2,
                                    style: BorderStyle.solid),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0))),
                                onChanged: (val) {
                                  obj.changeRemindme(val);
                                })),
                        const CText(
                          textAlign: TextAlign.start,
                          text: "Remind me",
                          fontsize: 12,
                          color: AppColor.secondary,
                        )
                      ]),
                  const Spacer(flex: 1),
                  Column(
                    children: [
                      CButton(
                        text: 'Register',
                        fontsize: 14,
                        fontWeight: FontWeight.w500,
                        shadow: true,
                        ontab: () {
                          Get.offAndToNamed(Routes.DASHBOARD);
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CText(
                            text: "Already have an account?",
                            color: Colors.grey.withOpacity(0.75),
                            fontsize: widht * 0.03,
                          ),
                          SizedBox(
                            width: widht * 0.02,
                          ),
                          InkWell(
                            onTap: () => Get.toNamed(Routes.EMAIL_LOGIN),
                            child: CText(
                              text: "Login",
                              color: AppColor.primary,
                              fontsize: widht * 0.03,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }));
  }
}
