import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/utils/style.dart';
import 'package:home_brigadier/widget/cText.dart';
import 'package:home_brigadier/widget/c_filled_btn.dart';

import '../controllers/bookmark_controller.dart';

class BookmarkView extends GetView<BookmarkController> {
  const BookmarkView({super.key});

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "My Bookmark",
            style: appbar,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset(
                "assets/icons/ic_more_outlined.svg",
                color: AppColor.black,
                fit: BoxFit.cover,
                width: appbariconsize,
                height: appbariconsize,
              ),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: widht * 0.05,
            right: widht * 0.05,
            top: widht * 0.05,
          ),
          child: SizedBox(
            width: widht,
            height: height,
            child: const TabbarClass(),
          ),
        ));
  }
}

class TabbarClass extends StatelessWidget {
  const TabbarClass({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 7,
      initialIndex: 0,
      animationDuration: const Duration(milliseconds: 3),
      child: Column(
        children: <Widget>[
          ButtonsTabBar(
            radius: tabbarradius,
            buttonMargin: buttonmargin,
            contentPadding: tabbatcontentPaddiing,
            backgroundColor: AppColor.primary,
            borderWidth: 1,
            borderColor: AppColor.primary,
            unselectedBackgroundColor: Colors.transparent,
            unselectedLabelStyle: TextStyle(
                color: AppColor.primary, fontWeight: FontWeight.bold, fontSize: widht * 0.04),
            unselectedBorderColor: AppColor.primary,
            labelStyle: TextStyle(
                color: AppColor.white, fontWeight: FontWeight.bold, fontSize: widht * 0.04),
            tabs: const [
              Tab(
                text: "All",
              ),
              Tab(
                text: "Cleaning",
              ),
              Tab(
                text: "Repairing",
              ),
              Tab(
                text: "Painting",
              ),
              Tab(
                text: "Appliance",
              ),
              Tab(
                text: "Plumbing",
              ),
              Tab(
                text: "Shifting",
              ),
            ],
          ),
          SizedBox(height: height * 0.05),
          const Expanded(
            child: TabBarView(children: [
              TabBarGrid(
                name: "All",
              ),
              TabBarGrid(
                name: "Cleaning",
              ),
              TabBarGrid(
                name: "Repairing",
              ),
              TabBarGrid(
                name: "Painting",
              ),
              TabBarGrid(
                name: "Appliance",
              ),
              TabBarGrid(
                name: "Plumbing",
              ),
              TabBarGrid(
                name: "Shifting",
              ),
            ]),
          ),
        ],
      ),
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
    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Card(
              elevation: 1.5,
              shadowColor: AppColor.white,
              color: AppColor.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: SizedBox(
                width: widht,
                height: height * 0.20,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 12),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: index % 2 == 1
                                  ? const Color(0xffACD6E6)
                                  : index % 2 == 3
                                      ? const Color(0xffEDA0A8)
                                      : index % 2 == 3
                                          ? const Color(0xffA4D6AA)
                                          : const Color(0xffB887FF)),
                          width: widht * 0.25,
                          height: height,
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/icons/box_icon.svg",
                              fit: BoxFit.cover,
                              width: widht * 0.1,
                              height: widht * 0.1,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 6,
                          child: Container(
                            margin: const EdgeInsets.only(left: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const CText(
                                      text: "Kylee Danford",
                                      color: AppColor.grey,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _showbottomModel(context, index);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 12),
                                        child: SvgPicture.asset(
                                          index % 2 == 0
                                              ? "assets/icons/ic_bookmark_outlined.svg"
                                              : "assets/icons/ic_bookmark_filled.svg",
                                          color: AppColor.primary,
                                          width: 20,
                                          height: 20,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                CText(
                                  text: "House Cleaning",
                                  fontsize: widht * 0.045,
                                  fontWeight: FontWeight.bold,
                                ),
                                CText(
                                  text: "AED 25",
                                  color: AppColor.primary,
                                  fontWeight: FontWeight.bold,
                                  fontsize: widht * 0.045,
                                ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 20,
                                      color: Color(0xffFD9B12),
                                    ),
                                    CText(
                                      text: "4.8 | 8,289 reviews",
                                      color: AppColor.grey,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showbottomModel(BuildContext context, int index) async {
    return showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        backgroundColor: AppColor.white,
        context: context,
        builder: (context) {
          final widht = MediaQuery.of(context).size.width;
          final height = MediaQuery.of(context).size.height;
          return Padding(
            padding: EdgeInsets.only(
              bottom: widht * 0.075,
              left: widht * 0.05,
              right: widht * 0.05,
            ),
            child: Container(
              width: widht,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              )),
              child: Padding(
                padding: EdgeInsets.all(widht * 0.025),
                child: Wrap(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: widht * 0.2,
                        height: 5,
                        decoration: BoxDecoration(
                            color: AppColor.greylight, borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: CText(
                          text: "Remove from Bookmark?",
                          fontsize: widht * 0.055,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColor.greylight,
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Card(
                        elevation: 1.5,
                        shadowColor: AppColor.white,
                        color: const Color(0xffEEEEEE),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: SizedBox(
                          width: widht,
                          height: height * 0.16,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 12),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: const Color(0xffACD6E6),
                                    ),
                                    width: widht * 0.25,
                                    height: height,
                                    child: Center(
                                      child: SvgPicture.asset(
                                        "assets/icons/box_icon.svg",
                                        fit: BoxFit.cover,
                                        width: widht * 0.1,
                                        height: widht * 0.1,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 6,
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 8),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const CText(
                                                text: "Kylee Danford",
                                                color: AppColor.grey,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 12),
                                                child: SvgPicture.asset(
                                                  index % 2 == 0
                                                      ? "assets/icons/ic_bookmark_outlined.svg"
                                                      : "assets/icons/ic_bookmark_filled.svg",
                                                  color: AppColor.primary,
                                                  width: 20,
                                                  height: 20,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            ],
                                          ),
                                          CText(
                                            text: "House Cleaning",
                                            fontsize: widht * 0.045,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          CText(
                                            text: "AED 25",
                                            color: AppColor.primary,
                                            fontWeight: FontWeight.bold,
                                            fontsize: widht * 0.045,
                                          ),
                                          const Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size: 20,
                                                color: Color(0xffFD9B12),
                                              ),
                                              CText(
                                                text: "4.8 | 8,289 reviews",
                                                color: AppColor.grey,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: CButton(
                          text: "Cancel",
                          bgcolor: const Color(0xffF1E7FF),
                          txtcolor: AppColor.primary,
                          borderradius: widht * 0.1,
                          ontab: () {
                            Get.back();
                          },
                        )),
                        SizedBox(
                          width: widht * 0.02,
                        ),
                        Expanded(
                            child: CButton(
                                ontab: () {},
                                borderradius: widht * 0.1,
                                txtcolor: AppColor.white,
                                fontsize: widht * 0.045,
                                fontWeight: FontWeight.bold,
                                shadow: true,
                                text: "Yes, Remove")),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
