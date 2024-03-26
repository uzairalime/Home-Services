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
  const StartEarningView({super.key});

  @override
  Widget build(BuildContext context) {
    BookingController con = Get.put(BookingController());
    Get.put(StartEarningController());
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final txtTheme = Theme.of(context).textTheme.titleMedium!.color;

    return Scaffold(
      appBar: AppBar(
          leading: Image.asset("assets/icons/ic_launcher_icon.png"),
          title: CText2(
              text: LocaleKeys.dashboard_items_start_earning.tr,
              fontWeight: FontWeight.bold,
              color: txtTheme,
              fontsize: mediaQueryHeight(context) * 0.025)),
      body: CustomScrollView(
        controller: controller.scrollController,
        physics: const BouncingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Form(
                    key: formKey,
                    child: GetBuilder<StartEarningController>(
                        builder: (_) => controller.isLoading.value
                            ? SizedBox(
                                height: mediaQueryHeight(context),
                                width: mediaQueryWidth(context),
                                child: const Center(child: CircularProgressIndicator()))
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                    Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                            margin: const EdgeInsets.only(top: 20, bottom: 10),
                                            height: 100,
                                            width: 100,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColor.secondary.withOpacity(0.2)),
                                            child: InkWell(
                                                borderRadius: BorderRadius.circular(50),
                                                onTap: () => controller.pickProfileImage(),
                                                child: controller.profileUploading.value
                                                    ? const Center(
                                                        child: CircularProgressIndicator())
                                                    : controller.selectedProfileImage.value != null
                                                        ? ClipOval(
                                                            child: Image.file(
                                                                controller
                                                                    .selectedProfileImage.value!,
                                                                fit: BoxFit.cover,
                                                                width: double.infinity,
                                                                height: double.infinity))
                                                        : const Center(
                                                            child: Icon(Icons.image_outlined,
                                                                size: 30))))),
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
                                        }),
                                    title(context,
                                        LocaleKeys.start_earning_item_enter_select_catg.tr),
                                    SizedBox(
                                      width: double.maxFinite,
                                      child: DropdownButtonFormField(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return LocaleKeys.required_field.tr;
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          errorBorder: const OutlineInputBorder(
                                              borderSide: BorderSide(color: AppColor.red),
                                              borderRadius: BorderRadius.all(Radius.circular(12))),
                                          contentPadding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 5),
                                          filled: true,
                                          fillColor: Colors.grey.withOpacity(0.1),
                                          focusedBorder: const OutlineInputBorder(
                                              borderSide: BorderSide(color: AppColor.secondary),
                                              borderRadius: BorderRadius.all(Radius.circular(12))),
                                          border: const OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius: BorderRadius.all(Radius.circular(12))),
                                        ),
                                        menuMaxHeight: mediaQueryHeight(context) * 0.4,
                                        hint: Text(
                                            LocaleKeys.start_earning_item_enter_select_catg.tr),
                                        items: controller.menuItems
                                            .map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          controller.onSelectCategory(newValue!);
                                          controller.update();
                                        },
                                      ),
                                    ),
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
                                              child: SizedBox(
                                            width: double.maxFinite,
                                            child: DropdownButtonFormField(
                                              autovalidateMode: AutovalidateMode.onUserInteraction,
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return LocaleKeys.required_field.tr;
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                errorBorder: const OutlineInputBorder(
                                                    borderSide: BorderSide(color: AppColor.red),
                                                    borderRadius:
                                                        BorderRadius.all(Radius.circular(12))),
                                                contentPadding: const EdgeInsets.symmetric(
                                                    horizontal: 15, vertical: 5),
                                                filled: true,
                                                fillColor: Colors.grey.withOpacity(0.1),
                                                focusedBorder: const OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide(color: AppColor.secondary),
                                                    borderRadius:
                                                        BorderRadius.all(Radius.circular(12))),
                                                border: const OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius:
                                                        BorderRadius.all(Radius.circular(12))),
                                              ),
                                              menuMaxHeight: mediaQueryHeight(context) * 0.4,
                                              hint: Text(LocaleKeys
                                                  .start_earning_item_enter_from_hours.tr),
                                              items: controller.hours
                                                  .map<DropdownMenuItem<String>>((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                              onChanged: (newValue) {
                                                if (newValue != null) {
                                                  controller.selectedFrom.value =
                                                      convertTo24Hour(newValue);
                                                }
                                              },
                                            ),
                                          )),
                                          const SizedBox(width: 20),
                                          Expanded(
                                              child: SizedBox(
                                            width: double.maxFinite,
                                            child: DropdownButtonFormField(
                                              autovalidateMode: AutovalidateMode.onUserInteraction,
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return LocaleKeys.required_field.tr;
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                errorBorder: const OutlineInputBorder(
                                                    borderSide: BorderSide(color: AppColor.red),
                                                    borderRadius:
                                                        BorderRadius.all(Radius.circular(12))),
                                                contentPadding: const EdgeInsets.symmetric(
                                                    horizontal: 15, vertical: 5),
                                                filled: true,
                                                fillColor: Colors.grey.withOpacity(0.1),
                                                focusedBorder: const OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide(color: AppColor.secondary),
                                                    borderRadius:
                                                        BorderRadius.all(Radius.circular(12))),
                                                border: const OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius:
                                                        BorderRadius.all(Radius.circular(12))),
                                              ),
                                              menuMaxHeight: mediaQueryHeight(context) * 0.4,
                                              hint: Text(LocaleKeys
                                                  .start_earning_item_enter_till_hours.tr),
                                              items: controller.hours
                                                  .map<DropdownMenuItem<String>>((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                              onChanged: (newValue) {
                                                if (newValue != null) {
                                                  controller.selectedTill.value =
                                                      convertTo24Hour(newValue);
                                                }
                                              },
                                            ),
                                          ))
                                        ])),
                                    title(context,
                                        LocaleKeys.start_earning_item_selct_working_days.tr),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 80,
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
                                    title(context, LocaleKeys.start_earning_item_for_location.tr),
                                    SizedBox(
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
                                          hint: "0.00",
                                          filled: true,
                                          fillColor: AppColor.greylight.withOpacity(0.1),
                                          controller: controller.rateController,
                                          borderColor: Colors.transparent,
                                          contentPadding: 5,
                                          borderRadius: 12),
                                    ),
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
                                        keyboardType: TextInputType.number,
                                        fillColor: Colors.grey.withOpacity(0.1)),
                                    title(context, LocaleKeys.edit_services_emirates_id.tr),
                                    Row(children: [
                                      Expanded(
                                          child: Column(
                                        children: [
                                          title(context, LocaleKeys.edit_services_front.tr, 15),
                                          Container(
                                              height: 120,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.withOpacity(0.1),
                                                  borderRadius: BorderRadius.circular(12)),
                                              child: InkWell(
                                                  onTap: () => controller.pickIdFrontImage(),
                                                  child: Container(
                                                      height: 200,
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          color: Colors.grey.withOpacity(0.1),
                                                          borderRadius: BorderRadius.circular(12)),
                                                      child: controller.frontUploading.value
                                                          ? const Center(
                                                              child: CircularProgressIndicator())
                                                          : controller.selectedFrontImage.value !=
                                                                  null
                                                              ? ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius.circular(12),
                                                                  child: Image.file(
                                                                      controller.selectedFrontImage
                                                                          .value!,
                                                                      fit: BoxFit.cover))
                                                              : Column(
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment.center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment.center,
                                                                  children: [
                                                                      const Icon(
                                                                          Icons.image_outlined),
                                                                      Text(LocaleKeys
                                                                          .edit_services_select_image
                                                                          .tr)
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
                                                  color: Colors.grey.withOpacity(0.1),
                                                  borderRadius: BorderRadius.circular(12)),
                                              child: InkWell(
                                                  onTap: () => controller.pickIdBackImage(),
                                                  child: Container(
                                                      height: 200,
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          color: Colors.grey.withOpacity(0.1),
                                                          borderRadius: BorderRadius.circular(12)),
                                                      child: controller.backUploading.value
                                                          ? const Center(
                                                              child: CircularProgressIndicator())
                                                          : controller.selectedBackImage.value !=
                                                                  null
                                                              ? ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius.circular(12),
                                                                  child: Image.file(
                                                                      controller
                                                                          .selectedBackImage.value!,
                                                                      fit: BoxFit.cover))
                                                              : Column(
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment.center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment.center,
                                                                  children: [
                                                                      const Icon(
                                                                          Icons.image_outlined),
                                                                      Text(LocaleKeys
                                                                          .edit_services_select_image
                                                                          .tr)
                                                                    ])))),
                                        ],
                                      ))
                                    ]),
                                    title(context, LocaleKeys.edit_services_upload_picture.tr),
                                    Container(
                                        height: 200,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(12)),
                                        child: InkWell(
                                            onTap: () => controller.pickWorkingImage(),
                                            child: Container(
                                                height: 200,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.withOpacity(0.1),
                                                    borderRadius: BorderRadius.circular(12)),
                                                child: controller.workingUploading.value
                                                    ? const Center(
                                                        child: CircularProgressIndicator())
                                                    : controller.selectedworkingImage.value != null
                                                        ? ClipRRect(
                                                            borderRadius: BorderRadius.circular(12),
                                                            child: Image.file(
                                                                controller
                                                                    .selectedworkingImage.value!,
                                                                fit: BoxFit.cover))
                                                        : Column(
                                                            mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment.center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment.center,
                                                            children: [
                                                                const Icon(Icons.image_outlined),
                                                                Text(LocaleKeys
                                                                    .edit_services_select_image.tr)
                                                              ])))),
                                    const SizedBox(height: 30),
                                    Align(
                                      alignment: Alignment.center,
                                      child: CButton(
                                        ontab: () {
                                          bool isFormValid = formKey.currentState!.validate();
                                          bool allImagesSelected = controller.backFileId != '' &&
                                              controller.frontFileId != '' &&
                                              controller.profileFileId != '' &&
                                              controller.workingFileId != '';

                                          if (isFormValid) {
                                            if (allImagesSelected) {
                                              controller.addNewService(context);
                                            } else {
                                              showSnackBar("Image not selected", true);
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
                                  ]))).paddingSymmetric(horizontal: 15)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget title(context, text, [double? size]) {
    final titleLarge = Theme.of(context).textTheme.titleLarge!.fontSize;
    return Padding(
        padding: const EdgeInsets.only(top: 18, bottom: 8),
        child: CText2(textAlign: TextAlign.start, text: text, fontsize: size ?? titleLarge));
  }
}
