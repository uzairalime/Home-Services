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

class LocationView extends GetView<BookingController> {
  const LocationView({super.key});

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

    // controller.addlatlong(LatLng(location.latitude, location.longitude));

    return GetBuilder<BookingController>(
        init: BookingController(),
        builder: (obj) {
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  LocaleKeys.location_view_items_Location_address_view.tr,
                  style: appbar,
                ),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: widht * 0.05, vertical: height * 0.05),
                child: SizedBox(
                  width: widht,
                  height: height,
                  child: Column(
                    children: [
                      SizedBox(
                        width: widht,
                        height: height * 0.25,
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
                        text:
                            LocaleKeys.location_view_items_location_details.tr,
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
                        onChanged: (val) {
                          obj.placeAutoComplete(val);
                        },
                        controller: obj.addressController,
                        decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: () {},
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
                            hintText: "Enter address",
                            hintStyle: TextStyle(
                                color: AppColor.grey, fontSize: widht * 0.04),
                            filled: true,
                            fillColor: const Color(0xffF5F5F5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            )),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: obj.placeprediction.length,
                          itemBuilder: (context, index) {
                            return LocationListTile(
                              press: () async {
                                obj.addressController.text =
                                    obj.placeprediction[index].description!;

                                obj.placeprediction.clear();
                                obj.update();

                                //  List<Location> locations = await locationFromAddress(
                                //   localeIdentifier: "en",

                                //   "Gronausestraat 710, Enschede");

                                //   logger.d(
                                //       "!!!!!!!!!!!!!!!!!!!!!!!!!!${locations.length}");

                                //                            obj.mapController?.animateCamera(
                                //   CameraUpdate.newLatLngZoom(obj.placeprediction[index], 15.0),
                                // );
                              },
                              location:
                                  "${obj.placeprediction[index].description}",
                            );
                          },
                        ),
                      ),
                      CButton(
                        fontsize: 16,
                        text:
                            "${LocaleKeys.location_view_items_continue_button.tr} ${controller.total.value} AED",
                        shadow: true,
                        borderradius: widht * 0.075,
                        fontWeight: bold6,
                        ontab: () {
                          if (obj.addressController.text.isNotEmpty) {
                            if (StaticData.refreshToken.isNotEmpty) {
                              _onButtonPress(context, obj.addressController);
                            } else {
                              showsnackbar("please login then booking", true);
                              Get.to(() => EmailLoginView(
                                    role: "buyer",
                                  ));
                            }
                          } else {
                            showsnackbar("please add a address", true);
                          }
                        },
                      )
                    ],
                  ),
                ),
              ));
        });
  }

  _onButtonPress(BuildContext context, TextEditingController address) async {
    // PaymetController.to.makePayment(context, "100000");

    PostBookingModel model = PostBookingModel(
        price: controller.total.toString(),
        startAt: controller.stardatetime,
        endAt: controller.enddatetime,
        address: address.text.toString(),
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
