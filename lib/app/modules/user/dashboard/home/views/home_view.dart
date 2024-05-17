// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/model/category_name_model.dart';
import 'package:home_brigadier/model/icon_model.dart';
import 'package:home_brigadier/model/service_model.dart';
import 'package:home_brigadier/services/apis/api_endpoints.dart';
import 'package:home_brigadier/utils/logger.dart';
import 'package:home_brigadier/utils/style.dart';
import 'package:home_brigadier/widget/cText.dart';
import 'package:home_brigadier/widget/shimmer.dart';
import 'package:marquee/marquee.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../../widget/c_text_field.dart';
import '../../../../../routes/app_pages.dart';
import '../all_services/selected_category/category_item/house_cleaning/controllers/booking_controller.dart';
import '../all_services/selected_category/category_item/views/category_item_view.dart';
import '../all_services/selected_category/views/selected_category_view.dart';
import '../controllers/home_controller.dart';
import 'location_pick.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BookingController());

    getService(context);

    return GetBuilder<HomeController>(initState: (state) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
    }, builder: (obj) {
      return Platform.isAndroid
          ? PopScope(
              canPop: false,
              onPopInvoked: (didPop) {
                if (!controller.search.text.isNotEmpty) {
                  controller.setshoeserch('');
                  controller.onsearchtab = false;
                  FocusScope.of(context).unfocus();
                }
                if (controller.search.text.isNotEmpty) {
                  controller.search.clear();
                  controller.setshoeserch('');
                  controller.onsearchtab = false;
                  FocusScope.of(context).unfocus();
                  return;
                } else if (controller.search.text.isEmpty) {
                  if (!didPop) {
                    controller.showBackDialog(context);
                  }
                }
              },
              child: body(context))
          : GestureDetector(
              onHorizontalDragEnd: (details) async {
                if (details.primaryVelocity! > 0) {
                  if (controller.search.text.isNotEmpty) {
                    controller.search.clear();
                    controller.setshoeserch('');

                    return;
                  } else if (controller.search.text.isEmpty) {
                    controller.showBackDialog(context);
                  }
                }
              },
              child: body(context),
            );
    });
  }

  Widget body(context) {
    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Padding(
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 16),
              child: SizedBox(
                width: widht,
                height: height * 0.08,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Obx(() => SizedBox(
                            height: height * 0.055,
                            child: CTextField(
                                onTap: () {
                                  if (!controller.onsearchtab) {
                                    controller.onsearchtab = true;
                                    controller.update();
                                  }
                                },
                                dense: true,
                                onChanged: (val) {
                                  controller.setshoeserch(val);
                                },
                                prefexIcon: Icons.search_rounded,
                                filled: false,
                                contentPadding: 8,
                                hint:
                                    "${LocaleKeys.search_search_for.tr}: ${controller.currentCharacter.value}",
                                controller: controller.search,
                                borderColor: AppColor.greylight,
                                borderRadius: 10),
                          )),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        !controller.onsearchtab
                            ? Padding(
                                padding: EdgeInsets.only(left: 8, top: 10),
                                child: GetBuilder<BookingController>(
                                    id: "address",
                                    builder: (booking) {
                                      GetStorage storage = GetStorage();
                                      final address = storage.read("address") ??
                                          booking.currentAddress.value;
                                      logger.d("updated address is $address");
                                      return SizedBox(
                                        width: 60,
                                        child: Marquee(
                                          text: address,
                                          style: TextStyle(fontSize: 16.0),
                                          // Customize the font size as needed
                                          scrollAxis: Axis.horizontal,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          blankSpace: 20.0,
                                          // Adjust the blank space between repetitions
                                          velocity:
                                              25.0, // Adjust the scrolling speed
                                        ),
                                      );
                                    }),
                              )
                            : SizedBox(),
                        CoustomShowcaseWidget(
                          controller.keyOne,
                          'Location',
                          'you location change from here',
                          InkWell(
                            onTap: () {
                              Get.to(() => const SearchLocationScreen());
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(
                                size: 30,
                                Icons.location_on,
                                color: AppColor.primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: GetBuilder<HomeController>(builder: (obj) {
            if (controller.showserch) {
              return _searchint(context);
            } else {
              return RefreshIndicator(
                color: AppColor.primary,
                onRefresh: () async {
                  await obj.getCategories();
                  await obj.getCategories();
                  await obj.getOffers();
                },
                child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: widht * 0.05,
                        right: widht * 0.05,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomRow(
                            title:
                                LocaleKeys.home_screen_items_special_offer.tr,
                            end: LocaleKeys.home_screen_items_see_all.tr,
                            ontap: () {
                              Get.toNamed(Routes.SPECIAL_OFFERS);
                            },
                            keyg: controller.keyTwo,
                            ntitle: 'Special offers',
                            ndesc: 'Click here and see all special offers',
                          ),
                          SizedBox(
                            height: height * 0.015,
                          ),
                          SizedBox(
                            height: height * 0.175,
                            width: widht,
                            child: FutureBuilder(
                              future: controller.getOffers(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return ShimmerWidget.rectangular(
                                      height: height * 0.175);
                                } else if (snapshot.hasError) {
                                  return Center(child: Text('No offers found'));
                                } else {
                                  return Container(
                                    width: widht,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: controller.offerlist.isEmpty
                                        ? ShimmerWidget.rectangular(
                                            height: height * 0.175)
                                        : CarouselSlider(
                                            options: CarouselOptions(
                                              enlargeCenterPage: true,
                                              autoPlay: true,
                                              autoPlayInterval:
                                                  const Duration(seconds: 3),
                                              autoPlayAnimationDuration:
                                                  const Duration(
                                                      milliseconds: 800),
                                              autoPlayCurve:
                                                  Curves.fastOutSlowIn,
                                            ),
                                            items: controller.offerlist
                                                .map((offer) {
                                              return Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: CachedNetworkImage(
                                                      height: height * 0.175,
                                                      width: widht,
                                                      fit: BoxFit.fitWidth,
                                                      imageUrl:
                                                          "${ApiEndpoints.IMGBASE}${offer.image}",
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: AppColor.black
                                                          .withOpacity(0.3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                  CText(
                                                    color: AppColor.white,
                                                    textAlign: TextAlign.center,
                                                    fontWeight: FontWeight.bold,
                                                    text:
                                                        "${offer.heading}\n${offer.description}",
                                                  )
                                                ],
                                              );
                                            }).toList(),
                                          ),
                                  );
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: height * 0.015,
                          ),
                          CustomRow(
                            ntitle: 'All Services',
                            ndesc: 'Click here and see  all servies',
                            keyg: controller.keyThree,
                            title: LocaleKeys.home_screen_items_services.tr,
                            end: LocaleKeys.home_screen_items_see_all.tr,
                            ontap: () {
                              Get.toNamed(Routes.ALL_SERVICES);
                            },
                          ),
                          SizedBox(
                            height: height * 0.025,
                          ),
                          SizedBox(
                            width: widht,
                            height: height * 0.24,
                            child: ServiceGridTile(widht, height),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Divider(
                            thickness: 1,
                            color: AppColor.greylight,
                          ),
                          SizedBox(
                            height: height * 0.015,
                          ),
                          CustomRow(
                              ntitle: 'Popular Servies',
                              ndesc: 'Click here and see all popular services',
                              keyg: controller.keyFour,
                              ontap: () {
                                Get.toNamed(Routes.POPULAR_SERVICES);
                              },
                              title: LocaleKeys
                                  .home_screen_items_most_popular_services.tr,
                              end: LocaleKeys.home_screen_items_see_all.tr),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          const CategoriesTabbar(),
                        ],
                      ),
                    )),
              );
            }
          })),
    );
  }

  // ignore: non_constant_identifier_names
  ServiceGridTile(double widht, double height) {
    return FutureBuilder(
      future: controller.getCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 8,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: widht * 0.01,
              mainAxisSpacing: height * 0.01,
              mainAxisExtent: height * 0.115,
              crossAxisCount: 4,
            ),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ShimmerWidget.rectangular(
                      width: widht * 0.19, height: widht * 0.20),
                ],
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('No services found'));
        } else {
          final List<CetegoryModel> categoryList = controller.categorylist;
          categoryList.sort((a, b) => a.code!.compareTo(b.code!));

          if (categoryList.isNotEmpty) {
            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 8,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: widht * 0.005,
                mainAxisSpacing: height * 0.005,
                mainAxisExtent: height * 0.115,
                crossAxisCount: 4,
              ),
              itemBuilder: (context, index) {
                final model = categoryList[index];
                int icon = ServiceIconModel.servicesicon
                    .indexWhere((icon) => icon.title == model.displayName);

                return InkWell(
                  onTap: () {
                    Get.to(() => SelectedCategoryView(
                          model: model,
                        ));
                  },
                  child: Column(
                    children: [
                      Container(
                        width: widht * 0.19,
                        height: widht * 0.2,
                        decoration: BoxDecoration(
                            color: AppColor.greylight.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(
                              ServiceIconModel.servicesicon[icon].icon!,
                              color: AppColor.primary,
                              fit: BoxFit.fill,
                              width: index == 5 ? 25 : 30,
                              height: index == 5 ? 25 : 30,
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              categoryList[index].displayName.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: widht * 0.03,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 8,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: widht * 0.01,
                mainAxisSpacing: height * 0.02,
                mainAxisExtent: height * 0.150,
                crossAxisCount: 4,
              ),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ShimmerWidget.circular(
                        width: widht * 0.19, height: widht * 0.21),
                  ],
                );
              },
            );
          }
        }
      },
    );
  }

  Widget _searchint(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

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

    return Padding(
      padding: EdgeInsets.only(
        left: widht * 0.05,
        right: widht * 0.05,
      ),
      child: SizedBox(
        width: widht,
        height: height,
        child: FutureBuilder(
          future: HomeController.to.getServices("All"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ListView(
                children: List.generate(
                    10,
                    (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              ShimmerWidget.rectangular(height: height * 0.175),
                        )),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final List<ServicesModel> servicelist =
                  HomeController.to.servicelist;

              List<ServicesModel> filteredList = servicelist
                  .where((service) =>
                      service.name!
                          .toLowerCase()
                          .contains(controller.search.text.toLowerCase()) ||
                      service.category!.displayName!
                          .toLowerCase()
                          .contains(controller.search.text.toLowerCase()))
                  .toList();

              return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: filteredList.isEmpty ? 1 : filteredList.length,
                  itemBuilder: (context, index) {
                    if (filteredList.isNotEmpty) {
                      final model = filteredList[index];

                      String emplocation = model.location!;
                      List emp = extractCoordinates(emplocation);

                      double startLatitude = location.latitude;
                      double startLongitude = location.longitude;
                      double endLatitude = emp[0];
                      double endLongitude = emp[1];

                      double distanceInMeters = Geolocator.distanceBetween(
                          startLatitude,
                          startLongitude,
                          endLatitude,
                          endLongitude);

                      var km = distanceInMeters / 1000;

                      return InkWell(
                          onTap: () {
                            logger.d("!!!!!!!!!!!!!!!");
                            controller.setshoeserch("");
                            controller.search.clear();
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
                                  width: widht,
                                  height: height * 0.16,
                                  child: Padding(
                                      padding: const EdgeInsets.only(),
                                      child: Row(children: [
                                        Expanded(
                                          flex: 3,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                bottomLeft:
                                                    Radius.circular(12)),
                                            child: SizedBox(
                                              width: widht * 0.3,
                                              height: height,
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl:
                                                    "${ApiEndpoints.IMGBASE}${model.files![0].file}",
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: widht * 0.02),
                                        Expanded(
                                            flex: 6,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: height * 0.01),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
// <<<<<<< usman
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        CText(
                                                            text:
                                                                "${model.name}",
                                                            color:
                                                                AppColor.black,
                                                            fontsize: 19,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: widht *
                                                                      0.02),
                                                          child: Icon(
                                                              Icons.more_horiz),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.0075,
                                                    ),
                                                    Container(
                                                      // height: height * 0.04,
                                                      // width: widht * 0.26,
                                                      decoration: BoxDecoration(
                                                          color: AppColor.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(7),
                                                          border: Border.all(
                                                              color: AppColor
                                                                  .secondary)),
                                                      child: FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Center(
                                                            child: Text(
                                                              "${model.category!.displayName}",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: AppColor
                                                                      .secondary,
                                                                  fontSize: 13),
                                                            ),
                                                          ),
                                                          // =======
                                                          //                                                     CText(
                                                          //                                                         text: "${model.name}",
                                                          //                                                         color: AppColor.black,
                                                          //                                                         fontsize: 19,
                                                          //                                                         fontWeight: FontWeight.bold),
                                                          //                                                     Padding(
                                                          //                                                       padding: EdgeInsets.only(right: widht * 0.02),
                                                          //                                                       child: Icon(Icons.more_horiz),
                                                          //                                                     )
                                                          //                                                   ],
                                                          //                                                 ),
                                                          //                                                 SizedBox(
                                                          //                                                   height: height * 0.0075,
                                                          //                                                 ),
                                                          //                                                 Container(
                                                          //                                                   // height: height * 0.04,
                                                          //                                                   // width: widht * 0.26,
                                                          //                                                   decoration: BoxDecoration(
                                                          //                                                       color: AppColor.white,
                                                          //                                                       borderRadius: BorderRadius.circular(7),
                                                          //                                                       border: Border.all(color: AppColor.secondary)),
                                                          //                                                   child: FittedBox(
                                                          //                                                     fit: BoxFit.contain,
                                                          //                                                     child: Padding(
                                                          //                                                       padding: const EdgeInsets.all(4.0),
                                                          //                                                       child: Center(
                                                          //                                                         child: Text(
                                                          //                                                           "${model.category!.displayName}",
                                                          //                                                           style: TextStyle(
                                                          //                                                               fontWeight: FontWeight.normal,
                                                          //                                                               color: AppColor.secondary,
                                                          //                                                               fontSize: 13),
                                                          // >>>>>>> main
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.04,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: widht * 0.02),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        // mainAxisSize: MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              const Icon(
                                                                  size: 14,
                                                                  Icons
                                                                      .location_on_outlined,
                                                                  color: AppColor
                                                                      .black),
                                                              Text(
                                                                "${km.toInt()} ${LocaleKeys.km_away.tr}",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontSize:
                                                                        14),
                                                              )
                                                            ],
                                                          ),
                                                          Text(
                                                            "AED${model.rate}",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: AppColor
                                                                    .secondary,
                                                                fontSize: 14),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ]),
                                            ))
                                      ])))));
                    } else {
                      return SizedBox(
                        width: widht,
                        height: height,
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * 0.25,
                            ),
                            Image.asset(
                              "assets/images/no-results.png",
                              width: widht * 0.4,
                              height: height * 0.175,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CText(
                              text: "No Results Found",
                              color: AppColor.primary,
                              fontsize: widht * 0.045,
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  separatorBuilder: (context, index) => SizedBox(
                        height: height * 0.01,
                      ));
            }
          },
        ),
      ),
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

  getService(BuildContext context) async {
    GetStorage storage = GetStorage();
    bool showcaseSeen = storage.read("showcase_seen") ?? false;
    if (!showcaseSeen) {
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => ShowCaseWidget.of(context).startShowCase([
                controller.keyOne,
                controller.keyTwo,
                controller.keyThree,
                controller.keyFour,
              ]));
    }
    storage.write("showcase_seen", true);
  }
}

