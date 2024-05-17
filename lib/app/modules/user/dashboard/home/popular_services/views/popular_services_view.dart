// ignore_for_file: prefer_const_constructors

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/generated/locales.g.dart';
import 'package:home_brigadier/model/category_name_model.dart';
import 'package:home_brigadier/model/service_model.dart';
import 'package:home_brigadier/utils/style.dart';
import 'package:home_brigadier/widget/cText.dart';

import '../../../../../../../services/apis/api_endpoints.dart';
import '../../all_services/selected_category/category_item/house_cleaning/controllers/booking_controller.dart';
import '../../all_services/selected_category/category_item/views/category_item_view.dart';
import '../../controllers/home_controller.dart';
import '../controllers/popular_services_controller.dart';

class PopularServicesView extends GetView<PopularServicesController> {
  const PopularServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    HomeController.to.getCategories();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Most Popular Services",
            style: appbar,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: widht,
            height: height,
            child: DefaultTabController(
              length: 12, // +1 for the "All" tab
              initialIndex: 0,
              animationDuration: const Duration(milliseconds: 3),
              child: FutureBuilder(
                future: HomeController.to.getCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child:
                            CircularProgressIndicator()); // Show loading indicator
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final List<CetegoryModel> categoryList =
                        HomeController.to.categorylist;

                    // Add the "All" tab
                    List<Tab> tabs = [const Tab(text: "All")];

                    // Add the category tabs
                    tabs.addAll(categoryList
                        .map((category) => Tab(text: category.displayName)));

                    return Column(
                      children: <Widget>[
                        SizedBox(
                          height: height * 0.04,
                          child: ButtonsTabBar(
                            radius: 35,
                            buttonMargin:
                                const EdgeInsets.symmetric(horizontal: 8),
                            contentPadding: const EdgeInsets.only(
                                left: 18, right: 18, top: 0, bottom: 0),
                            backgroundColor: AppColor.primary,
                            borderWidth: 1,
                            borderColor: AppColor.primary,
                            unselectedBackgroundColor: Colors.transparent,
                            unselectedLabelStyle: unselectedtab,
                            unselectedBorderColor: AppColor.primary,
                            labelStyle: selectedtab,
                            tabs: tabs,
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        Expanded(
                          child: TabBarView(
                            children: [
                              // "All" tab content
                              const TabBarGrid(name: "All"),

                              // Category tabs content
                              for (CetegoryModel category in categoryList)
                                TabBarGrid(name: category.code!),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ));
  }
}

class TabBarGrid extends StatelessWidget {
  final String name;

  const TabBarGrid({
    super.key, // Add key parameter
    required this.name,
  }); // Pass key to super constructor

  @override
  Widget build(BuildContext context) {
    final width =
        MediaQuery.of(context).size.width; // Correct typo in variable name
    final height = MediaQuery.of(context).size.height;
    final location = BookingController.to.currentPosition ??
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
          speedAccuracy: 0,
        );
    return FutureBuilder(
      future: HomeController.to.getServices(name),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator()); // Remove const keyword
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final List<ServicesModel> serviceList = HomeController.to.servicelist;

          return ListView.separated(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: serviceList.isEmpty ? 10 : serviceList.length,
            itemBuilder: (context, index) {
              final model = serviceList[index];

              String empLocation = model.location ?? "0, 0"; // Add null check
              List<double> emp = extractCoordinates(empLocation);

              double startLatitude = location.latitude;
              double startLongitude = location.longitude;
              double endLatitude =
                  emp.isNotEmpty ? emp[0] : 0; // Add null check
              double endLongitude =
                  emp.isNotEmpty ? emp[1] : 0; // Add null check

              double distanceInMeters = Geolocator.distanceBetween(
                startLatitude,
                startLongitude,
                endLatitude,
                endLongitude,
              );

              var km = distanceInMeters / 1000;
              return InkWell(
                onTap: () {
                  Get.to(() => CategoryItemView(
                        model: model,
                      ));
                },
                child: Card(
                  elevation: 1.5,
                  shadowColor: AppColor.white,
                  color: AppColor.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: SizedBox(
                    width: width,
                    height: height * 0.16,
                    child: Row(children: [
                      Expanded(
                        flex: 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                          child: SizedBox(
                            width: width * 0.3,
                            height: height,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl:
                                  "${ApiEndpoints.IMGBASE}${model.files![0].file}",
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding: EdgeInsets.only(top: height * 0.01),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CText(
                                    text: "${model.name}",
                                    color: AppColor.black,
                                    fontsize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(right: width * 0.02),
                                    child: Icon(Icons.more_horiz),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: height * 0.0075,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(color: AppColor.secondary),
                                ),
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Center(
                                      child: Text(
                                        "${model.category!.displayName}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: AppColor.secondary,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.04,
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: width * 0.02),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          size: 14,
                                          Icons.location_on_outlined,
                                          color: AppColor.black,
                                        ),
                                        Text(
                                          "${km.toInt()} ${LocaleKeys.km_away.tr}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(
                                      "AED${model.rate}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.secondary,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
              height: height * 0.01,
            ),
          );
        }
      },
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
      } catch (e) {
        print("Error parsing coordinates: $e");
      }
    }

    return [];
  }
}

// class TabBarGrid extends StatelessWidget {
//   final String name;
//
//   const TabBarGrid({
//     super.key,
//     required this.name,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final widht = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     var location = BookingController.to.currentPosition ??
//         Position(
//             longitude: 25.20,
//             latitude: 55.27,
//             timestamp: DateTime.now(),
//             accuracy: 0,
//             altitude: 0,
//             altitudeAccuracy: 0,
//             heading: 0,
//             headingAccuracy: 0,
//             speed: 0,
//             speedAccuracy: 0);
//     return FutureBuilder(
//       future: HomeController.to.getServices(name),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator()); // Show loading indicator
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           final List<ServicesModel> servicelist = HomeController.to.servicelist;
//
//           return ListView.separated(
//               physics: const BouncingScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: servicelist.isEmpty ? 10 : servicelist.length,
//               itemBuilder: (context, index) {
//                 final model = servicelist[index];
//
//                 String emplocation = model.location!;
//                 List emp = extractCoordinates(emplocation);
//
//                 double startLatitude = location.latitude;
//                 double startLongitude = location.longitude;
//                 double endLatitude = emp[0];
//                 double endLongitude = emp[1];
//
//                 double distanceInMeters = Geolocator.distanceBetween(
//                     startLatitude, startLongitude, endLatitude, endLongitude);
//
//                 var km = distanceInMeters / 1000;
//                 return InkWell(
//                     onTap: () {
//                       Get.to(() => CategoryItemView(
//                             model: model,
//                           ));
//                     },
//                     child: Card(
//                         elevation: 1.5,
//                         shadowColor: AppColor.white,
//                         color: AppColor.white,
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                         child: SizedBox(
//                             width: widht,
//                             height: height * 0.16,
//                             child: Row(children: [
//                               Expanded(
//                                 flex: 3,
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(12),
//                                       bottomLeft: Radius.circular(12)),
//                                   child: SizedBox(
//                                     width: widht * 0.3,
//                                     height: height,
//                                     child: CachedNetworkImage(
//                                       fit: BoxFit.cover,
//                                       imageUrl:
//                                           "https://homebrigadier.fly.dev${model.files![0].file}",
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: widht * 0.02,
//                               ),
//                               Expanded(
//                                   flex: 6,
//                                   child: Padding(
//                                     padding: EdgeInsets.only(top: height * 0.01),
//                                     child: Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               CText(
//                                                   text: "${model.name}",
//                                                   color: AppColor.black,
//                                                   fontsize: 16,
//                                                   fontWeight: FontWeight.bold),
//                                               Padding(
//                                                 padding: EdgeInsets.only(right: widht * 0.02),
//                                                 child: Icon(Icons.more_horiz),
//                                               )
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: height * 0.0075,
//                                           ),
//                                           Container(
//                                             // height: height * 0.04,
//                                             // width: widht * 0.26,
//                                             decoration: BoxDecoration(
//                                                 color: AppColor.white,
//                                                 borderRadius: BorderRadius.circular(7),
//                                                 border: Border.all(color: AppColor.secondary)),
//                                             child: FittedBox(
//                                               fit: BoxFit.contain,
//                                               child: Padding(
//                                                 padding: const EdgeInsets.all(4.0),
//                                                 child: Center(
//                                                   child: Text(
//                                                     "${model.category!.displayName}",
//                                                     style: TextStyle(
//                                                         fontWeight: FontWeight.normal,
//                                                         color: AppColor.secondary,
//                                                         fontSize: 18),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             height: height * 0.04,
//                                           ),
//                                           Padding(
//                                             padding: EdgeInsets.only(right: widht * 0.02),
//                                             child: Row(
//                                               crossAxisAlignment: CrossAxisAlignment.center,
//                                               // mainAxisSize: MainAxisSize.max,
//                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                               children: [
//                                                 Row(
//                                                   children: [
//                                                     const Icon(
//                                                         size: 14,
//                                                         Icons.location_on_outlined,
//                                                         color: AppColor.black),
//                                                     Text(
//                                                       "${km.toInt()} ${LocaleKeys.km_away.tr}",
//                                                       style: TextStyle(
//                                                           fontWeight: FontWeight.normal,
//                                                           fontSize: 14),
//                                                     )
//                                                   ],
//                                                 ),
//                                                 Text(
//                                                   "\AED${model.rate}",
//                                                   style: TextStyle(
//                                                       fontWeight: FontWeight.bold,
//                                                       color: AppColor.secondary,
//                                                       fontSize: 14),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ]),
//                                   ))
//                             ]))));
//               },
//               separatorBuilder: (context, index) => SizedBox(
//                     height: height * 0.01,
//                   ));
//         }
//       },
//     );
//   }
//
//   List<double> extractCoordinates(String coordinates) {
//     List<String> coordinateList = coordinates.split(', ');
//
//     if (coordinateList.length == 2) {
//       String latitudeString = coordinateList[0];
//       String longitudeString = coordinateList[1];
//
//       try {
//         double latitude = double.parse(latitudeString);
//         double longitude = double.parse(longitudeString);
//
//         return [latitude, longitude];
//       } catch (e) {}
//     } else {}
//
//     return [];
//   }
// }
