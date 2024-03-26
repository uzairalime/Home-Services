import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/house_cleaning/views/pin_view.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/utils/style.dart';
import 'package:home_brigadier/widget/cText.dart';
import 'package:home_brigadier/widget/c_filled_btn.dart';

class ReviewView extends GetView {
  const ReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            "Review Summary",
            style: appbar,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: widht * 0.07,
            right: widht * 0.07,
            bottom: widht * 0.1,
            top: widht * 0.06,
          ),
          child: SingleChildScrollView(
            child: SizedBox(
              width: widht,
              // height: height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                    child: Column(
                      children: [
                        CustomReviewTile(context, "Services", "House Cleaning"),
                        SizedBox(
                          height: height * 0.04,
                        ),
                        CustomReviewTile(context, "Category", "Cleaning"),
                        SizedBox(
                          height: height * 0.04,
                        ),
                        CustomReviewTile(context, "Workers", "Jenny Wilson"),
                        SizedBox(
                          height: height * 0.04,
                        ),
                        CustomReviewTile(context, "Date & Time", "Dec 20, 2022 | 10:00 AM"),
                        SizedBox(
                          height: height * 0.04,
                        ),
                        CustomReviewTile(context, "Working Hours", "2 hours"),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColor.white, borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CText(
                            text: "House Cleaning Details",
                            fontsize: 13,
                            fontWeight: bold4,
                          ),
                          const Icon(Icons.keyboard_arrow_down_outlined, color: AppColor.black)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColor.white, borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                      child: Column(
                        children: [
                          CustomReviewTile(context, "House Cleaning", "125.00"),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CText(
                                text: "Promo",
                                color: const Color(0xff9D5DF9),
                                fontsize: 13,
                                fontWeight: bold4,
                              ),
                              CText(
                                text: "-37.50",
                                fontWeight: bold6,
                                fontsize: 16,
                                color: const Color(0xff9D5DF9),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          CustomReviewTile(context, "Total", "87.50"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColor.white, borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/ic_mastercard.svg",
                            fit: BoxFit.cover,
                            width: 30,
                            height: 20,
                          ),
                          SizedBox(
                            width: widht * 0.02,
                          ),
                          CText(
                            text: ".... .... .... .... 4679",
                            fontWeight: bold6,
                            fontsize: 16,
                          ),
                          const Spacer(),
                          CText(
                            text: "Change",
                            fontWeight: bold6,
                            fontsize: 16,
                            color: const Color(0xff9D5DF9),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  CButton(
                      text: "Confirm Payment",
                      shadow: true,
                      borderradius: widht * 0.075,
                      fontWeight: bold6,
                      fontsize: 14,
                      ontab: () => Get.to(() => const PinView())

                      // ),
                      )
                ],
              ),
            ),
          ),
        ));
  }
}

// ignore: non_constant_identifier_names
Row CustomReviewTile(BuildContext context, String title, String end) {
  // final widht = MediaQuery.of(context).size.width;
  // final height = MediaQuery.of(context).size.height;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CText(
        text: title,
        fontsize: 13,
        fontWeight: bold4,
      ),
      CText(
        text: end,
        fontWeight: bold6,
        fontsize: 14,
      ),
    ],
  );
}
