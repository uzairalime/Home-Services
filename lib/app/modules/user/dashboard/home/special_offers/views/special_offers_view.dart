import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/generated/locales.g.dart';
import 'package:home_brigadier/utils/style.dart';
import 'package:home_brigadier/widget/cText.dart';
import 'package:home_brigadier/widget/shimmer.dart';

import '../../../../../../../services/apis/api_endpoints.dart';
import '../../controllers/home_controller.dart';
import '../controllers/special_offers_controller.dart';

class SpecialOffersView extends GetView<SpecialOffersController> {
  const SpecialOffersView({super.key});

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(
            LocaleKeys.special_offer_items_special_offer.tr,
            style: appbar,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: widht * 0.07,
            right: widht * 0.07,
            top: widht * 0.07,
          ),
          child: SizedBox(
            width: widht,
            height: height,
            child: FutureBuilder(
              future: HomeController.to.getOffers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                          7,
                          (index) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 8),
                                child: ShimmerWidget.rectangular(
                                    height: height * 0.16),
                              )),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: HomeController.to.offerlist.length,
                      itemBuilder: (context, index) {
                        final modde = HomeController.to.offerlist[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Container(
                              width: widht,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: HomeController.to.offerlist.isEmpty
                                  ? ShimmerWidget.rectangular(
                                      height: height * 0.16)
                                  : Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: CachedNetworkImage(
                                            height: 120,
                                            width: widht,
                                            fit: BoxFit.fitWidth,
                                            imageUrl:
                                                "${ApiEndpoints.IMGBASE}${modde.image}",
                                            // placeholder: (context, url) =>
                                            //     CircularProgressIndicator(),
                                            // errorWidget:
                                            //     (context, url, error) =>
                                            //         Icon(Icons.error),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color:
                                                AppColor.black.withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        CText(
                                          color: AppColor.white,
                                          textAlign: TextAlign.center,
                                          fontWeight: FontWeight.w500,
                                          text:
                                              "${modde.heading}\n${modde.description}",
                                        )
                                      ],
                                    )

                              // }).toList(),

                              ),
                        );
                      });

                  //  Container(
                  //   width: widht,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(18),
                  //   ),
                  //   child: HomeController.to.offerlist.isEmpty
                  //       ? const ShimmerWidget.rectangular(
                  //           height: 150) // Show shimmer if offerlist is empty
                  //       : CarouselSlider(
                  //           options: CarouselOptions(
                  //             //height: 150,
                  //             enlargeCenterPage: true,
                  //             autoPlay: true,
                  //             autoPlayInterval: const Duration(seconds: 3),
                  //             autoPlayAnimationDuration:
                  //                 const Duration(milliseconds: 800),
                  //             autoPlayCurve: Curves.fastOutSlowIn,
                  //           ),
                  //           items: HomeController.to.offerlist.map((offer) {
                  //             return Stack(
                  //               alignment: Alignment.center,
                  //               children: [
                  //                 ClipRRect(
                  //                   borderRadius: BorderRadius.circular(8.0),
                  //                   child: CachedNetworkImage(
                  //                     height: 120,
                  //                     width: widht,
                  //                     fit: BoxFit.fitWidth,
                  //                     imageUrl:
                  //                         "https://homebrigadier.fly.dev${offer.image}",
                  //                     // placeholder: (context, url) =>
                  //                     //     CircularProgressIndicator(),
                  //                     // errorWidget:
                  //                     //     (context, url, error) =>
                  //                     //         Icon(Icons.error),
                  //                   ),
                  //                 ),
                  //                 Container(
                  //                   decoration: BoxDecoration(
                  //                     color: AppColor.black.withOpacity(0.3),
                  //                     borderRadius: BorderRadius.circular(8),
                  //                   ),
                  //                 ),
                  //                 CText(
                  //                   color: AppColor.white,
                  //                   textAlign: TextAlign.center,
                  //                   fontWeight: FontWeight.w500,
                  //                   text:
                  //                       "${offer.heading}\n${offer.description}",
                  //                 )
                  //               ],
                  //             );
                  //           }).toList(),
                  //         ),
                  // );
                }
              },
            ),

            // ListView.builder(
            //     physics: const BouncingScrollPhysics(),
            //     itemCount: BoxModel.list.length,
            //     itemBuilder: (context, index) {
            //       return InkWell(
            //         child: Padding(
            //           padding: EdgeInsets.only(bottom: height * 0.03),
            //           child: Container(
            //             width: widht,
            //             height: height * 0.2,
            //             decoration: BoxDecoration(
            //                 gradient: BoxModel.list[index].color,

            //                 // color: AppColor.grey,
            //                 borderRadius: BorderRadius.circular(24)),
            //             child: Center(
            //               child: Text(
            //                 BoxModel.list[index].title.toString(),
            //                 style: TextStyle(
            //                     fontWeight: bold6,
            //                     fontSize: 32,
            //                     color: AppColor.white),
            //               ),
            //             ),
            //           ),
            //         ),
            //       );
            //     }),
          ),
        ));
  }
}

class BoxModel {
  final String? title;
  final Gradient? color;

  BoxModel({required this.title, required this.color});

  static List<BoxModel> list = [
    BoxModel(title: "Bonus Offer", color: AppColor.box1),
    BoxModel(title: "Bonus Offer", color: AppColor.box2),
    BoxModel(title: "Bonus Offer", color: AppColor.box3),
    BoxModel(title: "Bonus Offer", color: AppColor.box4),
  ];
}
