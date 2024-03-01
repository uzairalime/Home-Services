import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/seller/dashboard/profile/user_profile/views/edit_services.dart';
import 'package:home_brigadier/consts/global_variable.dart';
import 'package:home_brigadier/generated/locales.g.dart';
import 'package:home_brigadier/model/user_services_models/my_services_resp_model.dart';

import '../../../../../../consts/app_color.dart';
import '../../../../../../consts/media_query.dart';
import '../../../../../../widget/cText.dart';
import '../../../../../../widget/shimmer.dart';
import '../controllers/user_profile_controller.dart';

class MyServicesView extends GetView<UserProfileController> {
  const MyServicesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final titleMedium = Theme.of(context).textTheme.titleMedium!.fontSize;

    return GetBuilder(
        init: Get.put(UserProfileController()),
        builder: (context) {
          return FutureBuilder<List<MyServicesRespModel>>(
              future: controller.fetchServices(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: SizedBox(
                    width: mediaQueryWidth(context) * 0.95,
                    child: ListView(
                      children: [
                        ShimmerWidget.rectangular(
                          height: mediaQueryHeight(context) * 0.25,
                        ),
                        SizedBox(
                          height: mediaQueryHeight(context) * 0.01,
                        ),
                        ShimmerWidget.rectangular(
                          height: mediaQueryHeight(context) * 0.25,
                        ),
                        SizedBox(
                          height: mediaQueryHeight(context) * 0.01,
                        ),
                        ShimmerWidget.rectangular(
                          height: mediaQueryHeight(context) * 0.25,
                        ),
                      ],
                    ),
                  )); // or a loading indicator widget
                } else if (snapshot.hasError) {
                  return const Center(child: Text('No data found\n check Internet connection'));
                } else {
                  List<MyServicesRespModel>? services = snapshot.data;

                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        // int openingHourLength = services![index].openingHours!.length;
                        return SizedBox(
                          width: mediaQueryWidth(context) * 0.9,
                          child: Card(
                              elevation: 8,
                              shadowColor: AppColor.greylight,
                              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: ExpansionTile(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12)),
                                    initiallyExpanded: index == 0 ? true : false,
                                    leading: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: CachedNetworkImage(
                                          imageUrl:
                                              "https://homebrigadier.fly.dev${services![index].files![0].file}",
                                          imageBuilder: (context, imageProvider) => Container(
                                              width: 100,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ))),
                                          placeholder: (context, url) =>
                                              const Center(child: CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error)),
                                    ),
                                    title: CText(
                                            fontsize: titleMedium,
                                            textAlign: TextAlign.start,
                                            color: AppColor.black,
                                            text: "${services[index].name}",
                                            fontWeight: FontWeight.bold)
                                        .paddingOnly(bottom: 10),
                                    subtitle: CText(
                                        textAlign: TextAlign.start,
                                        color: AppColor.black,
                                        text:
                                            "${LocaleKeys.my_jobs_aed.tr} ${services[index].rate}/hr"),
                                    children: [
                                      Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CText(
                                              textAlign: TextAlign.start,
                                              text: '${services[index].description}',
                                            )
                                                .paddingSymmetric(vertical: 5)
                                                .marginSymmetric(vertical: 5),

                                            //
                                            Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Icon(Icons.pin_drop_outlined,
                                                          color: AppColor.primary),
                                                      SizedBox(
                                                        width: mediaQueryWidth(context) * 0.5,
                                                        child: Text(
                                                          softWrap: true,
                                                          overflow: TextOverflow.ellipsis,
                                                          "${services[index].address}",
                                                        ).paddingSymmetric(vertical: 5),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 55,
                                                    width: 55,
                                                    child: IconButton(
                                                      splashRadius: 25,
                                                      onPressed: () {
                                                        GlobalVariable.serviceModel =
                                                            services[index];
                                                        Get.to(() => const EditUserService());
                                                      },
                                                      icon: const Icon(
                                                        Icons.edit_outlined,
                                                        color: AppColor.primary,
                                                      ).marginOnly(bottom: 10),
                                                    ),
                                                  )
                                                ]).marginOnly(top: 5, bottom: 20),
                                          ]).marginSymmetric(
                                          horizontal: mediaQueryWidth(context) * 0.1)
                                    ]),
                              )).marginOnly(top: 10),
                        );
                      });
                }
              });
        });
  }
}
