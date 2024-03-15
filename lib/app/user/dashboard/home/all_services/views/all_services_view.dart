// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/user/dashboard/home/all_services/selected_category/views/selected_category_view.dart';
import 'package:home_brigadier/app/user/dashboard/home/controllers/home_controller.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/generated/locales.g.dart';
import 'package:home_brigadier/model/category_name_model.dart';
import 'package:home_brigadier/model/icon_model.dart';
import 'package:home_brigadier/utils/style.dart';
import 'package:home_brigadier/widget/shimmer.dart';

import '../controllers/all_services_controller.dart';

class AllServicesView extends GetView<AllServicesController> {
  const AllServicesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController con = Get.find();
    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            LocaleKeys.user_profile_item_all_services.tr,
            style: appbar,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            top: height * 0.05,
            left: height * 0.03,
            right: height * 0.03,
          ),
          child: SizedBox(
              width: widht,
              height: height,
              child: FutureBuilder(
                  future: con.getCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 12,
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
                                  width: widht * 0.19, height: widht * 0.21),
                            ],
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final List<CetegoryModel> categoryList = con.categorylist;

                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            categoryList.isEmpty ? 10 : categoryList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: widht * 0.01,
                          mainAxisSpacing: height * 0.01,
                          mainAxisExtent: height * 0.115,
                          crossAxisCount: 4,
                        ),
                        itemBuilder: (context, index) {
                          final model = categoryList[index];
                          return categoryList.isEmpty
                              ? EmptyItem(widht, height)
                              : CategoryItem(widht, height, model);
                        },
                      );
                    }
                  })),
        ));
  }

  InkWell CategoryItem(double widht, double height, CetegoryModel model) {
    int icon = ServiceIconModel.servicesicon
        .indexWhere((icon) => icon.title == model.displayName);
    return InkWell(
      onTap: () {
        Get.to(() => SelectedCategoryView(model: model));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            width: widht * 0.19,
            height: widht * 0.20,
            decoration: BoxDecoration(
                color: AppColor.greylight.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  ServiceIconModel.servicesicon[icon].icon!,
                  color: AppColor.primary,
                  fit: BoxFit.fill,
                  width: 30,
                  height: 30,
                ),
                Text(
                  model.displayName.toString(),
                  textAlign: TextAlign.center,
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
  }

  Widget EmptyItem(double widht, double height) {
    return Column(
      children: [
        ShimmerWidget.circular(width: widht * 0.15, height: widht * 0.15),
        SizedBox(
          height: height * 0.01,
        ),
        const ShimmerWidget.rectangular(height: 10)
      ],
    );
  }
}
