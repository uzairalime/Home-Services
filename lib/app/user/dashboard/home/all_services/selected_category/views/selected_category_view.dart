// ignore_for_file: non_constant_identifier_names

import 'dart:math' show asin, cos, sqrt;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/appliance/views/applince_booking_view.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/house_cleaning/controllers/booking_controller.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/house_cleaning/views/booking_view.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/laundry/views/laundry_booking_view.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/painting/views/painting_booking_view.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/plumbing/views/plumbing_booking_view.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/reparing/views/reparing_booking_view.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/tailor/views/tailor_view.dart';
import 'package:home_brigadier/app/user/dashboard/home/controllers/home_controller.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/generated/locales.g.dart';
import 'package:home_brigadier/model/service_model.dart';
import 'package:home_brigadier/utils/style.dart';
import 'package:home_brigadier/widget/cText.dart';

import '../../../../../../../model/category_name_model.dart';
import '../category_item/views/category_item_view.dart';
import '../controllers/selected_category_controller.dart';

class SelectedCategoryView extends GetView<SelectedCategoryController> {
  final CetegoryModel? model;

  const SelectedCategoryView({super.key, this.model});

  @override
  Widget build(BuildContext context) {
    HomeController con = Get.find();
    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    con.getServices(model!.code.toString());

    return RefreshIndicator(
      onRefresh: () async {
        await con.getServices(model!.code.toString());
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              model!.displayName.toString(),
              style: appbar,
            ),
          ),
          body: Center(
            child: SizedBox(
              width: widht * 0.95,
              height: height,
              child: FutureBuilder(
                future: con.getServices(model!.code.toString()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Error"));
                  } else if (HomeController.to.servicelist.isEmpty) {
                    return const Center(child: Text("No Service Avaliable"));
                  } else {
                    final List<ServicesModel> servicelist = con.servicelist;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: servicelist.length,
                      itemBuilder: (context, index) {
                        final service_model = servicelist[index];
                        return CategoryItemCard(service_model, context, model!);
                      },
                    );
                  }
                },
              ),
            ),
          )),
    );
  }

  CategoryItemCard(ServicesModel service_model, BuildContext context,
      CetegoryModel categ_model) {
    final titleLarge = Theme.of(context).textTheme.titleLarge!.fontSize;
    final titleSmall = Theme.of(context).textTheme.titleSmall!.fontSize;

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

    String emplocation = service_model.location!;
    List emp = extractCoordinates(emplocation);

    double startLatitude = location.latitude;
    double startLongitude = location.longitude;
    double endLatitude = emp[0];
    double endLongitude = emp[1];

    double distanceInMeters = Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
    var km = distanceInMeters / 1000;

    return InkWell(
      onTap: () {
        Get.to(() => CategoryItemView(model: service_model));
      },
      child: Card(
          shadowColor: AppColor.greylight.withOpacity(.4),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(children: [
            SizedBox(
              width: double.maxFinite,
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(mainAxisSize: MainAxisSize.max, children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:
                              "https://homebrigadier.fly.dev${service_model.files![0].file}",
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                        width: double.maxFinite,
                        height: double.maxFinite,
                        child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${service_model.name} ",
                                  style: TextStyle(
                                      color: AppColor.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: titleSmall)),
                              CText(
                                  text: categ_model.displayName.toString(),
                                  fontsize: titleLarge,
                                  fontWeight: FontWeight.bold),
                              Text("AED ${service_model.rate}/hr",
                                  style: TextStyle(
                                      color: AppColor.primary,
                                      fontWeight: FontWeight.w500,
                                      fontSize: titleSmall)),
                              Row(children: [
                                const Icon(Icons.access_time_outlined),
                                const SizedBox(width: 5),
                                CText(
                                    text:
                                        "${formatTime(service_model.openingHours![0].fromHour.toString())} - ",
                                    fontsize: titleSmall),
                                CText(
                                    text: formatTime(service_model
                                        .openingHours![0].toHour
                                        .toString()),
                                    fontsize: titleSmall)
                              ]),
                              SizedBox(
                                height: 30,
                                child: Center(
                                  child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        // const Icon(Icons.calendar_month,
                                        //     size: 20),
                                        // const SizedBox(width: 5),
                                        for (var i
                                            in service_model.openingHours!)
                                          days(
                                              name: getAbbreviatedWeekday(
                                                  i.weekday!),
                                              size: titleSmall!),
                                      ]),
                                ),
                              ),
                            ])),
                  )
                ]),
              ),
            ),
            SizedBox(
                height: 60,
                width: double.maxFinite,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(children: [
                        const Icon(Icons.pin_drop_outlined,
                            color: AppColor.secondary),
                        const SizedBox(width: 5),
                        CText(
                            text: "${km.toInt()} ${LocaleKeys.km_away.tr}",
                            fontsize: titleSmall),
                      ]),
                      bottomButton(
                          model: service_model,
                          icon: Icons.shopping_cart_outlined,
                          size: titleSmall,
                          txt: LocaleKeys.tailor_items_book_now.tr)
                    ])).paddingSymmetric(horizontal: 10)
          ])),
    );
  }

  List<double> extractCoordinates(String coordinates) {
    List<String> coordinateList = coordinates.split(', ');

    if (coordinateList.length == 2) {
      String latitudeString = coordinateList[0];
      String longitudeString = coordinateList[1];

      try {
        double latitude = double.parse(latitudeString);
        double longitude = double.parse(longitudeString);

        return [latitude, longitude];
      } catch (e) {}
    } else {}

    return [];
  }

  bottomButton(
      {txt, required IconData icon, size, required ServicesModel model}) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: AppColor.greylight),
                borderRadius: BorderRadius.circular(12)),
            elevation: 0,
            backgroundColor: AppColor.white),
        onPressed: () {
          switch (model!.category!.code) {
            case 'tailor':
              BookingController.to.setServicesModel(model);

              Get.to(() => TailorView());
            case 'cleaning':
              BookingController.to.setServicesModel(model);

              Get.to(() => HouseCleaningBookingView());

              break;
            case 'acRepair':
              BookingController.to.setServicesModel(model);

              Get.to(() => RepairingBookingView());

              break;
            case 'painting':
              BookingController.to.setServicesModel(model);

              Get.to(() => PaintingBookingView());

              break;
            case 'Laundry':
              BookingController.to.setServicesModel(model);

              Get.to(() => LaundryBookingView());

              break;
            case 'electricity':
              BookingController.to.setServicesModel(model);

              Get.to(() => ApplianceBookingView(
                    model: model,
                  ));

              break;
            case 'plumbing':
              BookingController.to.setServicesModel(model);

              Get.to(() => PlumbingBookingView());

              break;
            case 'Shifting':
              BookingController.to.setServicesModel(model);

              Get.to(() => HouseCleaningBookingView());

              break;
            default:
              BookingController.to.setServicesModel(model);

              Get.to(() => HouseCleaningBookingView());
          }

          // Get.to(() => CategoryItemView(
          //       model: model,
          //     ));
        },
        child: Row(children: [
          Icon(
            icon,
            color: AppColor.secondary,
          ),
          CText(
            text: txt,
            fontsize: size,
            color: AppColor.secondary,
          )
        ]));
  }

  static double getDistanceFromGPSPointsInRoute(List gpsList) {
    double totalDistance = 0.0;

    for (var i = 0; i < gpsList.length; i++) {
      var p = 0.017453292519943295;
      var c = cos;
      var a = 0.5 -
          c((gpsList[i + 1].latitude - gpsList[i].latitude) * p) / 2 +
          c(gpsList[i].latitude * p) *
              c(gpsList[i + 1].latitude * p) *
              (1 - c((gpsList[i + 1].longitude - gpsList[i].longitude) * p)) /
              2;
      double distance = 12742 * asin(sqrt(a));
      totalDistance += distance;
    }

    return totalDistance;
  }

  String getAbbreviatedWeekday(String fullWeekday) {
    switch (fullWeekday.toLowerCase()) {
      case 'sunday':
        return 'Sun';
      case 'monday':
        return 'Mon';
      case 'tuesday':
        return 'Tue';
      case 'wednesday':
        return 'Wed';
      case 'thursday':
        return 'Thu';
      case 'friday':
        return 'Fri';
      case 'saturday':
        return 'Sat';
      default:
        return '';
    }
  }

  Widget days({required String name, required double size}) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 1, color: AppColor.greylight)),
        child: Center(child: CText(text: name, fontsize: size)));
  }

  String formatTime(String time24Hour) {
    // Split the time string by ":"
    List<String> parts = time24Hour.split(":");

    // Get the hour part
    int hour = int.parse(parts[0]);

    // Determine AM/PM
    String period = hour < 12 ? 'AM' : 'PM';

    // Convert hour to 12-hour format
    if (hour > 12) {
      hour -= 12;
    } else if (hour == 0) {
      hour = 12;
    }

    // Get the minute part
    String minute = parts[1];

    // Return the formatted time
    return '$hour:$minute $period';
  }
}

