import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/routes/app_pages.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/consts/media_query.dart';
import 'package:home_brigadier/widget/cText.dart';


class PaymentCancelPin extends GetView {
  const PaymentCancelPin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          'Enter Your Pin',
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
                height: mediaQueryHeight(context) * 0.2,
              ),
            ),
            SizedBox(
                height: mediaQueryHeight(context) * 0.28,
                width: mediaQueryWidth(context) * 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Expanded(
                      flex: 3,
                      child: CText(
                        text: 'Code has been sent to 923**789',
                      ),
                    ),
                    Flexible(
                      flex: 10,
                      child: PinCodeFields(
                        // controller: obj.pincontroller,

                        length: 4,
                        obscureText: true,
                        fieldBorderStyle: FieldBorderStyle.square,
                        responsive: false,
                        fieldHeight: 50.0,
                        fieldWidth: 50.0,
                        borderWidth: 1.0,
                        activeBorderColor: AppColor.primary,
                        activeBackgroundColor:
                            AppColor.secondary.withOpacity(0.1),
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
                          // print("");
                        },
                      ),
                    ),
                    const CText(text: 'Resend Code in ..'),
                  ],
                )),
            SizedBox(
              height: mediaQueryHeight(context) * 0.08,
            ),
            Flexible(
              child: SizedBox(
                height: mediaQueryHeight(context) * 0.4,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: FilledButton(
                onPressed: () {
                  // Get.to(() => const CreateNewPassword());
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alertbox();
                    },
                  );
                },
                child: const Text("Verify"),
              ),
            ),
          ],
        ),
      ),
    );
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
        const SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.center,
          height: 60.0,
          child: const CText(
              text: 'Cancel Booking\nSucessful',
              fontWeight: FontWeight.bold,
              fontsize: 20,
              color: AppColor.primary),
        ),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          height: 150.0,
          child: Center(
            child: CText(
                text:
                    'Your have sucessfuly canceled your services booking. 80% fund will be refunded to your account'),
          ),
        ),
        SizedBox(
          width: 300,
          child: FilledButton(
            onPressed: () {
              Get.toNamed(Routes.PAYMENT_SETTING);
            },
            child: const Text("Continue"),
          ),
        ),
      ],
    ),
  );
}
