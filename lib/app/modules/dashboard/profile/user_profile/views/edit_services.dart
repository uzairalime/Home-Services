import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../consts/app_color.dart';
import '../../../../../../consts/const.dart';
import '../../../../../../consts/media_query.dart';
import '../../../../../../generated/locales.g.dart';
import '../../../../../../model/user_services_models/my_services_resp_model.dart';
import '../../../../../../widget/cText.dart';
import '../../../../../../widget/c_filled_btn.dart';
import '../../../../../../widget/c_text_field.dart';
import '../../../home/all_services/selected_category/category_item/house_cleaning/controllers/booking_controller.dart';
import '../controllers/user_profile_controller.dart';

class EditUserService extends StatefulWidget {
  final MyServicesRespModel? serviceModel;
  const EditUserService({this.serviceModel, super.key});

  @override
  State<EditUserService> createState() => _EditUserServiceState();
}

class _EditUserServiceState extends State<EditUserService> {
  late final UserProfileController controller;
  late final BookingController con;

  @override
  void initState() {
    controller = Get.put(UserProfileController());
    con = Get.find();

    List<RespOpeningHours>? openingHours = widget.serviceModel!.openingHours;
    controller.nameController.text = widget.serviceModel!.name!;
    controller.descController.text = widget.serviceModel!.description!;
    controller.rateController.text = widget.serviceModel!.rate!;
    controller.addressController.text = widget.serviceModel!.address!;
    controller.previousImage =
        "https://homebrigadier.fly.dev${widget.serviceModel!.files![0].file}";
    for (var element in openingHours!) {
      if (controller.selectedWeekdays.contains(element.weekday)) {
      } else {
        controller.selectedWeekdays.add(element.weekday!);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final txtTheme = Theme.of(context).textTheme.titleMedium!.color;

    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: CText(
                text: LocaleKeys.dashboard_profile_edit_profile.tr,
                fontWeight: FontWeight.bold,
                color: txtTheme,
                fontsize: mediaQueryHeight(context) * 0.025)),
        body: GetBuilder(
            init: Get.put(UserProfileController()),
            builder: (_) {
              return controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        controller: controller.scrollController,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.maxFinite,
                              child: CText(
                                  textAlign: TextAlign.start,
                                  text:
                                      LocaleKeys.edit_services_service_info.tr,
                                  fontsize: 30,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                                width: double.maxFinite,
                                child: Text(
                                  controller.txt,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(color: Colors.grey),
                                )),

                            title(
                                context, LocaleKeys.edit_services_full_name.tr),
                            CTextField(
                              contentPadding: 15,
                              hint: LocaleKeys.edit_services_enter_full_name.tr,
                              controller: controller.nameController,
                              borderColor: Colors.transparent,
                              borderRadius: 12,
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.1),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return LocaleKeys.required_field.tr;
                                }
                                return null;
                              },
                            ),
                            title(context,
                                LocaleKeys.edit_services_selected_catg.tr),
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: CustomDropdown<String>(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return LocaleKeys.required_field.tr;
                                    }
                                    return null;
                                  },
                                  initialItem:
                                      controller.selectedCategory.value,
                                  decoration: CustomDropdownDecoration(
                                      errorStyle: const TextStyle(fontSize: 13),
                                      expandedBorder:
                                          Border.all(color: AppColor.primary),
                                      closedBorder: controller
                                              .categoryFocus.value
                                          ? Border.all(color: AppColor.primary)
                                          : Border.all(
                                              color: Colors.transparent),
                                      closedFillColor:
                                          AppColor.greylight.withOpacity(0.1)),
                                  hintText: LocaleKeys
                                      .edit_services_enter_select_catg.tr,
                                  items: controller.menuItems,
                                  onChanged: (newValue) {
                                    controller.selectedCategory.value =
                                        newValue;
                                    controller.onSelectCategory(newValue);
                                    controller.update();
                                  }),
                            ),
                            title(context,
                                LocaleKeys.edit_services_discription.tr),
                            CTextField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return LocaleKeys.required_field.tr;
                                  }
                                  return null;
                                },
                                contentPadding: 15,
                                hint: LocaleKeys
                                    .edit_services_enter_decription.tr,
                                controller: controller.descController,
                                borderColor: Colors.transparent,
                                borderRadius: 12,
                                maxLines: 5,
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.1)),
                            title(
                                context,
                                LocaleKeys
                                    .edit_services_select_working_hour.tr),
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
                                            errorStyle:
                                                const TextStyle(fontSize: 12),
                                            expandedBorder: Border.all(
                                                color: AppColor.primary),
                                            closedBorder: Border.all(
                                                color: Colors.transparent),
                                            closedFillColor: AppColor.greylight
                                                .withOpacity(0.1)),
                                        hintBuilder: (context, hint) {
                                          return Text(hint,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: AppColor.grey));
                                        },
                                        hintText: LocaleKeys
                                            .edit_services_enter_from_hours.tr,
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
                                          errorStyle:
                                              const TextStyle(fontSize: 13),
                                          expandedBorder: Border.all(
                                              color: AppColor.primary),
                                          closedBorder: Border.all(
                                              color: Colors.transparent),
                                          closedFillColor: AppColor.greylight
                                              .withOpacity(0.1),
                                        ),
                                        hintBuilder: (context, hint) {
                                          return Text(hint,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: AppColor.grey));
                                        },
                                        hintText: LocaleKeys
                                            .edit_services_enter_till_hours.tr,
                                        items: controller.hours,
                                        onChanged: (newValue) {
                                          controller.selectedTill.value =
                                              convertTo24Hour(newValue);
                                        }))
                              ]),
                            ),
                            title(context,
                                LocaleKeys.edit_services_selct_working_days.tr),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: controller
                                                  .selectedWeekdays.isEmpty
                                              ? AppColor.red
                                              : Colors.transparent),
                                      borderRadius: BorderRadius.circular(12),
                                      color:
                                          AppColor.greylight.withOpacity(0.1)),
                                  child: ListView(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    children:
                                        controller.weekdays.map((weekday) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        child: ChoiceChip(
                                          shape: StadiumBorder(
                                              side: BorderSide(
                                                  color: controller
                                                          .selectedWeekdays
                                                          .contains(weekday)
                                                      ? Colors.transparent
                                                      : AppColor.primary)),
                                          labelPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 7, vertical: 3),
                                          backgroundColor: AppColor.white,
                                          selectedColor: AppColor.primary,
                                          showCheckmark: false,
                                          label: Text(weekday,
                                              style: TextStyle(
                                                  color: controller
                                                          .selectedWeekdays
                                                          .contains(weekday)
                                                      ? AppColor.white
                                                      : Colors.black)),
                                          selected: controller.selectedWeekdays
                                              .contains(weekday),
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
                            title(context,
                                LocaleKeys.edit_services_rate_per_hour.tr),
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: CTextField(
                                  filled: true,
                                  fillColor: Colors.grey.withOpacity(0.1),
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
                                        color:
                                            AppColor.greylight.withOpacity(0.2),
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(12),
                                            bottomRight: Radius.circular(12))),
                                    width: 28.0,
                                    height: 55.0,
                                    child: const CText(
                                        text: "AED",
                                        fontsize: 16,
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  errorBorderColor: Colors.red,
                                  focusBorderColor: Colors.transparent,
                                  hint: "0.00",
                                  controller: controller.rateController,
                                  borderColor: Colors.transparent,
                                  contentPadding: 5,
                                  borderRadius: 12),
                            ),
                            // const SizedBox(height: 30),
                            title(context,
                                LocaleKeys.edit_services_for_location.tr),
                            // SizedBox(
                            //   width: mediaQueryWidth(context),
                            //   height: mediaQueryHeight(context) * 0.4,
                            //   child: ClipRRect(
                            //     borderRadius: BorderRadius.circular(12),
                            //     child: GoogleMap(
                            //       myLocationEnabled: true,
                            //       markers: Set<Marker>.of(con.mapmarker),
                            //       onMapCreated: (controller) {
                            //         con.mapController = controller;
                            //       },
                            //       initialCameraPosition: const CameraPosition(
                            //         target: LatLng(55.27, 25.20),
                            //         // Initial map center
                            //         zoom: 10.0,
                            //       ),
                            //       onTap: (LatLng location) {
                            //         // logger.d("change lang $location");
                            //         con.pickLocation(location);
                            //       },
                            //     ),
                            //   ),
                            // ),

                            title(context, LocaleKeys.edit_services_address.tr),
                            CTextField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return LocaleKeys.required_field.tr;
                                  }
                                  return null;
                                },
                                contentPadding: 15,
                                hint: LocaleKeys.edit_services_enter_address.tr,
                                controller: controller.addressController,
                                borderColor: Colors.transparent,
                                borderRadius: 12,
                                filled: true,
                                keyboardType: TextInputType.streetAddress,
                                fillColor: Colors.grey.withOpacity(0.1)),
                            title(context,
                                LocaleKeys.edit_services_upload_picture.tr),
                            Container(
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12)),
                                child: InkWell(
                                    onTap: () =>
                                        controller.pickImageFromGallery(),
                                    child: Container(
                                        height: 200,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: controller.imgUploading.value
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator())
                                            : controller.selectedImage.value !=
                                                    null
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    child: Image.file(
                                                        controller.selectedImage
                                                            .value!,
                                                        fit: BoxFit.cover))
                                                : Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                        const Icon(Icons
                                                            .image_outlined),
                                                        Text(LocaleKeys
                                                            .edit_services_upload_picture
                                                            .tr)
                                                      ])))),
                            const SizedBox(height: 30),
                            Align(
                                alignment: Alignment.center,
                                child: CButton(
                                    ontab: () async {
                                      controller.update();
                                      int? id = widget.serviceModel!.id;

                                      if (_formKey.currentState!.validate()) {
                                        if (id != null) {
                                          controller.updateUserService(
                                              id: id,
                                              name: controller
                                                  .nameController.text,
                                              description: controller
                                                  .descController.text,
                                              category: convertToCamelCase(
                                                  controller
                                                      .selectedCategory.value),
                                              address: controller
                                                  .addressController.text,
                                              location: cPosition,
                                              fileId: controller.fileId == ''
                                                  ? widget.serviceModel!
                                                      .files![0].id
                                                      .toString()
                                                  : controller.fileId,
                                              weekDays:
                                                  controller.selectedWeekdays,
                                              from_hour:
                                                  controller.selectedFrom.value,
                                              to_hour:
                                                  controller.selectedTill.value,
                                              rate: controller
                                                  .rateController.text);
                                        }
                                      } else {
                                        controller.scrollController.animateTo(
                                          0.0,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.easeInOut,
                                        );
                                      }
                                    },
                                    text: LocaleKeys.edit_services_update.tr,
                                    btnwidth: mediaQueryWidth(context) * 0.9))
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
            borderRadius: BorderRadius.circular(12),
            color: AppColor.greylight.withOpacity(0.1)),
        child: child);
  }

  Widget title(context, text) {
    final titleLarge = Theme.of(context).textTheme.titleLarge!.fontSize;
    return Padding(
        padding: const EdgeInsets.only(top: 18, bottom: 8),
        child: CText(
            textAlign: TextAlign.start, text: text, fontsize: titleLarge));
  }
}

void resetValue(UserProfileController controller) {
  controller.nameController.clear();
  controller.descController.clear();
  controller.selectedFrom.value = '';
  controller.selectedTill.value = '';
  controller.previousImage = '';
  controller.addressController.clear();
  controller.isLoading.value = false;
  controller.rateController.clear();
  controller.selectedWeekdays.clear();
  controller.rateController.clear();

  controller.nameController.clear();
}