class CategoriesTabbar extends StatelessWidget {
  const CategoriesTabbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: HomeController.to.getCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            children: [
              SizedBox(
                width: widht,
                height: height * 0.0375,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Container(
                          width: widht,
                          height: height,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.grey.withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Container(
                          width: widht,
                          height: height,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            color: Colors.grey.withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Container(
                          width: widht,
                          height: height,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            color: Colors.grey.withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Container(
                          width: widht,
                          height: height,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            color: Colors.grey.withOpacity(0.2),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                  width: widht,
                  height: height,
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: AppColor.grey.withOpacity(0.2)),
                          width: widht,
                          height: height * 0.165,
                        ),
                      );
                    },
                  ))
            ],
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: CText(text: "No services found"),
          );
        } else {
          final List<CetegoryModel> categoryList =
              HomeController.to.categorylist;

          List<Tab> tabs1 = [const Tab(text: "All")];

          tabs1
              .addAll(categoryList.map((category) => Tab(text: category.code)));
          logger.d("list length ${tabs1.length}");

          List<Tab> tabs = [const Tab(text: "All")];

          tabs.addAll(
              categoryList.map((category) => Tab(text: category.displayName)));
          // tabs.sort((a, b) {
          //   if (a.text == "All") {
          //     return -1; // "All" should come before any other tab
          //   } else if (b.text == "All") {
          //     return 1; // "All" should come before any other tab
          //   } else {
          //     return a.text!.compareTo(b.text!); // Sort other tabs alphabetically
          //   }
          // });

          logger.d("list length ${tabs.length}");

          return DefaultTabController(
              length: tabs.length,
              initialIndex: HomeController.to.initialindex.value,
              animationDuration: const Duration(milliseconds: 3),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: widht,
                    height: height * 0.04,
                    child: ButtonsTabBar(
                      onTap: (v) {
                        logger.d("tab on ${tabs[v].text} ");
                        HomeController.to.changeinitialIndex(v);
                      },
                      radius: 35,
                      buttonMargin: const EdgeInsets.symmetric(horizontal: 8),
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
                  Obx(
                    () => TabBarGrid(
                        name:
                            "${tabs1[HomeController.to.initialindex.value].text}"),
                  )
                ],
              ));
        }
      },
    );
  }
}

