import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/consts/media_query.dart';
import 'package:home_brigadier/generated/locales.g.dart';
import 'package:home_brigadier/utils/validation.dart';
import 'package:home_brigadier/widget/c_filled_btn.dart';
import 'package:home_brigadier/widget/c_text_field.dart';

import '../../../../../../widget/cText.dart';
import '../../../../../../widget/c_icon_btn.dart';
import '../controllers/edit_profile_setting_controller.dart';

class EditProfileSettingView extends GetView<EditProfileSettingController> {
  const EditProfileSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EditProfileSettingController());
    final userName = Get.arguments;
    final txtTheme = Theme.of(context).textTheme.titleMedium!.color;
    final titleLarge = Theme.of(context).textTheme.titleLarge!.fontSize;
    final titleMedium = Theme.of(context).textTheme.titleMedium!.fontSize;
    return GetBuilder(
        init: Get.put(EditProfileSettingController()),
        builder: (builderContext) {
          return Scaffold(
              appBar: AppBar(
                  leading:
                      CIconBtn(onPressed: () => Get.back(), child: Icon(Icons.adaptive.arrow_back)),
                  title: CText(
                      text: LocaleKeys.dashboard_profile_edit_profile.tr,
                      color: txtTheme,
                      fontsize: titleLarge,
                      fontWeight: FontWeight.w500)),
              body: Center(
                child: SizedBox(
                  height: mediaQueryHeight(context) * 0.9,
                  width: mediaQueryWidth(context) * 0.9,
                  child: Column(children: [
                    SizedBox(
                      height: mediaQueryHeight(context) * 0.1,
                    ),
                    //     hint: "First Name",
                    //     controller: controller.fistNameController,
                    //     borderColor: Colors.transparent,
                    //     filled: true,
                    //     fillColor: Colors.grey.withOpacity(0.1),
                    //     contentPadding: 15,
                    //     keyboardType: TextInputType.name,
                    //     autofillHints: const [AutofillHints.namePrefix],
                    //     borderRadius: 12),
                    // CTextField(
                    //     hint: "Last Name",
                    //     controller: controller.lastNameController,
                    //     borderColor: Colors.transparent,
                    //     keyboardType: TextInputType.name,
                    //     autofillHints: const [AutofillHints.name],
                    //     filled: true,
                    //     fillColor: Colors.grey.withOpacity(0.1),
                    //     contentPadding: 15,
                    //     borderRadius: 12),
                    // CTextField(
                    //     readOnly: true,
                    //     enabled: true,
                    //     borderRadius: 12,
                    //     hint: "Date of Birth",
                    //     keyboardType: TextInputType.datetime,
                    //     autofillHints: const [AutofillHints.birthdayDay],
                    //     focusBorderColor: Colors.transparent,
                    //     controller: TextEditingController(
                    //         text: controller
                    //             .formattedDate(controller.selectedDate)),
                    //     borderColor: Colors.transparent,
                    //     filled: true,
                    //     fillColor: Colors.grey.withOpacity(0.1),
                    //     contentPadding: 15,
                    //     suffix: InkWell(
                    //         borderRadius: BorderRadius.circular(50),
                    //         onTap: () => controller.selectDate(context),
                    //         child: SvgPicture.asset(
                    //             "assets/icons/ic_booking_outlined.svg",
                    //             fit: BoxFit.scaleDown))),
                    CTextField(
                      validator: (p0) {
                        return GetValidation.emaiValidation(controller.emailController);
                      },
                      hint: "$userName",
                      controller: TextEditingController(),
                      borderColor: Colors.transparent,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.1),
                      contentPadding: 15,
                      borderRadius: 12,
                      readOnly: true,
                    ),
                    SizedBox(
                      height: mediaQueryHeight(context) * 0.03,
                    ),
                    // CTextField(
                    //     hint: "Country",
                    //     controller: TextEditingController(),
                    //     borderColor: Colors.transparent,
                    //     keyboardType: TextInputType.emailAddress,
                    //     autofillHints: const [AutofillHints.email],
                    //     filled: true,
                    //     fillColor: Colors.grey.withOpacity(0.1),
                    //     contentPadding: 15,
                    //     borderRadius: 12,
                    //     suffix: IconButton(
                    //         onPressed: () {},
                    //         icon: const Icon(Icons.arrow_drop_down))),
                    // IntlPhoneField(
                    //   controller: controller.phoneController,
                    //   pickerDialogStyle: PickerDialogStyle(
                    //     countryNameStyle: TextStyle(
                    //       color: Theme.of(context)
                    //           .textTheme
                    //           .titleMedium!
                    //           .color,
                    //     ),
                    //   ),
                    //   decoration: InputDecoration(
                    //     filled: true,
                    //     fillColor: Colors.grey.withOpacity(0.1),
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(15),
                    //       borderSide: BorderSide.none,
                    //     ),
                    //   ),
                    //   languageCode: "en",
                    //   dropdownIconPosition: IconPosition.trailing,
                    //   onChanged: (phone) {},
                    //   onCountryChanged: (country) {},
                    //   dropdownIcon: Icon(Icons.arrow_drop_down_sharp,
                    //       color: svgTheme),
                    // ),
                    CTextField(
                        hint: LocaleKeys.dashboard_profile__edit_profile_phone_number.tr,
                        controller: controller.phoneController,
                        borderColor: Colors.transparent,
                        keyboardType: TextInputType.streetAddress,
                        autofillHints: const [AutofillHints.addressCityAndState],
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.1),
                        contentPadding: 15,
                        borderRadius: 12),
                    SizedBox(
                      height: mediaQueryHeight(context) * 0.03,
                    ),

                    CTextField(
                        hint: LocaleKeys.dashboard_profile__edit_profile_address.tr,
                        controller: controller.addressController,
                        borderColor: Colors.transparent,
                        keyboardType: TextInputType.streetAddress,
                        autofillHints: const [AutofillHints.addressCityAndState],
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.1),
                        contentPadding: 15,
                        borderRadius: 12),
                    Expanded(
                      child: SizedBox(
                        height: mediaQueryHeight(context) * 0.01,
                      ),
                    ),
                    CButton(
                      text: LocaleKeys.dashboard_profile__edit_profile_update.tr,
                      fontsize: titleMedium,
                      fontWeight: FontWeight.w500,
                      shadow: true,
                      borderradius: 50,
                      btnheight: kToolbarHeight * 0.9,
                      btnwidth: double.infinity,
                      ontab: () {},
                    ),
                    SizedBox(
                      height: mediaQueryHeight(context) * 0.03,
                    ),
                  ]),
                ),
              ));
        });
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:home_brigadier/consts/media_query.dart';
// import 'package:home_brigadier/utils/validation.dart';
// import 'package:home_brigadier/widget/c_filled_btn.dart';
// import 'package:home_brigadier/widget/c_text_field.dart';
//
// import '../../../../../../widget/cText.dart';
// import '../../../../../../widget/c_icon_btn.dart';
// import '../controllers/edit_profile_setting_controller.dart';
//
// class EditProfileSettingView extends GetView<EditProfileSettingController> {
//   const EditProfileSettingView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final svgTheme = Theme.of(context).textTheme.titleMedium!.color;
//     final txtTheme = Theme.of(context).textTheme.titleMedium!.color;
//     final titleLarge = Theme.of(context).textTheme.titleLarge!.fontSize;
//     final titleMedium = Theme.of(context).textTheme.titleMedium!.fontSize;
//     final titleSmall = Theme.of(context).textTheme.titleSmall!.fontSize;
//     return GetBuilder(
//         init: Get.put(EditProfileSettingController()),
//         builder: (builderContext) {
//           return Scaffold(
//               appBar: AppBar(
//                   leading:
//                       CIconBtn(onPressed: () => Get.back(), child: Icon(Icons.adaptive.arrow_back)),
//                   title: CText(
//                       text: "Edit profile",
//                       color: txtTheme,
//                       fontsize: titleLarge,
//                       fontWeight: FontWeight.w500)),
//               body: SingleChildScrollView(
//                 padding: EdgeInsets.symmetric(
//                     vertical: mediaQueryHeight(context) * .05,
//                     horizontal: mediaQueryWidth(context) * 0.05),
//                 child: SizedBox(
//                   height: mediaQueryHeight(context) * 0.9,
//                   child: Column(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         CTextField(
//                             hint: "First Name",
//                             controller: controller.fistNameController,
//                             borderColor: Colors.transparent,
//                             filled: true,
//                             fillColor: Colors.grey.withOpacity(0.1),
//                             contentPadding: 15,
//                             keyboardType: TextInputType.name,
//                             autofillHints: const [AutofillHints.namePrefix],
//                             borderRadius: 12),
//                         CTextField(
//                             hint: "Last Name",
//                             controller: controller.lastNameController,
//                             borderColor: Colors.transparent,
//                             keyboardType: TextInputType.name,
//                             autofillHints: const [AutofillHints.name],
//                             filled: true,
//                             fillColor: Colors.grey.withOpacity(0.1),
//                             contentPadding: 15,
//                             borderRadius: 12),
//                         CTextField(
//                             readOnly: true,
//                             enabled: true,
//                             borderRadius: 12,
//                             hint: "Date of Birth",
//                             keyboardType: TextInputType.datetime,
//                             autofillHints: const [AutofillHints.birthdayDay],
//                             focusBorderColor: Colors.transparent,
//                             controller: TextEditingController(
//                                 text: controller.formattedDate(controller.selectedDate)),
//                             borderColor: Colors.transparent,
//                             filled: true,
//                             fillColor: Colors.grey.withOpacity(0.1),
//                             contentPadding: 15,
//                             suffix: InkWell(
//                                 borderRadius: BorderRadius.circular(50),
//                                 onTap: () => controller.selectDate(context),
//                                 child: SvgPicture.asset("assets/icons/ic_booking_outlined.svg",
//                                     fit: BoxFit.scaleDown))),
//                         CTextField(
//                           validator: (p0) {
//                             return GetValidation.emaiValidation(controller.emailController);
//                           },
//                           hint: "Email",
//                           controller: TextEditingController(),
//                           borderColor: Colors.transparent,
//                           keyboardType: TextInputType.emailAddress,
//                           autofillHints: const [AutofillHints.email],
//                           filled: true,
//                           fillColor: Colors.grey.withOpacity(0.1),
//                           contentPadding: 15,
//                           borderRadius: 12,
//                           suffix: SvgPicture.asset("assets/icons/ic_email.svg",
//                               fit: BoxFit.scaleDown, color: svgTheme),
//                         ),
//                         CTextField(
//                             hint: "Country",
//                             controller: TextEditingController(),
//                             borderColor: Colors.transparent,
//                             keyboardType: TextInputType.emailAddress,
//                             autofillHints: const [AutofillHints.email],
//                             filled: true,
//                             fillColor: Colors.grey.withOpacity(0.1),
//                             contentPadding: 15,
//                             borderRadius: 12,
//                             suffix: IconButton(
//                                 onPressed: () {}, icon: const Icon(Icons.arrow_drop_down))),
//                         IntlPhoneField(
//                           controller: controller.phoneController,
//                           pickerDialogStyle: PickerDialogStyle(
//                             countryNameStyle: TextStyle(
//                               color: Theme.of(context).textTheme.titleMedium!.color,
//                             ),
//                           ),
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.grey.withOpacity(0.1),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),
//                           languageCode: "en",
//                           dropdownIconPosition: IconPosition.trailing,
//                           onChanged: (phone) {},
//                           onCountryChanged: (country) {},
//                           dropdownIcon: Icon(Icons.arrow_drop_down_sharp, color: svgTheme),
//                         ),
//                         Card(
//                           elevation: 0,
//                           color: AppColor.grey.withOpacity(0.1),
//                           child: DropdownButton<String>(
//                             underline: const SizedBox(),
//                             isExpanded: true,
//                             hint: const CText(text: "Gender"),
//                             padding: const EdgeInsets.all(8),
//                             borderRadius: BorderRadius.circular(12),
//                             value: controller.selectedGender,
//                             icon: const Icon(Icons.arrow_drop_down),
//                             onChanged: (String? newValue) {
//                               controller.selectedGender = newValue!;
//                               controller.update();
//                             },
//                             items:
//                                 controller.genderList.map<DropdownMenuItem<String>>((String value) {
//                               return DropdownMenuItem<String>(
//                                 value: value,
//                                 child: CText(text: value, color: txtTheme),
//                               );
//                             }).toList(),
//                           ),
//                         ),
//                         CTextField(
//                             hint: "Address",
//                             controller: controller.addressController,
//                             borderColor: Colors.transparent,
//                             keyboardType: TextInputType.streetAddress,
//                             autofillHints: const [AutofillHints.addressCityAndState],
//                             filled: true,
//                             fillColor: Colors.grey.withOpacity(0.1),
//                             contentPadding: 15,
//                             borderRadius: 12),
//                         CButton(
//                           text: "Update",
//                           fontsize: titleMedium,
//                           fontWeight: FontWeight.w500,
//                           shadow: true,
//                           borderradius: 50,
//                           btnheight: kToolbarHeight * 0.9,
//                           btnwidth: double.infinity,
//                         )
//                       ]),
//                 ),
//               ));
//         });
//   }
// }
