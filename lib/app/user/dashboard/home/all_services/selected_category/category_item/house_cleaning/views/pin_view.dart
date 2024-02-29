import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/house_cleaning/views/receipt_view.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/utils/style.dart';
import 'package:home_brigadier/widget/cText.dart';
import 'package:home_brigadier/widget/c_filled_btn.dart';

class PinView extends GetView {
  const PinView({super.key});

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Enter Your PIN",
            style: appbar,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: widht * 0.05,
            right: widht * 0.05,
            bottom: widht * 0.1,
            top: widht * 0.03,
          ),
          child: SizedBox(
            width: widht,
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CText(
                  text: "Enter your PIN to confirm payment",
                  fontsize: 16,
                  fontWeight: bold3,
                ),
                Flexible(
                  flex: 10,
                  child: PinCodeFields(
                    obscureCharacter:  "⚪",

                    // controller: obj.pincontroller,

                    length: 4,
                    obscureText: true,
                    fieldBorderStyle: FieldBorderStyle.square,
                    responsive: false,
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
                      // print("");
                    },
                  ),
                ),
                CButton(
                    text: "Continue",
                    shadow: true,
                    borderradius: widht * 0.075,
                    fontWeight: bold6,
                    fontsize: 14,
                    ontab: () => _showConfirmAlertDialog(context)

                    // ),
                    )
              ],
            ),
          ),
        ));
  }

  _showConfirmAlertDialog(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog.adaptive(
              scrollable: true,
              content: Column(
                children: [
                  SvgPicture.asset(
                    "assets/images/payement_img.svg",
                    fit: BoxFit.cover,
                    width: widht * 0.5,
                    height: widht * 0.5,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  const CText(
                    text: "Booking Successful!",
                    fontWeight: FontWeight.w700,
                    fontsize: 22,
                    color: AppColor.primary,
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  const CText(
                      fontsize: 14,
                      fontWeight: FontWeight.w300,
                      text:
                          "You have successfully made payment and book the services."),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CButton(
                    ontab: () {
                      Get.back();
                      Get.to(() => const ReceiptView());
                    },
                    btnheight: height * 0.055,
                    text: "View E-Receipt",
                    fontsize: widht * 0.03,
                    borderradius: 30,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  // CButton(
                  //   ontab: () {
                  //     Get.back();
                  //     Get.to(() => const MessegeView());
                  //   },
                  //   btnheight: height * 0.055,
                  //   text: "Message Workers",
                  //   bgcolor: isDarkmode(context)
                  //       ? const Color(0xff35383F)
                  //       : const Color(0xffF1E7FF),
                  //   borderradius: 30,
                  //   fontWeight: FontWeight.w600,
                  //   fontsize: widht * 0.03,
                  //   txtcolor:
                  //       isDarkmode(context) ? AppColor.white : AppColor.primary,
                  // ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