// ExpansionTile(
//     maintainState: true,
//     iconColor: Colors.transparent,
//     collapsedIconColor: Colors.transparent,
//     initiallyExpanded: true,
//     shape: const RoundedRectangleBorder(),
//     title: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0),
//         child: Row(children: [
//           ClipOval(
//             child: SizedBox(
//               width: widht * 0.15,
//               height: widht * 0.15,
//               child: CachedNetworkImage(
//                 // height: 150,
//                 fit: BoxFit.cover,
//                 imageUrl: "https://homebrigadier.fly.dev${model.files![0].file}",
//                 // placeholder: (context, url) =>
//                 //     CircularProgressIndicator(),
//                 // errorWidget:
//                 //     (context, url, error) =>
//                 //         Icon(Icons.error),
//               ),
//             ),
//           ),
//           Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                 Text("${model.name} ",
//                     style: TextStyle(
//                         color: AppColor.black,
//                         fontWeight: FontWeight.w500,
//                         fontSize: titleLarge)),
//                 const SizedBox(height: 10),
//                 Text("\$ ${model.rate}/hr",
//                     style: TextStyle(
//                         color: AppColor.primary,
//                         fontWeight: FontWeight.w500,
//                         fontSize: titleMedium))
//               ]))
//         ])),
//     children: [
//       Row(children: [
//         const Icon(Icons.access_time_outlined),
//         const SizedBox(width: 5),
//         CText(
//             text: "${formatTime(model.openingHours![0].fromHour.toString())} - ",
//             fontsize: titleMedium),
//         CText(
//             text: formatTime(model.openingHours![0].toHour.toString()),
//             fontsize: titleMedium),
//       ]),
//       const SizedBox(
//         height: 5,
//       ),
//       SizedBox(
//         height: height * 0.0375,
//         child: ListView(scrollDirection: Axis.horizontal, children: [
//           const Icon(Icons.calendar_month),
//           const SizedBox(width: 5),
//           for (var i in model.openingHours!)
//             days(name: getAbbreviatedWeekday(i.weekday!), size: titleMedium!),
//         ]),
//       ),
//       Padding(
//           padding: const EdgeInsets.symmetric(vertical: 15),
//           child: Row(children: [
//             const Icon(Icons.pin_drop_outlined, color: AppColor.secondary),
//             const SizedBox(width: 5),
//             CText(text: "${km.toInt()} km away", fontsize: titleLarge)
//           ])),
//       Row(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             bottomButton(
//                 model: model,
//                 icon: Icons.visibility_outlined,
//                 size: titleLarge,
//                 txt: "View"),
//             bottomButton(
//                 model: model,
//                 icon: Icons.shopping_cart_outlined,
//                 size: titleLarge,
//                 txt: "Book now")
//           ])
//     ])