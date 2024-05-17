import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/generated/locales.g.dart';
import 'package:home_brigadier/model/user_services_models/my_services_resp_model.dart';

import '../../../../../../consts/app_color.dart';
import '../../../../../../consts/global_variable.dart';
import '../../../../../../consts/media_query.dart';
import '../../../../../../services/apis/api_endpoints.dart';
import '../../../../../../widget/cText.dart';
import '../../../../../../widget/shimmer.dart';
import '../../profile/user_profile/controllers/user_profile_controller.dart';
import '../../profile/user_profile/views/edit_services.dart';

class MyServicesView extends GetView<UserProfileController> {
  const MyServicesView({super.key});
  @override
  Widget build(BuildContext context) {
    final titleMedium = Theme.of(context).textTheme.titleMedium!.fontSize;
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/icons/ic_launcher_icon.png")),
              borderRadius: BorderRadius.all(Radius.circular(6))),
        ),
        title: CText(
            text: LocaleKeys.user_profile_item_services.tr,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontsize: mediaQueryHeight(context) * 0.025),
      ),
      body: GetBuilder(
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
                    return const Center(
                        child:
                            Text('No data found\n check Internet connection'));
                  } else if (!snapshot.data!.length.isEqual(0)) {
                    List<MyServicesRespModel>? data = snapshot.data;
                    List<MyServicesRespModel>? services = sortModelsById(data);

                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          // int openingHourLength = services![index].openingHours!.length;
                          return SizedBox(
                            width: mediaQueryWidth(context) * 0.9,
                            child: Card(
                                elevation: 8,
                                shadowColor: AppColor.greylight,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                child: Center(
                                  child: ExpansionTile(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      initiallyExpanded:
                                          index == 0 ? true : false,
                                      leading: SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: CachedNetworkImage(
                                            imageUrl:
                                                "${ApiEndpoints.IMGBASE}${services![index].files![0].file}",
                                            imageBuilder: (context,
                                                    imageProvider) =>
                                                Container(
                                                    width: 100,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover,
                                                        ))),
                                            placeholder: (context, url) =>
                                                const Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error)),
                                      ),
                                      dense: true,
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CText(
                                                textAlign: TextAlign.start,
                                                text:
                                                    '${services[index].description}',
                                              )
                                                  .paddingSymmetric(vertical: 5)
                                                  .marginSymmetric(vertical: 5),

                                              //
                                              Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(children: [
                                                      const Icon(
                                                          Icons
                                                              .pin_drop_outlined,
                                                          color:
                                                              AppColor.primary),
                                                      SizedBox(
                                                          width:
                                                              mediaQueryWidth(
                                                                      context) *
                                                                  0.5,
                                                          child: Text(
                                                            softWrap: true,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            "${services[index].address}",
                                                          ).paddingSymmetric(
                                                              vertical: 5))
                                                    ]),
                                                    SizedBox(
                                                      height: 55,
                                                      width: 55,
                                                      child: IconButton(
                                                        splashRadius: 25,
                                                        onPressed: () {
                                                          GlobalVariable
                                                                  .serviceModel =
                                                              services[index];
                                                          Get.to(() =>
                                                              const EditUserService());
                                                        },
                                                        icon: const Icon(
                                                          Icons.edit_outlined,
                                                          color:
                                                              AppColor.primary,
                                                        ).marginOnly(
                                                            bottom: 10),
                                                      ),
                                                    ),
                                                  ]).marginOnly(
                                                  top: 5, bottom: 20),
                                            ]).marginSymmetric(
                                            horizontal:
                                                mediaQueryWidth(context) * 0.1)
                                      ]),
                                )).marginOnly(top: 10),
                          );
                        });
                  } else {
                    return const Center(
                        child: CText(text: "No services found"));
                  }
                });
          }),
    );
  }
}

List<MyServicesRespModel>? sortModelsById(List<MyServicesRespModel>? models) {
  models!.sort((a, b) {
    // If both IDs are not null, compare them
    if (a.id != null && b.id != null) {
      return b.id!.compareTo(a.id!); // Greater IDs will appear first
    }
    // Handle cases where one or both IDs are null
    else if (a.id == null && b.id != null) {
      return 1; // Null ID goes after non-null ID
    } else if (a.id != null && b.id == null) {
      return -1; // Non-null ID goes before null ID
    } else {
      return 0; // Both IDs are null, no change in order
    }
  });
  return models;
}