class TabBarGrid extends StatelessWidget {
  final String name;

  const TabBarGrid({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
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
    HomeController.to.getServices(name);

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return FutureBuilder(
      future: HomeController.to.getServices(name),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            children: List.generate(
              5,
              (index) => Padding(
                padding: const EdgeInsets.all(12),
                child: ShimmerWidget.rectangular(height: height * 0.165),
              ),
            ),
          ); // Show loading indicator
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final List<ServicesModel> serviceList = HomeController.to.servicelist;
          // print(jsonEncode("service list ${jsonEncode(serviceList)}"));

          return ListView.separated(
// <<<<<<< usman
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: serviceList.isEmpty ? 10 : serviceList.length,
            itemBuilder: (context, index) {
              final model = serviceList[index];
// =======
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: servicelist.isEmpty ? 10 : servicelist.length,
//               itemBuilder: (context, index) {
//                 final model = servicelist[index];
//                 logger.d("service lost is  ${servicelist[index].location}");
// >>>>>>> main

              String empLocation = model.location ??
                  "0, 0"; // Default to "0, 0" if location is null
              List<double> emp = extractCoordinates(empLocation);

              double startLatitude = location.latitude;
              double startLongitude = location.longitude;
              double endLatitude = emp.isNotEmpty ? emp[0] : 0;
              double endLongitude = emp.isNotEmpty ? emp[1] : 0;

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
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SizedBox(
                    width: width,
                    height: height * 0.16,
                    child: Padding(
                      padding: const EdgeInsets.only(),
                      child: Row(
                        children: [
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
                                        padding: EdgeInsets.only(
                                            right: width * 0.02),
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
                                      border:
                                          Border.all(color: AppColor.secondary),
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
                                              fontSize: 15,
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
                                    padding:
                                        EdgeInsets.only(right: width * 0.02),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
// <<<<<<< usman
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
              height: height * 0.01,
            ),
          );
// =======
//                                         SizedBox(
//                                           height: height * 0.04,
//                                         ),
//                                         Padding(
//                                           padding: EdgeInsets.only(right: widht * 0.02),
//                                           child: Row(
//                                             crossAxisAlignment: CrossAxisAlignment.center,
//                                             // mainAxisSize: MainAxisSize.max,
//                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Row(
//                                                 children: [
//                                                   const Icon(
//                                                       size: 14, Icons.location_on_outlined, color: AppColor.black),
//                                                   Text(
//                                                     "${km.toInt()} ${LocaleKeys.km_away.tr}",
//                                                     style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
//                                                   )
//                                                 ],
//                                               ),
//                                               Text(
//                                                 "AED${model.rate}",
//                                                 style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     color: AppColor.secondary,
//                                                     fontSize: 14),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ]),
//                                     ))
//                               ])))),
//                 );
//               },
//               separatorBuilder: (context, index) => SizedBox(
//                     height: height * 0.01,
//                   ));
// >>>>>>> main
        }
      },
    );

    // return FutureBuilder(
    //   future: HomeController.to.getServices(name),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Column(
    //         children: List.generate(
    //             5,
    //             (index) => Padding(
    //                   padding: const EdgeInsets.all(12),
    //                   child: ShimmerWidget.rectangular(height: height * 0.165),
    //                 )),
    //       ); // Show loading indicator
    //     } else if (snapshot.hasError) {
    //       return Text('Error: ${snapshot.error}');
    //     } else {
    //       final List<ServicesModel> servicelist = HomeController.to.servicelist;
    //
    //       return ListView.separated(
    //           shrinkWrap: true,
    //           physics: const NeverScrollableScrollPhysics(),
    //           itemCount: servicelist.isEmpty ? 10 : servicelist.length,
    //           itemBuilder: (context, index) {
    //             final model = servicelist[index];
    //
    //             String emplocation = model.location!;
    //             List emp = extractCoordinates(emplocation);
    //
    //             double startLatitude = location.latitude;
    //             double startLongitude = location.longitude;
    //             double endLatitude = emp[0];
    //             double endLongitude = emp[1];
    //
    //             double distanceInMeters = Geolocator.distanceBetween(
    //                 startLatitude, startLongitude, endLatitude, endLongitude);
    //
    //             var km = distanceInMeters / 1000;
    //
    //             return InkWell(
    //               onTap: () {
    //                 Get.to(() => CategoryItemView(
    //                       model: model,
    //                     ));
    //               },
    //               child: Card(
    //                   elevation: 1.5,
    //                   shadowColor: AppColor.white,
    //                   color: AppColor.white,
    //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    //                   child: SizedBox(
    //                       width: widht,
    //                       height: height * 0.16,
    //                       child: Padding(
    //                           padding: const EdgeInsets.only(),
    //                           child: Row(children: [
    //                             Expanded(
    //                               flex: 3,
    //                               child: ClipRRect(
    //                                 borderRadius: BorderRadius.only(
    //                                     topLeft: Radius.circular(12),
    //                                     bottomLeft: Radius.circular(12)),
    //                                 child: SizedBox(
    //                                   width: widht * 0.3,
    //                                   height: height,
    //                                   child: CachedNetworkImage(
    //                                     fit: BoxFit.cover,
    //                                     imageUrl:
    //                                         "https://homebrigadier.fly.dev${model.files![0].file}",
    //                                   ),
    //                                 ),
    //                               ),
    //                             ),
    //                             SizedBox(
    //                               width: widht * 0.02,
    //                             ),
    //                             Expanded(
    //                                 flex: 6,
    //                                 child: Padding(
    //                                   padding: EdgeInsets.only(top: height * 0.01),
    //                                   child: Column(
    //                                       crossAxisAlignment: CrossAxisAlignment.start,
    //                                       children: [
    //                                         Row(
    //                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                                           children: [
    //                                             Padding(
    //                                               padding: const EdgeInsets.all(4.0),
    //                                               child: CText(
    //                                                   text: "${model.name}",
    //                                                   color: AppColor.black,
    //                                                   fontsize: 16,
    //                                                   fontWeight: FontWeight.bold),
    //                                             ),
    //                                             Padding(
    //                                               padding: EdgeInsets.only(right: widht * 0.02),
    //                                               child: Icon(Icons.more_horiz),
    //                                             )
    //                                           ],
    //                                         ),
    //                                         SizedBox(
    //                                           height: height * 0.0075,
    //                                         ),
    //                                         Container(
    //                                           // height: height * 0.04,
    //                                           // width: widht * 0.26,
    //                                           decoration: BoxDecoration(
    //                                               color: AppColor.white,
    //                                               borderRadius: BorderRadius.circular(7),
    //                                               border: Border.all(color: AppColor.secondary)),
    //                                           child: FittedBox(
    //                                             fit: BoxFit
    //                                                 .contain, // Adjusts the child's size to fit the parent's constraints
    //
    //                                             child: Padding(
    //                                               padding: const EdgeInsets.all(4.0),
    //                                               child: Center(
    //                                                 child: Text(
    //                                                   "${model.category!.displayName}",
    //                                                   style: TextStyle(
    //                                                       fontWeight: FontWeight.normal,
    //                                                       color: AppColor.secondary,
    //                                                       fontSize: 15),
    //                                                 ),
    //                                               ),
    //                                             ),
    //                                           ),
    //                                         ),
    //                                         SizedBox(
    //                                           height: height * 0.04,
    //                                         ),
    //                                         Padding(
    //                                           padding: EdgeInsets.only(right: widht * 0.02),
    //                                           child: Row(
    //                                             crossAxisAlignment: CrossAxisAlignment.center,
    //                                             // mainAxisSize: MainAxisSize.max,
    //                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                                             children: [
    //                                               Row(
    //                                                 children: [
    //                                                   const Icon(
    //                                                       size: 14,
    //                                                       Icons.location_on_outlined,
    //                                                       color: AppColor.black),
    //                                                   Text(
    //                                                     "${km.toInt()} ${LocaleKeys.km_away.tr}",
    //                                                     style: TextStyle(
    //                                                         fontWeight: FontWeight.normal,
    //                                                         fontSize: 14),
    //                                                   )
    //                                                 ],
    //                                               ),
    //                                               Text(
    //                                                 "AED${model.rate}",
    //                                                 style: TextStyle(
    //                                                     fontWeight: FontWeight.bold,
    //                                                     color: AppColor.secondary,
    //                                                     fontSize: 14),
    //                                               ),
    //                                             ],
    //                                           ),
    //                                         ),
    //                                       ]),
    //                                 ))
    //                           ])))),
    //             );
    //           },
    //           separatorBuilder: (context, index) => SizedBox(
    //                 height: height * 0.01,
    //               ));
    //     }
    //   },
    // );
  }

  List<double> extractCoordinates(String coordinates) {
    List<String> coordinateList = coordinates.split(',');

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
}

class CustomRow extends StatelessWidget {
  final String title;
  final String ntitle;
  final String ndesc;
  final String end;
  final Function()? ontap;
  final GlobalKey<State<StatefulWidget>> keyg;

  const CustomRow({
    super.key,
    required this.title,
    required this.end,
    this.ontap,
    required this.keyg,
    required this.ntitle,
    required this.ndesc,
  });

  @override
  Widget build(BuildContext context) {
    // final widht = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: bold6, fontSize: size18),
        ),
        CoustomShowcaseWidget(
          keyg,
          ntitle,
          ndesc,
          InkWell(
              onTap: ontap, // Use the provided onTap property
              child: Text(
                end,
                style: TextStyle(
                    fontWeight: bold6,
                    fontSize: size16,
                    color: AppColor.primary),
              )),
        ),
      ],
    );
  }
}

