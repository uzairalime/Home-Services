import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/consts/media_query.dart';
import 'package:home_brigadier/widget/cText.dart';
import 'package:home_brigadier/widget/c_filled_btn.dart';

import '../../../../../../utils/validation.dart';
import '../../../../../../widget/c_text_field.dart';
import '../controllers/forget_password_controller.dart';

class CreateNewPassword extends GetView<ForgetPasswordController> {
  const CreateNewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return GetBuilder<ForgetPasswordController>(builder: (obj) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            'Create New Password',
            style: TextStyle(
                color: Theme.of(context).textTheme.titleMedium!.color,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: SizedBox(
            height: height,
            width: widht,
            child: Column(children: [
              SizedBox(
                height: height * 0.01,
              ),
              SizedBox(
                  height: height * 0.3,
                  width: widht,
                  child: Image.asset('assets/images/forget_pass.png')),
              SizedBox(
                height: height * 0.1,
                width: widht * 0.9,
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: CText(
                      fontWeight: FontWeight.bold, text: 'Create New Password'),
                ),
              ),
              SizedBox(
                  height: height * 0.265,
                  child: Column(children: [
                    SizedBox(
                      width: mediaQueryWidth(context) * 0.9,
                      child: CTextField(
                        validator: (p0) {
                          return GetValidation.psdValidation(p0!);
                        },
                        contentPadding: 15,
                        prefexIcon: Icons.lock,
                        hint: 'Enter New Password',
                        psdObs: obj.isobx1 ? true : false,
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
                            obj.isobx1
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey.withOpacity(0.75),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: mediaQueryWidth(context) * 0.9,
                      child: CTextField(
                        validator: (p0) {
                          return GetValidation.psdValidation(p0!);
                        },
                        contentPadding: 15,
                        prefexIcon: Icons.lock,
                        hint: 'Confirm Password',
                        psdObs: obj.isobx2 ? true : false,
                        controller: obj.reenterpassword,
                        borderColor: Colors.transparent,
                        borderRadius: 12,
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.1),
                        suffix: InkWell(
                          onTap: () {
                            obj.changeObx2();
                            obj.update();
                          },
                          child: Icon(
                            obj.isobx2
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey.withOpacity(0.75),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox.adaptive(
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
                            },
                          ),
                          CText(
                            text: "Remind me",
                            fontsize: widht * 0.03,
                          )
                        ],
                      ),
                    ),
                  ])),
              // Re Enter password

              SizedBox(
                height: height * 0.121,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: CButton(
                  ontab: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alertbox();
                      },
                    );
                  },
                  text: "Verify",
                ),
              ),
            ])),
      );
    });
  }
}

/// alert boz for password change
alertbox() {
  return AlertDialog(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(25),
      ),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset(
          'assets/icons/ic_circle_person.svg',
        ),
        Container(
          alignment: Alignment.center,
          height: 45.0,
          child: const CText(
              text: 'Congratulation!',
              fontWeight: FontWeight.bold,
              fontsize: 20,
              color: AppColor.primary),
        ),
        const SizedBox(
          height: 150.0,
          child: CText(
              text:
                  'Your Account is ready to use. You will be redirected to the Home Page in a few seconds'),
        ),
        const CircularProgressIndicator()
      ],
    ),
  );
}
