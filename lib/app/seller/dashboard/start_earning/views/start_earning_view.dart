import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/house_cleaning/controllers/booking_controller.dart';

import '../../../../../consts/app_color.dart';
import '../../../../../consts/media_query.dart';
import '../../../../../generated/locales.g.dart';
import '../../../../../services/apis/toast.dart';
import '../../../../../utils/logger.dart';
import '../../../../../widget/cText.dart';
import '../../../../../widget/c_filled_btn.dart';
import '../../../../../widget/c_text_field.dart';
import '../../profile/user_profile/controllers/user_profile_controller.dart';
import '../controllers/start_earning_controller.dart';

class StartEarningView extends GetView<StartEarningController> {
  const StartEarningView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BookingController con = Get.put(BookingController());

    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final txtTheme = Theme.of(context).textTheme.titleMedium!.color;

    return Scaffold(
        appBar: AppBar(
          leading: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/app_icon.jpg")),
              borderRadius: BorderRadius.all(Radius.circular(12)),
              // color: AppColor.secondary
            ),
            // child: SvgPicture.asset("assets/icons/ic_logo.svg")
          ),
          title: CText(
              text: LocaleKeys.dashboard_items_start_earning.tr,
              fontWeight: FontWeight.bold,
              color: txtTheme,
              fontsize: mediaQueryHeight(context) * 0.025),
        ),
        body: GetBuilder(
            init: Get.put(StartEarningController()),
            builder: (_) {
              return controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                        controller: controller.scrollController,
                        physics: const BouncingScrollPhysics(),
                        // padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // profilePic(context),
                            Container(
                              margin: const EdgeInsets.only(top: 0),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                              decoration: BoxDecoration(
                                  color: AppColor.greylight.withOpacity(0.1),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(35), topRight: Radius.circular(35))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  title(context, LocaleKeys.upload_profile_pic.tr),
                                  profilePic(context),
                                  title(context, LocaleKeys.start_earning_item_full_name.tr),
                                  CTextField(
                                    contentPadding: 15,
                                    hint: LocaleKeys.start_earning_item_enter_full_name.tr,
                                    controller: controller.nameController,
                                    borderColor: Colors.transparent,
                                    borderRadius: 12,
                                    filled: true,
                                    fillColor: Colors.grey.withOpacity(0.1),
                                    onChanged: (p0) => controller.update(),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return LocaleKeys.required_field.tr;
                                      }
                                      return null;
                                    },
                                  ),
                                  title(context, LocaleKeys.start_earning_item_selected_catg.tr),
                                  CustomDropdown<String>(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return LocaleKeys.required_field.tr;
                                        }
                                        return null;
                                      },
                                      // initialItem: controller.selectedCategory.value,
                                      decoration: CustomDropdownDecoration(
                                          errorStyle: const TextStyle(fontSize: 13),
                                          expandedBorder: Border.all(color: AppColor.primary),
                                          closedBorder: controller.categoryFocus.value
                                              ? Border.all(color: AppColor.primary)
                                              : Border.all(color: Colors.transparent),
                                          closedFillColor: AppColor.greylight.withOpacity(0.1)),
                                      hintText: LocaleKeys.start_earning_item_enter_select_catg.tr,
                                      items: controller.menuItems,
                                      onChanged: (newValue) {
                                        controller.onSelectCategory(newValue);
                                        controller.update();
                                      }),
                                  title(context, LocaleKeys.start_earning_item_discription.tr),
                                  CTextField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return LocaleKeys.required_field.tr;
                                        }
                                        return null;
                                      },
                                      contentPadding: 15,
                                      hint: LocaleKeys.start_earning_item_enter_decription.tr,
                                      controller: controller.descController,
                                      borderColor: Colors.transparent,
                                      borderRadius: 12,
                                      maxLines: 5,
                                      filled: true,
                                      fillColor: Colors.grey.withOpacity(0.1)),
                                  title(context,
                                      LocaleKeys.start_earning_item_select_working_hour.tr),
                                  Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: Row(children: [
                                      Expanded(
                                          child: CustomDropdown(
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return LocaleKeys.required_field.tr;
                                                }
                                                return null;
                                              },
                                              decoration: CustomDropdownDecoration(
                                                  errorStyle: const TextStyle(fontSize: 12),
                                                  expandedBorder:
                                                      Border.all(color: AppColor.primary),
                                                  closedBorder:
                                                      Border.all(color: Colors.transparent),
                                                  closedFillColor:
                                                      AppColor.greylight.withOpacity(0.1)),
                                              hintBuilder: (context, hint) {
                                                return Text(hint,
                                                    style: const TextStyle(
                                                        fontSize: 14, color: AppColor.grey));
                                              },
                                              hintText:
                                                  LocaleKeys.start_earning_item_enter_from_hours.tr,
                                              items: controller.hours,
                                              onChanged: (newValue) {
                                                controller.selectedFrom.value =
                                                    convertTo24Hour(newValue);
                                                // print(controller.selectedFrom.value);
                                              })),
                                      const SizedBox(width: 30),
                                      Expanded(
                                          child: CustomDropdown(
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return LocaleKeys.required_field.tr;
                                                }
                                                return null;
                                              },
                                              decoration: CustomDropdownDecoration(
                                                errorStyle: const TextStyle(fontSize: 13),
                                                expandedBorder: Border.all(color: AppColor.primary),
                                                closedBorder: Border.all(color: Colors.transparent),
                                                closedFillColor:
                                                    AppColor.greylight.withOpacity(0.1),
                                              ),
                                              hintBuilder: (context, hint) {
                                                return Text(hint,
                                                    style: const TextStyle(
                                                        fontSize: 14, color: AppColor.grey));
                                              },
                                              hintText:
                                                  LocaleKeys.start_earning_item_enter_till_hours.tr,
                                              items: controller.hours,
                                              onChanged: (newValue) {
                                                controller.selectedTill.value =
                                                    convertTo24Hour(newValue);
                                              }))
                                    ]),
                                  ),
                                  title(context, LocaleKeys.required_field.tr),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 80,
                                        decoration: BoxDecoration(
                                            // border: Border.all(
                                            //     color: controller
                                            //         .selectedWeekdays.isEmpty
                                            //         ? AppColor.red
                                            //         : Colors.transparent),
                                            borderRadius: BorderRadius.circular(12),
                                            color: AppColor.greylight.withOpacity(0.1)),
                                        child: ListView(
                                          physics: const BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          children: controller.weekdays.map((weekday) {
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 4),
                                              child: ChoiceChip(
                                                shape: StadiumBorder(
                                                    side: BorderSide(
                                                        color: controller.selectedWeekdays
                                                                .contains(weekday)
                                                            ? Colors.transparent
                                                            : AppColor.primary)),
                                                labelPadding: const EdgeInsets.symmetric(
                                                    horizontal: 7, vertical: 3),
                                                backgroundColor: AppColor.white,
                                                selectedColor: AppColor.primary,
                                                showCheckmark: false,
                                                label: Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: Text(
                                                      weekday[0].toUpperCase() +
                                                          weekday[1] +
                                                          weekday[2],
                                                      style: TextStyle(
                                                          color: controller.selectedWeekdays
                                                                  .contains(weekday)
                                                              ? AppColor.white
                                                              : Colors.black)),
                                                ),
                                                selected:
                                                    controller.selectedWeekdays.contains(weekday),
                                                onSelected: (isSelected) {
                                                  controller.toggleSelection(weekday);
                                                  controller.update();
                                                },
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      controller.selectedWeekdays.isEmpty
                                          ? CText(
                                              text: LocaleKeys.minimum_1_required.tr,
                                              fontsize: 13,
                                              color: AppColor.red,
                                            )
                                          : const SizedBox()
                                    ],
                                  ),
                                  title(context, LocaleKeys.start_earning_item_rate_per_hour.tr),
                                  Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: CTextField(
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return LocaleKeys.required_field.tr;
                                          }
                                          return null;
                                        },
                                        suffix: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: AppColor.greylight.withOpacity(0.2),
                                              borderRadius: const BorderRadius.only(
                                                  topRight: Radius.circular(12),
                                                  bottomRight: Radius.circular(12))),
                                          width: 28.0,
                                          height: 55.0,
                                          child: CText(
                                              text: LocaleKeys.start_earning_item_enter_rate.tr,
                                              fontsize: 16,
                                              textAlign: TextAlign.center,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        errorBorderColor: Colors.red,
                                        focusBorderColor: Colors.transparent,
                                        hint: "0.00",
                                        filled: true,
                                        fillColor: AppColor.greylight.withOpacity(0.1),
                                        controller: controller.rateController,
                                        borderColor: Colors.transparent,
                                        contentPadding: 5,
                                        borderRadius: 12),
                                  ),
                                  // const SizedBox(height: 30),
                                  title(context, LocaleKeys.start_earning_item_for_location.tr),
                                  SizedBox(
                                    width: mediaQueryWidth(context),
                                    height: mediaQueryHeight(context) * 0.4,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: GoogleMap(
                                        myLocationEnabled: true,
                                        markers: Set<Marker>.of(con.mapmarker),
                                        onMapCreated: (controller) {
                                          con.mapController = controller;
                                        },
                                        initialCameraPosition: const CameraPosition(
                                          target: LatLng(55.27, 25.20),
                                          // Initial map center
                                          zoom: 10.0,
                                        ),
                                        onTap: (LatLng location) {
                                          logger.d("change lang $location");
                                          con.pickLocation(location);
                                        },
                                      ),
                                    ),
                                  ),
                                  title(context, LocaleKeys.start_earning_item_area.tr),
                                  CTextField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return LocaleKeys.required_field.tr;
                                        }
                                        return null;
                                      },
                                      contentPadding: 15,
                                      hint: LocaleKeys.start_earning_item_villa_number.tr,
                                      controller: controller.villaController,
                                      borderColor: Colors.transparent,
                                      borderRadius: 12,
                                      filled: true,
                                      keyboardType: TextInputType.streetAddress,
                                      fillColor: Colors.grey.withOpacity(0.1)),
                                  title(context, LocaleKeys.start_earning_item_address.tr),
                                  CTextField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return LocaleKeys.required_field.tr;
                                        }
                                        return null;
                                      },
                                      contentPadding: 15,
                                      hint: LocaleKeys.start_earning_item_enter_address.tr,
                                      controller: controller.addressController,
                                      borderColor: Colors.transparent,
                                      borderRadius: 12,
                                      filled: true,
                                      keyboardType: TextInputType.streetAddress,
                                      fillColor: Colors.grey.withOpacity(0.1)),
                                  title(context, LocaleKeys.edit_services_emirates_id.tr),

                                  idCardPic(context: context),

                                  title(context, LocaleKeys.edit_services_upload_picture.tr),
                                  workingPic(context: context),

                                  const SizedBox(height: 30),
                                  Align(
                                    alignment: Alignment.center,
                                    child: CButton(
                                      ontab: () {
                                        if (_formKey.currentState!.validate()) {
                                          if (controller.backFileId != '' &&
                                              controller.frontFileId != '' &&
                                              controller.profileFileId != '' &&
                                              controller.workingFileId != '') {
                                            controller.addNewService(context);
                                          } else {
                                            showsnackbar("image not Selected", true);
                                          }
                                        } else {
                                          controller.scrollController.animateTo(
                                            0.0,
                                            duration: const Duration(milliseconds: 500),
                                            curve: Curves.easeInOut,
                                          );
                                        }
                                      },
                                      text: LocaleKeys.start_earning_item_submit.tr,
                                      btnwidth: mediaQueryWidth(context) * 0.9,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
            }));
  }

  Widget fillContainer({required Widget child}) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: AppColor.greylight.withOpacity(0.1)),
        child: child);
  }

  Widget title(context, text, [double? size]) {
    final titleLarge = Theme.of(context).textTheme.titleLarge!.fontSize;
    return Padding(
        padding: const EdgeInsets.only(top: 18, bottom: 8),
        child: CText(textAlign: TextAlign.start, text: text, fontsize: size ?? titleLarge));
  }

  Widget idCardPic({required context}) {
    return Row(children: [
      Expanded(
          child: Column(
        children: [
          title(context, LocaleKeys.edit_services_front.tr, 15),
          Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
              child: InkWell(
                  onTap: () => controller.pickIdFrontImage(),
                  child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12)),
                      child: controller.frontUploading.value
                          ? const Center(child: CircularProgressIndicator())
                          : controller.selectedFrontImage.value != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(controller.selectedFrontImage.value!,
                                      fit: BoxFit.cover))
                              : Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                      const Icon(Icons.image_outlined),
                                      Text(LocaleKeys.edit_services_select_image.tr)
                                    ])))),
        ],
      )),
      const SizedBox(width: 10),
      Expanded(
          child: Column(
        children: [
          title(context, LocaleKeys.edit_services_back.tr, 15),
          Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
              child: InkWell(
                  onTap: () => controller.pickIdBackImage(),
                  child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12)),
                      child: controller.backUploading.value
                          ? const Center(child: CircularProgressIndicator())
                          : controller.selectedBackImage.value != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(controller.selectedBackImage.value!,
                                      fit: BoxFit.cover))
                              : Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                      const Icon(Icons.image_outlined),
                                      Text(LocaleKeys.edit_services_select_image.tr)
                                    ])))),
        ],
      ))
    ]);
  }

  Widget profilePic(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
          margin: const EdgeInsets.only(top: 20, bottom: 10),
          height: 100,
          width: 100,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: AppColor.secondary.withOpacity(0.5)),
          child: InkWell(
              onTap: () => controller.pickProfileImage(),
              child: controller.profileUploading.value
                  ? const Center(child: CircularProgressIndicator())
                  : controller.selectedProfileImage.value != null
                      ? ClipOval(
                          child: Image.file(
                            controller.selectedProfileImage.value!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        )
                      : const Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_outlined,
                              size: 30,
                            ),
                          ],
                        ))),
    );
  }

  Widget workingPic({required context}) {
    return Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
        child: InkWell(
            onTap: () => controller.pickWorkingImage(),
            child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: controller.workingUploading.value
                    ? const Center(child: CircularProgressIndicator())
                    : controller.selectedworkingImage.value != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(controller.selectedworkingImage.value!,
                                fit: BoxFit.cover))
                        : Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                const Icon(Icons.image_outlined),
                                Text(LocaleKeys.edit_services_select_image.tr)
                              ]))));
  }
}

