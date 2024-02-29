import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/house_cleaning/controllers/booking_controller.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/category_item/house_cleaning/views/location_view.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/utils/style.dart';
import 'package:home_brigadier/widget/cText.dart';
import 'package:home_brigadier/widget/c_filled_btn.dart';

class PromoView extends GetView {
  const PromoView({super.key});

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final controller = Get.put(BookingController());

    return Scaffold(
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
            padding:
                const EdgeInsets.only(top: 30, bottom: 24, left: 20, right: 20),
            child: CButton(
              text: "Apply Promo",
              shadow: true,
              borderradius: widht * 0.075,
              fontWeight: FontWeight.bold,
              ontab: () => Get.to(() => const LocationView()),
            ),
          ),
        ),
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            "Add Promo",
            style: appbar,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 12, left: 12, bottom: 12, right: 18),
              child: SvgPicture.asset(
                "assets/icons/ic_search.svg",
                fit: BoxFit.scaleDown,
                width: appbariconsize,
                height: appbariconsize,
                color:  AppColor.black,
              ),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(top: height * 0.04),
          child: Column(
            children: [
              SizedBox(
                width: widht,
                height: height * 0.7,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: PromoModel.list.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 100,
                      child: Obx(
                        () => ListTile(
                          leading: SizedBox(
                            height: 70,
                            width: 70,
                            child: SvgPicture.asset(
                              PromoModel.list[index].path.toString(),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          subtitle: CText(
                            color: AppColor.grey,
                            fontsize: 12,
                            textAlign: TextAlign.start,
                            text: PromoModel.list[index].subtitle.toString(),
                          ),
                          title: CText(
                            fontWeight: FontWeight.bold,
                            text: PromoModel.list[index].title.toString(),
                            textAlign: TextAlign.start,
                          ),
                          trailing: Radio.adaptive(
                            value: index,
                            groupValue: controller.selectedRadio.value,
                            onChanged: (value) {
                              controller.setSelectedRadio(value!);
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

class PromoModel {
  final String? title;
  final String? subtitle;
  final String? path;

  PromoModel(this.title, this.subtitle, this.path);

  static List<PromoModel> list = [
    PromoModel("Special 25% Off", "Special promo only today!",
        "assets/icons/promo1.svg"),
    PromoModel(
        "Special 30% Off", "Discount 30% Off", "assets/icons/promo2.svg"),
    PromoModel("Special 20% Off", "Special promo only today!",
        "assets/icons/promo3.svg"),
    PromoModel("Special 40% Off", "Special promo only Valid today",
        "assets/icons/promo4.svg"),
    PromoModel("Special 35% Off", "Special promo only today!",
        "assets/icons/promo5.svg"),
  ];
}
