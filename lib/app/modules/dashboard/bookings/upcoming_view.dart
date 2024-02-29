import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/modules/dashboard/home/all_services/selected_category/category_item/house_cleaning/views/payment_view.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/consts/media_query.dart';
import 'package:home_brigadier/widget/cText.dart';
import 'package:home_brigadier/widget/c_filled_btn.dart';

import 'controllers/bookings_controller.dart';

class UpcomingView extends GetView<BookingsController> {
  const UpcomingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleLarge = Theme.of(context).textTheme.titleLarge!.fontSize;
    final titleSmall = Theme.of(context).textTheme.titleSmall!.fontSize;
    final labelLarge = Theme.of(context).textTheme.labelLarge!.fontSize;

    return GetBuilder<BookingsController>(
      builder: (obj) {
        return ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return Card(
                  margin: EdgeInsets.symmetric(
                      vertical: mediaQueryHeight(context) * 0.012,
                      horizontal: mediaQueryWidth(context) * 0.05),
                  child: CustomExpansionTile(
                      fistChild: Row(children: [
                        Expanded(
                            child: Container(
                                height: 100,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/img_people.png"),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(25))))),
                        Expanded(
                            flex: 2,
                            child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CText(
                                          text: "Plumber",
                                          fontsize: titleLarge),
                                      CText(
                                          text: "text",
                                          fontsize: labelLarge,
                                          color: AppColor.grey),
                                      SizedBox(
                                          width:
                                              mediaQueryWidth(context) * 0.22,
                                          height:
                                              mediaQueryHeight(context) * 0.035,
                                          child: CButton(
                                            ontab: () {},
                                            fontsize: labelLarge,
                                            text: "Upcoming",
                                            borderradius: 7,
                                          ))
                                    ]))),
                        Expanded(
                            child: CircleAvatar(
                                backgroundColor: AppColor.grey.withOpacity(0.3),
                                child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: SvgPicture.asset(
                                        "assets/icons/ic_message.svg"))))
                      ]),
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CText(
                                      text: "Date & Time",
                                      fontsize: labelLarge,
                                      color: AppColor.grey),
                                  CText(
                                      text: "${DateTime.now()}",
                                      fontsize: titleSmall)
                                ])),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: [
                              Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CText(
                                        text: "Location",
                                        fontsize: labelLarge,
                                        color: AppColor.grey),
                                    CText(
                                        text: "1691 Carpenter Pass",
                                        fontsize: titleSmall)
                                  ]),
                              Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              "assets/images/map.png")),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  height: mediaQueryHeight(context) * 0.25),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: IconButton.outlined(
                                        style: IconButton.styleFrom(
                                            side: const BorderSide(
                                                color: AppColor.secondary,
                                                width: 2)),
                                        onPressed: () async {
                                          await showModalBottomSheet(
                                              isDismissible: true,
                                              showDragHandle: true,
                                              context: context,
                                              builder: (BuildContext context) {
                                                return buildBottomSheetContent(
                                                    context);
                                              });
                                        },
                                        icon: const CText(
                                          text: "Cancel Booking",
                                          color: AppColor.secondary,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: CFilledBtn(
                                            text: "View E-Receipt",
                                            onPressed: () {},
                                            height: 40,
                                            btnBg: AppColor.secondary))
                                  ])
                            ]))
                      ]));
            });
      },
    );
  }

  Widget buildBottomSheetContent(BuildContext context) {
    return Container(
        width: mediaQueryWidth(context),
        padding:
            EdgeInsets.symmetric(horizontal: mediaQueryWidth(context) * 0.05),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CText(
                  text: "Cancel Booking",
                  color: AppColor.red,
                  fontsize: Theme.of(context).textTheme.titleLarge!.fontSize),
              Divider(
                  indent: mediaQueryWidth(context) * 0.05,
                  endIndent: mediaQueryWidth(context) * 0.05),
              CText(
                  text: "Are you sure to cancel your service booking?",
                  fontsize: Theme.of(context).textTheme.titleLarge!.fontSize),
              CText(
                  text:
                      "Only 80% money you can refund from your payment according to our policy",
                  fontsize: Theme.of(context).textTheme.titleSmall!.fontSize,
                  color: AppColor.grey),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            flex: 1,
                            child: CFilledBtn(
                                text: "Cancel",
                                onPressed: () {
                                  Get.back();
                                },
                                height: 56,
                                textColor: AppColor.secondary,
                                btnBg: AppColor.grey.withOpacity(0.3))),
                        const SizedBox(width: 10),
                        Expanded(
                            flex: 2,
                            child: CFilledBtn(
                                text: "Yes, Cancel Booking",
                                onPressed: () {
                                  Get.to(() => const PaymentView());
                                },
                                height: 56,
                                btnBg: AppColor.secondary))
                      ]))
            ]));
  }
}

class CustomExpansionTile extends StatefulWidget {
  const CustomExpansionTile(
      {super.key, required this.children, required this.fistChild});

  final Widget fistChild;
  final List<Widget> children;

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.fistChild,
        const SizedBox(height: 20),
        Divider(
            indent: mediaQueryWidth(context) * 0.05,
            endIndent: mediaQueryWidth(context) * 0.05),
        AnimatedCrossFade(
            duration: const Duration(milliseconds: 200),
            crossFadeState:
                isExpand ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            firstChild: const SizedBox(),
            secondChild: Column(children: [if (isExpand) ...widget.children])),
        IconButton(
          onPressed: () {
            setState(() {
              isExpand = !isExpand;
            });
          },
          icon: !isExpand
              ? const Icon(Icons.keyboard_arrow_down_outlined)
              : const Icon(Icons.keyboard_arrow_up_outlined),
        ),
      ],
    );
  }
}
