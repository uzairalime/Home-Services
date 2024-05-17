import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/modules/user/dashboard/home/all_services/selected_category/category_item/house_cleaning/views/review_view.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/utils/style.dart';
import 'package:home_brigadier/widget/cText.dart';

class ReceiptView extends GetView {
  const ReceiptView({super.key});

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "E-Receipt",
            style: appbar,
          ),
          actions: [
            PopupMenuButton(
              position: PopupMenuPosition.under,
              color: Colors.white,
              icon: SvgPicture.asset(
                "assets/icons/ic_more_outlined.svg",
                color: AppColor.black,
                fit: BoxFit.scaleDown,
                width: appbariconsize,
                height: appbariconsize,
              ),
              onSelected: (value) {
                // your logic
              },
              itemBuilder: (BuildContext bc) {
                return [
                  PopupMenuItem(
                    value: '/share',
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/ic_send_outlined.svg",
                          fit: BoxFit.cover,
                          width: 20,
                          height: 20,
                          color: AppColor.black,
                        ),
                        SizedBox(
                          width: widht * 0.02,
                        ),
                        CText(
                          text: "Share E-Receipt",
                          fontWeight: FontWeight.w500,
                          fontsize: widht * 0.035,
                          color: AppColor.black,
                        )
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: '/download',
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/ic_download_outlined.svg",
                          fit: BoxFit.cover,
                          width: 20,
                          height: 20,
                          color: AppColor.black,
                        ),
                        SizedBox(
                          width: widht * 0.02,
                        ),
                        CText(
                          text: "Download E-Receipt",
                          fontWeight: FontWeight.w500,
                          fontsize: widht * 0.035,
                          color: AppColor.black,
                        )
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: '/Print',
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/ic_print_outlined.svg",
                          fit: BoxFit.cover,
                          width: 20,
                          height: 20,
                          color: AppColor.black,
                        ),
                        SizedBox(
                          width: widht * 0.02,
                        ),
                        CText(
                          text: "Print",
                          fontWeight: FontWeight.w500,
                          fontsize: widht * 0.035,
                          color: AppColor.black,
                        )
                      ],
                    ),
                  ),
                ];
              },
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: widht * 0.08,
            right: widht * 0.08,
            bottom: widht * 0.1,
            top: widht * 0.02,
          ),
          child: SizedBox(
            width: widht,
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: widht * 0.5,
                  height: height * 0.1,
                  child: SvgPicture.asset(
                    "assets/images/bar_code.svg",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: height * 0.00,
                ),
                CustomReviewTile(context, "Services", "House Cleaning"),
                CustomReviewTile(context, "Category", "Cleaning"),
                CustomReviewTile(context, "Workers", "Jenny Wilson"),
                CustomReviewTile(
                    context, "Date & Time", "Dec 20, 2022 | 10:00 AM"),
                CustomReviewTile(context, "Working Hours", "2 hours"),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CText(
                        text: "House Cleaning Details",
                        color: const Color(0xff6A6A6A),
                        fontsize: widht * 0.03,
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: Color(0xff212121),
                      )
                    ],
                  ),
                ),
                CustomReviewTile(context, "Amount", "125.00"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CText(
                      text: "Promo",
                      color: const Color(0xff9D5DF9),
                      fontsize: widht * 0.03,
                    ),
                    CText(
                      text: "-AED 37.50",
                      fontWeight: FontWeight.bold,
                      fontsize: widht * 0.03,
                      color: const Color(0xff9D5DF9),
                    ),
                  ],
                ),
                CustomReviewTile(context, "AED 125.00", "Credit Card"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CText(
                      text: "Transaction ID",
                      color: const Color(0xff6A6A6A),
                      fontsize: widht * 0.03,
                    ),
                    const Spacer(),
                    CText(
                      text: "SK7263727399",
                      fontWeight: FontWeight.bold,
                      fontsize: widht * 0.03,
                    ),
                    SizedBox(
                      width: widht * 0.02,
                    ),
                    const Icon(
                      Icons.copy,
                      size: 20,
                      color: AppColor.primary,
                    )
                  ],
                ),
                CustomReviewTile(context, "Status", "Paid"),
              ],
            ),
          ),
        ));
  }
}