class ServiceModel {
  final String? title;
  final String? icon;
  ServiceModel(this.title, this.icon);

  static List<ServiceModel> serviceList = [
    ServiceModel("Cleaning", "assets/icons/ic_cleaning.svg"),
    ServiceModel("Repairing", "assets/icons/ic_repairing_filled.svg"),
    ServiceModel("Painting", "assets/icons/ic_painting_filled.svg"),
    ServiceModel("Laundry", "assets/icons/ic_laundry_filled.svg"),
    ServiceModel("Appliance", "assets/icons/ic_appliance_filled.svg"),
    ServiceModel("Plumbing", "assets/icons/ic_plumbing_filled.svg"),
    ServiceModel("Shifting", "assets/icons/ic_shifting_filled.svg"),
    ServiceModel("More", "assets/icons/ic_more_filled.svg"),
  ];

  static List<ServiceModel> allServices = [
    ServiceModel("Cleaning", "assets/icons/ic_cleaning.svg"),
    ServiceModel("Repairing", "assets/icons/ic_repairing_filled.svg"),
    ServiceModel("Painting", "assets/icons/ic_painting_filled.svg"),
    ServiceModel("Laundry", "assets/icons/ic_laundry_filled.svg"),
    ServiceModel("Appliance", "assets/icons/ic_appliance_filled.svg"),
    ServiceModel("Plumbing", "assets/icons/ic_plumbing_filled.svg"),
    // ServiceModel("Shifting", "assets/icons/ic_shifting_filled.svg"),
  ];
}

class CoustomShowcaseWidget extends StatelessWidget {
  final Widget child;
  final String title;
  final String description;
  final GlobalKey globalkey;

  const CoustomShowcaseWidget(
      this.globalkey, this.title, this.description, this.child,
      {super.key});

  @override
  Widget build(BuildContext context) => Showcase(
        key: globalkey,
        tooltipPadding: EdgeInsets.all(10),
        title: title,
        titleTextStyle: TextStyle(
            fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
        description: description,
        descTextStyle: TextStyle(fontSize: 12, color: Colors.black),
        overlayColor: Colors.grey,
        overlayOpacity: 0.7,
        child: child,
      );
}
