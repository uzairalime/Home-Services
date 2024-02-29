import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/modules/account_setup/views/finger_sensor.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/consts/media_query.dart';
import 'package:home_brigadier/widget/cText.dart';

import '../../../../widget/c_filled_btn.dart';
import '../controllers/account_setup_controller.dart';

class CreatePin extends GetView<AccountSetupController> {
  const CreatePin({Key? key}) : super(key: key);

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
            'Create New Pin',
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
              Flexible(
                child: SizedBox(
                  height: mediaQueryHeight(context) * 0.1,
                ),
              ),
              SizedBox(
                height: mediaQueryHeight(context) * 0.1,
                child: const CText(
                  text: 'Add a pin number to make your account\n more secure',
                ),
              ),
              Flexible(
                child: SizedBox(
                  height: mediaQueryHeight(context) * 0.1,
                ),
              ),
              Flexible(
                flex: 3,
                child: PinCodeFields(
                  // controller: obj.pincontroller,

                  length: 4,
                  fieldBorderStyle: FieldBorderStyle.square,
                  responsive: false,
                  fieldHeight: 50.0,
                  fieldWidth: 50.0,
                  borderWidth: 1.0,
                  animation: Animations.rotateLeft,
                  obscureText: true,
                  activeBorderColor: AppColor.primary,
                  activeBackgroundColor: AppColor.secondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.0),
                  keyboardType: TextInputType.number,
                  autoHideKeyboard: false,
                  fieldBackgroundColor: Colors.grey.shade100,
                  borderColor: const Color.fromARGB(96, 0, 0, 0),
                  textStyle: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                  onComplete: (output) {
                    // Your logic with pin code
                    //print(output);
                  },
                ),
              ),
              SizedBox(
                height: mediaQueryHeight(context) * 0.5,
              ),

              // Flexible(
              //   child: SizedBox(
              //     height: mediaQueryHeight(context) * 0.56,
              //   ),
              // ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
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
          ),
        ),
      );
    });
  }
}
