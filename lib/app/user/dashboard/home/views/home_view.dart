// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/house_cleaning/controllers/booking_controller.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/views/category_item_view.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/views/selected_category_view.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/model/category_name_model.dart';
import 'package:home_brigadier/model/icon_model.dart';
import 'package:home_brigadier/model/service_model.dart';
import 'package:home_brigadier/utils/logger.dart';
import 'package:home_brigadier/utils/style.dart';
import 'package:home_brigadier/widget/cText.dart';
import 'package:home_brigadier/widget/shimmer.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../../widget/c_text_field.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';
import 'location_pick.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    Get.put(BookingController());

    return GetBuilder<HomeController>(builder: (obj) {
      return Platform.isAndroid
          ? PopScope(
              canPop: false,
              onPopInvoked: (didPop) {
                if (controller.search.text.isNotEmpty) {
                  controller.search.clear();
                  controller.setshoeserch('');
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
              padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 16),
              child: SizedBox(
                width: widht,
                height: height * 0.08,
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(() => SizedBox(
                            height: height * 0.055,
                            child: CTextField(
                                dense: true,
                                onChanged: (val) {
                                  controller.setshoeserch(val);
                                },
                                prefexIcon: Icons.search_rounded,
                                filled: false,
                                contentPadding: 8,
                                hint: "Search for: ${controller.currentCharacter.value}",
                                controller: controller.search,
                                borderColor: AppColor.greylight,
                                borderRadius: 10),
                          )),
                    ),
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
                            title: LocaleKeys.home_screen_items_special_offer.tr,
                            end: LocaleKeys.home_screen_items_see_all.tr,
                            ontap: () {
                              Get.toNamed(Routes.SPECIAL_OFFERS);
                            },
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
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return ShimmerWidget.rectangular(height: height * 0.175);
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  return Container(
                                    width: widht,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: controller.offerlist.isEmpty
                                        ? ShimmerWidget.rectangular(height: height * 0.175)
                                        : CarouselSlider(
                                            options: CarouselOptions(
                                              enlargeCenterPage: true,
                                              autoPlay: true,
                                              autoPlayInterval: const Duration(seconds: 3),
                                              autoPlayAnimationDuration:
                                                  const Duration(milliseconds: 800),
                                              autoPlayCurve: Curves.fastOutSlowIn,
                                            ),
                                            items: controller.offerlist.map((offer) {
                                              return Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                    child: CachedNetworkImage(
                                                      height: height * 0.175,
                                                      width: widht,
                                                      fit: BoxFit.fitWidth,
                                                      imageUrl:
                                                          "https://homebrigadier.fly.dev${offer.image}",
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: AppColor.black.withOpacity(0.3),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                  CText(
                                                    color: AppColor.white,
                                                    textAlign: TextAlign.center,
                                                    fontWeight: FontWeight.bold,
                                                    text: "${offer.heading}\n${offer.description}",
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
                            height: height * 0.23,
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
                              ontap: () {
                                Get.toNamed(Routes.POPULAR_SERVICES);
                              },
                              title: LocaleKeys.home_screen_items_most_popular_services.tr,
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
                  ShimmerWidget.circular(width: widht * 0.15, height: widht * 0.15),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  const ShimmerWidget.rectangular(height: 10)
                ],
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final List<CetegoryModel> categoryList = controller.categorylist;

          if (categoryList.isNotEmpty) {
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
                        width: widht * 0.15,
                        height: widht * 0.15,
                        decoration:
                            BoxDecoration(color: AppColor.greylight, shape: BoxShape.circle),
                        child: Center(
                          child: SvgPicture.asset(
                            ServiceIconModel.servicesicon[icon].icon!,
                            color: AppColor.primary,
                            fit: BoxFit.fill,
                            width: index == 1 ? 30 : 40,
                            height: index == 1 ? 30 : 40,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(
                        categoryList[index].displayName.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: widht * 0.03,
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
                    ShimmerWidget.circular(width: widht * 0.15, height: widht * 0.15),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    const ShimmerWidget.rectangular(height: 10)
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
                          child: ShimmerWidget.rectangular(height: height * 0.175),
                        )),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final List<ServicesModel> servicelist = HomeController.to.servicelist;

              List<ServicesModel> filteredList = servicelist
                  .where((service) => service.category!.displayName!
                      .toLowerCase()
                      .contains(controller.search.text.toLowerCase()))
                  .toList();

              return ListView.builder(
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
                          startLatitude, startLongitude, endLatitude, endLongitude);

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
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: SizedBox(
                                width: widht,
                                height: height * 0.19,
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, right: 12, bottom: 12, top: 12),
                                    child: Row(children: [
                                      Expanded(
                                        flex: 3,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: SizedBox(
                                            width: widht * 0.25,
                                            height: height * 0.155,
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl:
                                                  "https://homebrigadier.fly.dev${model.files![0].file}",
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: widht * 0.03,
                                      ),
                                      Expanded(
                                          flex: 6,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: height * 0.02),
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CText(
                                                      text: "${model.name}",
                                                      color: AppColor.black,
                                                      fontsize: 20,
                                                      fontWeight: FontWeight.bold),
                                                  SizedBox(
                                                    height: height * 0.0065,
                                                  ),
                                                  Text(
                                                    "${model.category!.displayName}",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.normal,
                                                        fontSize: 16),
                                                  ),
                                                  Text(
                                                    "\$${model.rate}",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w600, fontSize: 18),
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisSize: MainAxisSize.max,
                                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      const Icon(Icons.location_on_outlined,
                                                          color: AppColor.secondary),
                                                      SizedBox(
                                                        width: widht * 0.01,
                                                      ),
                                                      Text(
                                                        "${km.toInt()} ${LocaleKeys.km_away.tr}",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.normal,
                                                            fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                ]),
                                          ))
                                    ])))),
                      );
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
                  });
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
            child: CText(text: "Some thing wrong"),
          );
        } else {
          final List<CetegoryModel> categoryList = HomeController.to.categorylist;

          List<Tab> tabs1 = [const Tab(text: "All")];

          tabs1.addAll(categoryList.map((category) => Tab(text: category.code)));
          logger.d("list length ${tabs1.length}");

          List<Tab> tabs = [const Tab(text: "All")];

          tabs.addAll(categoryList.map((category) => Tab(text: category.displayName)));
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
                      contentPadding: const EdgeInsets.only(left: 18, right: 18, top: 0, bottom: 0),
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
                    () => TabBarGrid(name: "${tabs1[HomeController.to.initialindex.value].text}"),
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

    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return FutureBuilder(
      future: HomeController.to.getServices(name),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            children: List.generate(
                10,
                (index) => Padding(
                      padding: const EdgeInsets.all(12),
                      child: ShimmerWidget.rectangular(height: height * 0.165),
                    )),
          ); // Show loading indicator
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final List<ServicesModel> servicelist = HomeController.to.servicelist;

          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: servicelist.isEmpty ? 10 : servicelist.length,
              itemBuilder: (context, index) {
                final model = servicelist[index];

                String emplocation = model.location!;
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
                    Get.to(() => CategoryItemView(
                          model: model,
                        ));
                  },
                  child: Card(
                      elevation: 1.5,
                      shadowColor: AppColor.white,
                      color: AppColor.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: SizedBox(
                          width: widht,
                          height: height * 0.19,
                          child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 12),
                              child: Row(children: [
                                Expanded(
                                  flex: 3,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: SizedBox(
                                      width: widht * 0.25,
                                      height: height * 0.155,
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            "https://homebrigadier.fly.dev${model.files![0].file}",
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: widht * 0.03,
                                ),
                                Expanded(
                                    flex: 6,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: height * 0.02),
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CText(
                                                text: "${model.name}",
                                                color: AppColor.black,
                                                fontsize: 20,
                                                fontWeight: FontWeight.bold),
                                            SizedBox(
                                              height: height * 0.0065,
                                            ),
                                            Text(
                                              "${model.category!.displayName}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal, fontSize: 16),
                                            ),
                                            SizedBox(
                                              height: height * 0.015,
                                            ),
                                            Text(
                                              "\$${model.rate}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600, fontSize: 18),
                                            ),
                                            SizedBox(
                                              height: height * 0.015,
                                            ),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Icon(Icons.location_on_outlined,
                                                    color: AppColor.secondary),
                                                SizedBox(
                                                  width: widht * 0.01,
                                                ),
                                                Text(
                                                  "${km.toInt()} ${LocaleKeys.km_away.tr}",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.normal, fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ]),
                                    ))
                              ])))),
                );
              });
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
      } catch (e) {}
    } else {}

    return [];
  }
}

class CustomRow extends StatelessWidget {
  final String title;
  final String end;
  final Function()? ontap;

  const CustomRow({
    super.key,
    required this.title,
    required this.end,
    this.ontap,
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
        InkWell(
            onTap: ontap, // Use the provided onTap property
            child: Text(
              end,
              style: TextStyle(fontWeight: bold6, fontSize: size16, color: AppColor.primary),
            )),
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
