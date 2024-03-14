// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/appliance/views/applince_booking_view.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/house_cleaning/controllers/booking_controller.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/house_cleaning/views/booking_view.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/laundry/views/laundry_booking_view.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/painting/views/painting_booking_view.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/plumbing/views/plumbing_booking_view.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/reparing/views/reparing_booking_view.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/tailor/views/tailor_view.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/generated/locales.g.dart';
import 'package:home_brigadier/model/service_model.dart';
import 'package:home_brigadier/utils/logger.dart';
import 'package:home_brigadier/utils/style.dart';
import 'package:home_brigadier/widget/cText.dart';
import 'package:home_brigadier/widget/c_filled_btn.dart';

import '../controllers/category_item_controller.dart';

// ignore: must_be_immutable
class CategoryItemView extends GetView<CategoryItemController> {
  ServicesModel? model;
  CategoryItemView({super.key, this.model});

  @override
  Widget build(BuildContext context) {
    final con = Get.put(BookingController());
    con.setServicesModel(model!);
    final rate = model!.rate!.split(".");

    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    Get.put(CategoryItemController());
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: Container(
              margin: const EdgeInsets.all(8.0), // Adjust the padding here
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.white.withOpacity(0.75),
              ),
              child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColor.black.withOpacity(0.7), shape: BoxShape.circle),
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColor.white,
                    ),
                  )),
            ),
          ),
          extendBodyBehindAppBar: true,
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
              child: Row(
                children: [
                  Expanded(
                      child: CButton(
                          borderradius: widht * 0.075,
                          ontab: () {
                            logger.d(model!.category!.code);
                            switch (model!.category!.code) {
                              case 'tailor':
                                Get.to(() => TailorView());
                              case 'cleaning':
                                Get.to(() => const HouseCleaningBookingView());
                                break;
                              case 'acRepair':
                                Get.to(() => RepairingBookingView());
                                break;
                              case 'painting':
                                Get.to(() => PaintingBookingView());
                                break;
                              case 'Laundry':
                                Get.to(() => const LaundryBookingView());
                                break;
                              case 'electricity':
                                Get.to(() {
                                  BookingController.to.hours.value = 1;

                                  return ApplianceBookingView(
                                    model: model,
                                  );
                                });
                                break;
                              case 'plumbing':
                                Get.to(() => PlumbingBookingView());
                                break;
                              case 'Shifting':
                                Get.to(() => const HouseCleaningBookingView());
                                break;
                              default:
                                Get.to(() => const HouseCleaningBookingView());
                            }
                          },
                          txtcolor: AppColor.white,
                          fontsize: widht * 0.045,
                          text: LocaleKeys.category_items_catagory_button.tr)),
                ],
              ),
            ),
          ),
          body: GetBuilder<CategoryItemController>(builder: (obj) {
            return PopScope(
              canPop: true,
              onPopInvoked: (val) {
                BookingController.to.hours.value = 0;
              },
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: LayoutBuilder(builder: (context, constraints) {
                    return SizedBox(
                      width: widht,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: widht,
                                height: height * 0.55,
                                child: ImageSlider(
                                  model: model,
                                  obj: obj,
                                )),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: widht * 0.05, vertical: widht * 0.05),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CText(
                                        text: model!.category!.displayName.toString(),
                                        fontsize: 29,
                                        fontWeight: bold6,
                                      ),
                                      SvgPicture.asset(
                                        "assets/icons/ic_bookmark_outlined.svg",
                                        color: AppColor.primary,
                                        width: 18,
                                        height: 24,
                                        fit: BoxFit.cover,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CText(
                                        text: model!.name.toString(),
                                        fontsize: 18,
                                        fontWeight: bold6,
                                        color: AppColor.primary,
                                      ),
                                      SizedBox(
                                        width: widht * 0.01,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // CText(
                                      //   text: model!.category!.displayName
                                      //       .toString(),
                                      //   color: AppColor.primary,
                                      //   fontsize: 12,
                                      //   fontWeight: bold4,
                                      // ),
                                      // SizedBox(
                                      //   width: widht * 0.03,
                                      // ),
                                      SvgPicture.asset(
                                        "assets/icons/ic_location_pin_filled.svg",
                                        color: AppColor.primary,
                                        width: 12,
                                        height: 12,
                                      ),
                                      SizedBox(
                                        width: widht * 0.01,
                                      ),
                                      CText(
                                        text: _getaddress(model!.address.toString()),
                                        fontsize: 12,
                                        fontWeight: bold4,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CText(
                                        text: "AED ${rate[0]}",
                                        color: AppColor.primary,
                                        fontsize: 29,
                                        fontWeight: bold6,
                                      ),
                                      SizedBox(
                                        width: widht * 0.01,
                                      ),
                                      CText(
                                        text: "(${LocaleKeys.category_items_floor_price.tr})",
                                        fontsize: 12,
                                        fontWeight: bold4,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CText(
                                          text: LocaleKeys.category_items_about_me.tr,
                                          fontsize: 18,
                                          fontWeight: bold6,
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const ExpandableText(
                                    "",
                                    expandText: 'Read more',
                                    collapseText: 'Read less',
                                  ),
                                  ExpandableText(
                                    "${model!.description}",
                                    expandText: 'Read more',
                                    collapseText: 'Read less',
                                    maxLines: 3,
                                    linkColor: AppColor.primary,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: height * 0.0125,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: CText(
                                      text: LocaleKeys.category_items_photos_videos.tr,
                                      fontsize: 18,
                                      fontWeight: bold6,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  SizedBox(
                                    width: widht,
                                    height: height * 0.53,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            imageBox(context, model!.files![0].file!),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            imageBox(context, model!.files![0].file!),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            imageBox(context, model!.files![0].file!),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            imageBox(context, model!.files![0].file!),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ]),
                    );
                  })),
            );
          })),
    );
  }

  imageBox(BuildContext context, String path) {
    final height = MediaQuery.of(context).size.height;

    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: SizedBox(
          height: height * 0.25,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: "https://homebrigadier.fly.dev$path",
          ),
        ),
      ),
    );
  }

  imageContainer(img) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SvgPicture.asset(
        img,
        fit: BoxFit.cover,
        width: 96,
        height: 96,
      ),
    );
  }

  String _getaddress(String string) {
    if (string.length > 35) {
      return string.substring(0, 35);
    } else {
      return string;
    }
  }
}

class ImageSlider extends StatelessWidget {
  const ImageSlider({
    Key? key,
    required this.model,
    required this.obj,
  }) : super(key: key);

  final ServicesModel? model;
  final CategoryItemController obj;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          controller: PageController(initialPage: obj.initialPage),
          itemCount: obj.totalimg,
          onPageChanged: (val) {
            obj.chgPage(val);
          },
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                      "https://homebrigadier.fly.dev${model!.files![0].file}"),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Your existing image-related content
                ],
              ),
            );
          },
        ),
        Positioned(
          bottom: 0.0,
          left: 10,
          right: 10,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                obj.totalimg,
                (index) => Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: obj.initialPage == index
                          ? AppColor.primary
                          : AppColor.white.withOpacity(0.75),
                      shape: 1 == 2 ? BoxShape.circle : BoxShape.rectangle,
                    ),
                    width: obj.initialPage == index ? 15 : 6,
                    height: 6,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