// // ignore_for_file: use_super_parameters
//
// import 'package:animated_custom_dropdown/custom_dropdown.dart';
// import 'package:flutter/material.dart';
//
// import 'package:get/get.dart';
// import 'package:home_brigadier/app/seller/dashboard/bookings/controllers/bookings_controller.dart';
// import 'package:home_brigadier/generated/locales.g.dart';
// import 'package:home_brigadier/services/apis/toast.dart';
// import 'package:home_brigadier/widget/c_filled_btn.dart';
// import 'package:home_brigadier/widget/c_text_field.dart';
//
// import '../../../../../consts/app_color.dart';
// import '../../../../../consts/media_query.dart';
// import '../../../../../widget/cText.dart';
// import '../../profile/user_profile/controllers/user_profile_controller.dart';
// import '../controllers/start_earning_controller.dart';
//
// class StartEarningView extends GetView<StartEarningController> {
//   const StartEarningView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Get.put(StartEarningController());
//     Get.put(BookingsController());
//
//     GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//     final txtTheme = Theme.of(context).textTheme.titleMedium!.color;
//
//     return Scaffold(
//         appBar: AppBar(
//           leading: Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Container(
//                 decoration: const BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(12)),
//                 ),
//                 child:
//                     Center(child: Image.asset("assets/images/ic_splash.png"))),
//           ),
//           title: CText(
//               text: LocaleKeys.dashboard_items_start_earning.tr,
//               fontWeight: FontWeight.bold,
//               color: txtTheme,
//               fontsize: mediaQueryHeight(context) * 0.025),
//         ),
//         body: GetBuilder(
//             init: Get.put(StartEarningController()),
//             builder: (_) {
//               return controller.isLoading.value
//                   ? const Center(child: CircularProgressIndicator())
//                   : Form(
//                       key: _formKey,
//                       child: SingleChildScrollView(
//                         controller: controller.scrollController,
//                         physics: const BouncingScrollPhysics(),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 15, vertical: 10),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               width: double.maxFinite,
//                               child: CText(
//                                   textAlign: TextAlign.start,
//                                   text: LocaleKeys
//                                       .start_earning_item_service_info.tr,
//                                   fontsize: 30,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                             const SizedBox(height: 10),
//                             SizedBox(
//                                 width: double.maxFinite,
//                                 child: Text(
//                                   LocaleKeys.start_earning_item_txt.tr,
//                                   textAlign: TextAlign.start,
//                                   style: const TextStyle(color: Colors.grey),
//                                 )),
//
//                             title(context,
//                                 LocaleKeys.start_earning_item_full_name.tr),
//                             CTextField(
//                               contentPadding: 15,
//                               hint: LocaleKeys
//                                   .start_earning_item_enter_full_name.tr,
//                               controller: controller.nameController,
//                               borderColor: Colors.transparent,
//                               borderRadius: 12,
//                               filled: true,
//                               fillColor: Colors.grey.withOpacity(0.1),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return LocaleKeys.required_field.tr;
//                                 }
//                                 return null;
//                               },
//                             ),
//                             title(context,
//                                 LocaleKeys.start_earning_item_selected_catg.tr),
//                             CustomDropdown<String>(
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return LocaleKeys.required_field.tr;
//                                   }
//                                   return null;
//                                 },
//                                 // initialItem: controller.selectedCategory.value,
//                                 decoration: CustomDropdownDecoration(
//                                     errorStyle: const TextStyle(fontSize: 13),
//                                     expandedBorder:
//                                         Border.all(color: AppColor.primary),
//                                     closedBorder: controller.categoryFocus.value
//                                         ? Border.all(color: AppColor.primary)
//                                         : Border.all(color: Colors.transparent),
//                                     closedFillColor:
//                                         AppColor.greylight.withOpacity(0.1)),
//                                 hintText: LocaleKeys
//                                     .start_earning_item_enter_select_catg.tr,
//                                 items: controller.menuItems,
//                                 onChanged: (newValue) {
//                                   controller.selectedCategory.value = newValue;
//                                   controller.onSelectCategory(newValue);
//                                   controller.update();
//                                 }),
//                             title(context,
//                                 LocaleKeys.start_earning_item_discription.tr),
//                             CTextField(
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return LocaleKeys.required_field.tr;
//                                   }
//                                   return null;
//                                 },
//                                 contentPadding: 15,
//                                 hint: LocaleKeys
//                                     .start_earning_item_enter_decription.tr,
//                                 controller: controller.descController,
//                                 borderColor: Colors.transparent,
//                                 borderRadius: 12,
//                                 maxLines: 5,
//                                 filled: true,
//                                 fillColor: Colors.grey.withOpacity(0.1)),
//                             title(
//                                 context,
//                                 LocaleKeys
//                                     .start_earning_item_select_working_hour.tr),
//                             Directionality(
//                               textDirection: TextDirection.ltr,
//                               child: Row(children: [
//                                 Expanded(
//                                     child: CustomDropdown(
//                                         validator: (value) {
//                                           if (value == null || value.isEmpty) {
//                                             return LocaleKeys.required_field.tr;
//                                           }
//                                           return null;
//                                         },
//                                         decoration: CustomDropdownDecoration(
//                                             errorStyle:
//                                                 const TextStyle(fontSize: 12),
//                                             expandedBorder: Border.all(
//                                                 color: AppColor.primary),
//                                             closedBorder: Border.all(
//                                                 color: Colors.transparent),
//                                             closedFillColor: AppColor.greylight
//                                                 .withOpacity(0.1)),
//                                         hintBuilder: (context, hint) {
//                                           return Text(hint,
//                                               style: const TextStyle(
//                                                   fontSize: 14,
//                                                   color: AppColor.grey));
//                                         },
//                                         hintText: LocaleKeys
//                                             .start_earning_item_enter_from_hours
//                                             .tr,
//                                         items: controller.hours,
//                                         onChanged: (newValue) {
//                                           controller.selectedFrom.value =
//                                               convertTo24Hour(newValue);
//                                           // print(controller.selectedFrom.value);
//                                         })),
//                                 const SizedBox(width: 30),
//                                 Expanded(
//                                     child: CustomDropdown(
//                                         validator: (value) {
//                                           if (value == null || value.isEmpty) {
//                                             return LocaleKeys.required_field.tr;
//                                           }
//                                           return null;
//                                         },
//                                         decoration: CustomDropdownDecoration(
//                                           errorStyle:
//                                               const TextStyle(fontSize: 13),
//                                           expandedBorder: Border.all(
//                                               color: AppColor.primary),
//                                           closedBorder: Border.all(
//                                               color: Colors.transparent),
//                                           closedFillColor: AppColor.greylight
//                                               .withOpacity(0.1),
//                                         ),
//                                         hintBuilder: (context, hint) {
//                                           return Text(hint,
//                                               style: const TextStyle(
//                                                   fontSize: 14,
//                                                   color: AppColor.grey));
//                                         },
//                                         hintText: LocaleKeys
//                                             .start_earning_item_enter_till_hours
//                                             .tr,
//                                         items: controller.hours,
//                                         onChanged: (newValue) {
//                                           controller.selectedTill.value =
//                                               convertTo24Hour(newValue);
//                                         }))
//                               ]),
//                             ),
//                             title(
//                                 context,
//                                 LocaleKeys
//                                     .start_earning_item_selct_working_days.tr),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   height: 80,
//                                   decoration: BoxDecoration(
//                                       // border: Border.all(
//                                       //     color: controller
//                                       //             .selectedWeekdays.isEmpty
//                                       //         ? AppColor.red
//                                       //         : Colors.transparent),
//                                       borderRadius: BorderRadius.circular(12),
//                                       color:
//                                           AppColor.greylight.withOpacity(0.1)),
//                                   child: ListView(
//                                     physics: const BouncingScrollPhysics(),
//                                     scrollDirection: Axis.horizontal,
//                                     children:
//                                         controller.weekdays.map((weekday) {
//                                       return Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 4),
//                                         child: ChoiceChip(
//                                           shape: StadiumBorder(
//                                               side: BorderSide(
//                                                   color: controller
//                                                           .selectedWeekdays
//                                                           .contains(weekday)
//                                                       ? Colors.transparent
//                                                       : AppColor.primary)),
//                                           labelPadding:
//                                               const EdgeInsets.symmetric(
//                                                   horizontal: 7, vertical: 3),
//                                           backgroundColor: AppColor.white,
//                                           selectedColor: AppColor.primary,
//                                           showCheckmark: false,
//                                           label: Text(weekday,
//                                               style: TextStyle(
//                                                   color: controller
//                                                           .selectedWeekdays
//                                                           .contains(weekday)
//                                                       ? AppColor.white
//                                                       : Colors.black)),
//                                           selected: controller.selectedWeekdays
//                                               .contains(weekday),
//                                           onSelected: (isSelected) {
//                                             controller.toggleSelection(weekday);
//                                             controller.update();
//                                           },
//                                         ),
//                                       );
//                                     }).toList(),
//                                   ),
//                                 ),
//                                 controller.selectedWeekdays.isEmpty
//                                     ? CText(
//                                         text: LocaleKeys.minimum_1_required.tr,
//                                         fontsize: 13,
//                                         color: AppColor.red,
//                                       )
//                                     : const SizedBox()
//                               ],
//                             ),
//
//                             title(context,
//                                 LocaleKeys.start_earning_item_rate_per_hour.tr),
//                             Directionality(
//                               textDirection: TextDirection.ltr,
//                               child: CTextField(
//                                   keyboardType: TextInputType.number,
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return LocaleKeys.required_field.tr;
//                                     }
//                                     return null;
//                                   },
//                                   suffix: Container(
//                                     alignment: Alignment.center,
//                                     decoration: BoxDecoration(
//                                         color:
//                                             AppColor.greylight.withOpacity(0.2),
//                                         borderRadius: const BorderRadius.only(
//                                             topRight: Radius.circular(12),
//                                             bottomRight: Radius.circular(12))),
//                                     width: 28.0,
//                                     height: 55.0,
//                                     child: CText(
//                                         text: LocaleKeys
//                                             .start_earning_item_enter_rate.tr,
//                                         fontsize: 16,
//                                         textAlign: TextAlign.center,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                   errorBorderColor: Colors.red,
//                                   focusBorderColor: Colors.transparent,
//                                   hint: "0.00",
//                                   controller: controller.rateController,
//                                   borderColor: Colors.transparent,
//                                   contentPadding: 5,
//                                   borderRadius: 12),
//                             ),
//                             // const SizedBox(height: 30),
//                             //  title(context, LocaleKeys.start_earning_item_for_location.tr),
//                             //assets/images/map_new.jpeg
//
//                             //  Container(
//
//                             //     width: mediaQueryWidth(context),
//                             //     height: mediaQueryHeight(context) * 0.4,
//                             //     child: Image.asset("/assets/images/map_new.png",fit: BoxFit.cover,),
//                             //  ),
//                             // SizedBox(
//                             //   width: mediaQueryWidth(context),
//                             //   height: mediaQueryHeight(context) * 0.4,
//                             //   child: ClipRRect(
//                             //     borderRadius: BorderRadius.circular(12),
//                             //     child: GoogleMap(
//                             //       myLocationEnabled: true,
//                             //       markers: Set<Marker>.of(con.mapmarker),
//                             //       onMapCreated: (controller) {
//                             //         con.mapController = controller;
//                             //       },
//                             //       initialCameraPosition: const CameraPosition(
//                             //         target: LatLng(55.27, 25.20),
//                             //         // Initial map center
//                             //         zoom: 10.0,
//                             //       ),
//                             //       onTap: (LatLng location) {
//                             //         logger.d("change lang $location");
//                             //         con.pickLocation(location);
//                             //       },
//                             //     ),
//                             //   ),
//                             // ),
//
//                             title(
//                                 context, LocaleKeys.start_earning_item_area.tr),
//                             CTextField(
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return LocaleKeys.required_field.tr;
//                                   }
//                                   return null;
//                                 },
//                                 contentPadding: 15,
//                                 hint: LocaleKeys
//                                     .start_earning_item_villa_number.tr,
//                                 controller: controller.villaController,
//                                 borderColor: Colors.transparent,
//                                 borderRadius: 12,
//                                 filled: true,
//                                 keyboardType: TextInputType.streetAddress,
//                                 fillColor: Colors.grey.withOpacity(0.1)),
//
//                             title(context,
//                                 LocaleKeys.start_earning_item_address.tr),
//                             CTextField(
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return LocaleKeys.required_field.tr;
//                                   }
//                                   return null;
//                                 },
//                                 contentPadding: 15,
//                                 hint: LocaleKeys
//                                     .start_earning_item_enter_address.tr,
//                                 controller: controller.addressController,
//                                 borderColor: Colors.transparent,
//                                 borderRadius: 12,
//                                 filled: true,
//                                 keyboardType: TextInputType.streetAddress,
//                                 fillColor: Colors.grey.withOpacity(0.1)),
//                             title(
//                                 context,
//                                 LocaleKeys
//                                     .start_earning_item_upload_picture.tr),
//                             Container(
//                                 height: 200,
//                                 width: double.infinity,
//                                 decoration: BoxDecoration(
//                                     color: Colors.grey.withOpacity(0.1),
//                                     borderRadius: BorderRadius.circular(12)),
//                                 child: InkWell(
//                                     onTap: () =>
//                                         controller.pickImageFromGallery(),
//                                     child: Container(
//                                         height: 200,
//                                         width: double.infinity,
//                                         decoration: BoxDecoration(
//                                             color: Colors.grey.withOpacity(0.1),
//                                             borderRadius:
//                                                 BorderRadius.circular(12)),
//                                         child: controller.imgUploading.value
//                                             ? const Center(
//                                                 child:
//                                                     CircularProgressIndicator())
//                                             : controller.selectedImage.value !=
//                                                     null
//                                                 ? ClipRRect(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             12),
//                                                     child: Image.file(
//                                                         controller.selectedImage
//                                                             .value!,
//                                                         fit: BoxFit.cover))
//                                                 : Column(
//                                                     mainAxisSize:
//                                                         MainAxisSize.max,
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .center,
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .center,
//                                                     children: [
//                                                         const Icon(Icons
//                                                             .image_outlined),
//                                                         Text(LocaleKeys
//                                                             .start_earning_item_tap_to_upload
//                                                             .tr)
//                                                       ])))),
//                             const SizedBox(height: 30),
//                             Align(
//                               alignment: Alignment.center,
//                               child: CButton(
//                                 ontab: () {
//                                   if (_formKey.currentState!.validate()) {
//                                     if (controller.fileId != '') {
//                                       controller.addNewService(context);
//                                     } else {
//                                       showsnackbar("image not Selected", true);
//                                     }
//                                   } else {
//                                     controller.scrollController.animateTo(
//                                       0.0,
//                                       duration:
//                                           const Duration(milliseconds: 500),
//                                       curve: Curves.easeInOut,
//                                     );
//                                   }
//                                 },
//                                 text: LocaleKeys.start_earning_item_submit.tr,
//                                 btnwidth: mediaQueryWidth(context) * 0.9,
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     );
//             }));
//   }
//
//   Widget fillContainer({required Widget child}) {
//     return Container(
//         width: double.infinity,
//         padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             color: AppColor.greylight.withOpacity(0.1)),
//         child: child);
//   }
//
//   Widget title(context, text) {
//     final titleLarge = Theme.of(context).textTheme.titleLarge!.fontSize;
//     return Padding(
//         padding: const EdgeInsets.only(top: 18, bottom: 8),
//         child: CText(
//             textAlign: TextAlign.start, text: text, fontsize: titleLarge));
//   }
// }
