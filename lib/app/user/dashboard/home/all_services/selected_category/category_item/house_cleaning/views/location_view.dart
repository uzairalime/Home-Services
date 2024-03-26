// ignore_for_file: unused_import, deprecated_member_use, unused_local_variable, use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:home_brigadier/app/modules/login/email_login/views/email_login_view.dart';
import 'package:home_brigadier/app/payment/stripe.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/house_cleaning/controllers/booking_controller.dart';
import 'package:home_brigadier/app/user/dashboard/home/views/location_pick.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/consts/media_query.dart';
import 'package:home_brigadier/consts/static_data.dart';
import 'package:home_brigadier/generated/locales.g.dart';
import 'package:home_brigadier/model/main.dart';
import 'package:home_brigadier/model/place_auto_complate_response.dart';
import 'package:home_brigadier/model/post_booking_model.dart';
import 'package:home_brigadier/services/apis/toast.dart';
import 'package:home_brigadier/utils/animation_dialog.dart';
import 'package:home_brigadier/utils/logger.dart';
import 'package:home_brigadier/utils/style.dart';
import 'package:home_brigadier/widget/cText.dart';
import 'package:home_brigadier/widget/c_filled_btn.dart';
import 'package:home_brigadier/widget/c_text_field.dart';

class LocationView extends GetView<BookingController> {
  const LocationView({super.key});

  ////

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    Get.put(BookingController());
    Get.put(PaymetController());

    var location = BookingController.to.currentPosition ??
        Position(
            longitude: 25.20,
            latitude: 55.27,
            timestamp: DateTime.now(),
            accuracy: 0,
            altitude: 0,
            altitudeAccuracy: 0,
            heading: 0,
            headingAccuracy: 0,
            speed: 0,
            speedAccuracy: 0);

    return GetBuilder<BookingController>(
        init: BookingController(),
        builder: (obj) {
          return Scaffold(
              bottomNavigationBar: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                      border: Border(
                          top: BorderSide(
                        color: AppColor.greylight,
                      ))),
                  child: Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 20, left: 20, right: 20),
                      child: CButton(
                        fontsize: 16,
                        text:
                            "${LocaleKeys.location_view_items_continue_button.tr} ${controller.total.value} AED",
                        shadow: true,
                        borderradius: widht * 0.075,
                        fontWeight: bold6,
                        ontab: () {
                          if (obj.addressController.text.isEmpty) {
                            showSnackBar(LocaleKeys.snack_bars_add_address.tr, true);
                          } else if (obj.flat.text.isEmpty) {
                            showSnackBar(LocaleKeys.snack_bar_enter_flat_number.tr, true);
                          } else {
                            if (StaticData.refreshToken.isNotEmpty) {
                              _onButtonPress(context, obj.addressController);
                            } else {
                              showSnackBar(LocaleKeys.snack_bars_login_then_booking.tr, true);
                              Get.to(() => const EmailLoginView(
                                    role: "buyer",
                                  ));
                            }
                          }
                        },
                      ))),
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: Text(
                  LocaleKeys.location_view_items_Location_address_view.tr,
                  style: appbar,
                ),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: widht * 0.05, vertical: height * 0.025),
                child: SizedBox(
                  width: widht,
                  height: height,
                  child: Column(
                    children: [
                      SizedBox(
                        width: widht,
                        height: height * 0.20,
                        child: GoogleMap(
                          myLocationEnabled: true,
                          markers: Set<Marker>.of(obj.mapmarker),
                          onMapCreated: (controller) {
                            obj.mapController = controller;
                          },
                          initialCameraPosition: CameraPosition(
                            target: obj.latLng ?? LatLng(25.204849, 55.270782),
                            // Initial map center
                            zoom: 10.0,
                          ),
                          onTap: (LatLng location) {
                            logger.d("change lang $location");
                            // obj.pickLocation(location);
                          },
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Container(
                        width: widht / 6,
                        height: height * 0.0075,
                        decoration: BoxDecoration(
                            color: const Color(0xfffe0e0e0),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      CText(
                        text: LocaleKeys.location_view_items_location_details.tr,
                        fontWeight: FontWeight.w600,
                        fontsize: widht * 0.05,
                      ),
                      SizedBox(
                        height: height * 0.015,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: CText(
                          text: LocaleKeys.location_view_items_address.tr,
                          fontWeight: FontWeight.w600,
                          fontsize: widht * 0.04,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.015,
                      ),
                      TextFormField(
                        style: const TextStyle(color: AppColor.primary),
                        onTapOutside: (PointerDownEvent p) {
                          FocusScope.of(context).unfocus();
                        },
                        onChanged: (val) {
                          obj.placeAutoComplete(val);
                        },
                        controller: obj.addressController,
                        decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: SizedBox(
                                  width: widht * 0.08,
                                  height: height * 0.045,
                                  child: Center(
                                      child: SvgPicture.asset(
                                    "assets/icons/ic_location_pin_filled.svg",
                                    color: AppColor.black,
                                  )),
                                ),
                              ),
                            ),
                            isDense: true,
                            contentPadding: const EdgeInsets.all(12),
                            hintText: LocaleKeys.enteraddress.tr,
                            hintStyle: TextStyle(color: AppColor.grey, fontSize: widht * 0.04),
                            filled: true,
                            fillColor: const Color(0xffF5F5F5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            )),
                      ),
                      obj.placeprediction.length == 0
                          ? SizedBox()
                          : Expanded(
                              child: locationTile(obj),
                            ),
                      SizedBox(
                        height: height * 0.015,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: CText(
                          text: LocaleKeys.flat_number.tr,
                          fontWeight: FontWeight.w600,
                          fontsize: widht * 0.04,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.015,
                      ),
                      CTextField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return LocaleKeys.required_field.tr;
                            }
                            return null;
                          },
                          contentPadding: 15,
                          hint: LocaleKeys.start_earning_item_villa_number.tr,
                          controller: controller.flat,
                          borderColor: Colors.transparent,
                          borderRadius: 12,
                          filled: true,
                          keyboardType: TextInputType.number,
                          fillColor: Colors.grey.withOpacity(0.1)),
                    ],
                  ),
                ),
              ));
        });
  }

  ListView locationTile(BookingController obj) {
    return ListView.builder(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: obj.placeprediction.length,
      itemBuilder: (context, index) {
        return LocationListTile(
          press: () async {
            obj.addressController.text = obj.placeprediction[index].description!;

            obj.placeprediction.clear();
            obj.update();
          },
          location: "${obj.placeprediction[index].description}",
        );
      },
    );
  }

  _onButtonPress(BuildContext context, TextEditingController address) async {
    // PaymetController.to.makePayment(context, "100000");

    PostBookingModel model = PostBookingModel(
        price: controller.total.toString(),
        startAt: controller.stardatetime,
        endAt: controller.enddatetime,
        address: "${address.text.toString()} ${controller.flat.text} ",
        location: controller.currentPosition.toString(),
        description: controller.instruction.text.toString().isEmpty
            ? ""
            : controller.instruction.text.toString(),
        serviceId: controller.servicemodel!.id!,
        extraInfo: ExtraInfo(
            cleaningFrequency: controller.selectedweekplan.toString(),
            isCheckedMaterialsNeeded: controller.selectedmaterial.value,
            noOfCleaners: controller.cleaner.string,
            noOfHours: controller.hours.toString(),
            selectedDaysOfWeek: []));

    controller.postbooking(model, context);
  }
}
