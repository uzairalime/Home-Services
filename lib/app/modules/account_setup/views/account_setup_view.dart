import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/modules/account_setup/views/creat_pin.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/consts/media_query.dart';
import 'package:home_brigadier/widget/c_text_field.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../utils/validation.dart';
import '../../../../widget/c_filled_btn.dart';
import '../controllers/account_setup_controller.dart';

class AccountSetupView extends GetView<AccountSetupController> {
  const AccountSetupView({super.key});

  @override
  Widget build(BuildContext context) {
    final svgTheme = Theme.of(context).textTheme.titleMedium!.color;
    final titleMedium = Theme.of(context).textTheme.titleMedium!.fontSize;
    return GetBuilder<AccountSetupController>(
        init: Get.put(AccountSetupController()),
        builder: (obj) {
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
                  'Fill Your Profile',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.titleMedium!.color,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                    vertical: mediaQueryHeight(context) * .05,
                    horizontal: mediaQueryWidth(context) * 0.05),
                child: SizedBox(
                  height: mediaQueryHeight(context) * 0.9,
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              obj.pickImage();
                            },
                            child: obj.path.isNotEmpty
                                ? ProfilePic(
                                    image: FileImage(File(obj.path)),
                                  )
                                : const ProfilePic(image: AssetImage("assets/images/new_img.png"))),
                        CTextField(
                            hint: "First Name",
                            controller: controller.namecontroller,
                            borderColor: Colors.transparent,
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.1),
                            contentPadding: 15,
                            keyboardType: TextInputType.name,
                            autofillHints: const [AutofillHints.namePrefix],
                            borderRadius: 12),
                        CTextField(
                            hint: "Last Name",
                            controller: controller.nicknamecontroller,
                            borderColor: Colors.transparent,
                            keyboardType: TextInputType.name,
                            autofillHints: const [AutofillHints.name],
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.1),
                            contentPadding: 15,
                            borderRadius: 12),
                        CTextField(
                          hint: 'Date',
                          suffix: IconButton(
                            onPressed: () {
                              // AccountSetupController._selectDate(context);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return obj.alertbox();
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.calendar_month_sharp,
                              color: AppColor.grey,
                            ),
                          ),
                          textInputAction: null,
                          controller: obj.datecontroller,
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.1),
                          borderColor: Colors.transparent,
                          borderRadius: 10,
                        ),
                        CTextField(
                          validator: (p0) {
                            return GetValidation.emaiValidation(controller.emailcontrolller);
                          },
                          hint: "Email",
                          controller: TextEditingController(),
                          borderColor: Colors.transparent,
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.1),
                          contentPadding: 15,
                          borderRadius: 12,
                          suffix: SvgPicture.asset("assets/icons/ic_email.svg",
                              fit: BoxFit.scaleDown, color: svgTheme),
                        ),
                        IntlPhoneField(
                          controller: controller.phonecontroller,
                          pickerDialogStyle: PickerDialogStyle(
                            countryNameStyle: TextStyle(
                              color: Theme.of(context).textTheme.titleMedium!.color,
                            ),
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          languageCode: "en",
                          dropdownIconPosition: IconPosition.trailing,
                          onChanged: (phone) {},
                          onCountryChanged: (country) {},
                          dropdownIcon: Icon(Icons.arrow_drop_down_sharp, color: svgTheme),
                        ),
                        CTextField(
                            hint: "Address",
                            controller: controller.adresscontroller,
                            borderColor: Colors.transparent,
                            keyboardType: TextInputType.streetAddress,
                            autofillHints: const [AutofillHints.addressCityAndState],
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.1),
                            contentPadding: 15,
                            borderRadius: 12),
                        CButton(
                          ontab: () {
                            Get.to(() => const CreatePin());
                          },
                          text: "Continue",
                          fontsize: titleMedium,
                          fontWeight: FontWeight.w500,
                          shadow: true,
                          btnheight: kToolbarHeight * 0.9,
                          btnwidth: double.infinity,
                        )
                      ]),
                ),
              ));
        });
  }
}

class ProfilePic extends StatelessWidget {
  const ProfilePic({super.key, required this.image});

  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountSetupController>(builder: (obj) {
      return Stack(children: [
        CircleAvatar(backgroundImage: image, radius: mediaQueryWidth(context) * 0.13),
        Positioned(
            bottom: mediaQueryHeight(context) * 0.005,
            right: mediaQueryWidth(context) * 0.02,
            child: SvgPicture.asset(
                width: mediaQueryWidth(context) * 0.06,
                "assets/icons/ic_pic_edit.svg",
                fit: BoxFit.scaleDown))
      ]);
    });
  }
}
