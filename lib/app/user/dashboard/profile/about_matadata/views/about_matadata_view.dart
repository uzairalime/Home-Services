import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/consts/media_query.dart';
import 'package:home_brigadier/widget/cText.dart';

import '../../../../../../model/meta_data.dart';
import '../../../../../../widget/c_icon_btn.dart';
import '../controllers/about_matadata_controller.dart';

class AboutMatadataView extends GetView<AboutMatadataController> {
  const AboutMatadataView({super.key});
  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme.titleMedium!.color;
    // final titleMedium = Theme.of(context).textTheme.titleMedium!.fontSize;
    final titleLarge = Theme.of(context).textTheme.titleLarge!.fontSize;
    return GetBuilder(
        init: Get.put(AboutMatadataController()),
        builder: (builderContext) {
          return Scaffold(
            appBar: AppBar(
                leading:
                    CIconBtn(onPressed: () => Get.back(), child: Icon(Icons.adaptive.arrow_back)),
                title: CText(
                    text: "About",
                    color: txtTheme,
                    fontsize: titleLarge,
                    fontWeight: FontWeight.w500)),
            body: Center(
              child: SizedBox(
                height: mediaQueryHeight(context),
                width: mediaQueryWidth(context) * 0.95,
                // color: Colors.amber,
                child: FutureBuilder<MetaDataModel>(
                  future: controller.getUsermetadata(),
                  builder: (context, AsyncSnapshot<MetaDataModel> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData) {
                      return const Center(child: Text('No data available'));
                    } else {
                      final userdata = snapshot.data!;

                      return ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Card(
                            color: AppColor.grey.withOpacity(0.1),
                            child: SizedBox(
                                height: mediaQueryHeight(context) * 0.07,
                                width: mediaQueryWidth(context) * 0.95,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: Container(
                                          height: 30,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: AppColor.grey.withOpacity(0.25),
                                              shape: BoxShape.circle),
                                          child: Center(
                                            child: SvgPicture.asset(
                                              "assets/icons/ic_phone_outlined.svg",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: SizedBox(
                                        width: mediaQueryWidth(context) * 0.5,
                                        child: Text(
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            userdata.mobile.toString()),
                                      ),
                                    ),
                                    SizedBox(
                                      width: mediaQueryWidth(context) * 0.2,
                                      // color: Colors.black,
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            onTap: () {
                                              controller.dail_launcher(userdata.mobile);
                                            },
                                            child: const Icon(
                                              Icons.arrow_outward_sharp,
                                              color: AppColor.primary,
                                            ),
                                          )),
                                    )
                                  ],
                                )),
                          ),
                          Card(
                            color: AppColor.grey.withOpacity(0.1),
                            child: SizedBox(
                                height: mediaQueryHeight(context) * 0.07,
                                width: mediaQueryWidth(context) * 0.95,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: Container(
                                          height: 30,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: AppColor.grey.withOpacity(0.25),
                                              shape: BoxShape.circle),
                                          child: Center(
                                            child: SvgPicture.asset(
                                              "assets/icons/ic_gmail.svg",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: SizedBox(
                                        width: mediaQueryWidth(context) * 0.5,
                                        child: Text(
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            userdata.supportEmail.toString()),
                                      ),
                                    ),
                                    SizedBox(
                                      width: mediaQueryWidth(context) * 0.2,
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            onTap: () {
                                              controller.mail_launcher(userdata.supportEmail);
                                            },
                                            child: const Icon(
                                              Icons.arrow_outward_sharp,
                                              color: AppColor.secondary,
                                            ),
                                          )),
                                    )
                                  ],
                                )),
                          ),
                          Card(
                            color: AppColor.grey.withOpacity(0.1),
                            child: SizedBox(
                                height: mediaQueryHeight(context) * 0.07,
                                width: mediaQueryWidth(context) * 0.95,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: Container(
                                            height: 30,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColor.grey.withOpacity(0.25)),
                                            child: const Center(
                                                child: FaIcon(
                                              FontAwesomeIcons.whatsapp,
                                              color: Colors.green,
                                            )),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: SizedBox(
                                          width: mediaQueryWidth(context) * 0.5,
                                          child: Text(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              userdata.mobile.toString())),
                                    ),
                                    SizedBox(
                                      width: mediaQueryWidth(context) * 0.2,
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            onTap: () {
                                              controller.whatsapplauncher(userdata.mobile);
                                            },
                                            child: const Icon(
                                              Icons.arrow_outward_sharp,
                                              color: AppColor.secondary,
                                            ),
                                          )),
                                    )
                                  ],
                                )),
                          ),
                          Card(
                            color: AppColor.grey.withOpacity(0.1),
                            child: SizedBox(
                                height: mediaQueryHeight(context) * 0.07,
                                width: mediaQueryWidth(context) * 0.95,
                                child: Row(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: Container(
                                            height: 30,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColor.grey.withOpacity(0.25)),
                                            child: const Center(
                                                child: FaIcon(
                                              FontAwesomeIcons.facebook,
                                              color: Colors.blue,
                                            )),
                                          ),
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: SizedBox(
                                          width: mediaQueryWidth(context) * 0.5,
                                          child: Text(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              userdata.facebook.toString(),
                                              style: const TextStyle(color: Colors.blue)),
                                        )),
                                    SizedBox(
                                      width: mediaQueryWidth(context) * 0.2,
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            onTap: () {
                                              controller.facebooklaauncher(userdata.facebook);
                                            },
                                            child: const Icon(
                                              Icons.arrow_outward_sharp,
                                              color: AppColor.secondary,
                                            ),
                                          )),
                                    )
                                  ],
                                )),
                          ),
                          Card(
                            color: AppColor.grey.withOpacity(0.1),
                            child: SizedBox(
                                height: mediaQueryHeight(context) * 0.07,
                                width: mediaQueryWidth(context) * 0.95,
                                child: Row(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: Container(
                                            height: 30,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColor.grey.withOpacity(0.25)),
                                            child: const Center(
                                                child: FaIcon(
                                              FontAwesomeIcons.instagram,
                                              color: Colors.red,
                                            )),
                                          ),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: SizedBox(
                                        width: mediaQueryWidth(context) * 0.5,
                                        child: Text(
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            userdata.instagram.toString(),
                                            style: const TextStyle(color: Colors.blue)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: mediaQueryWidth(context) * 0.2,
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            onTap: () {
                                              controller
                                                  .instagramlauncher(userdata.instagram.toString());
                                            },
                                            child: const Icon(
                                              Icons.arrow_outward_sharp,
                                              color: AppColor.secondary,
                                            ),
                                          )),
                                    )
                                  ],
                                )),
                          ),
                          Card(
                            color: AppColor.grey.withOpacity(0.1),
                            child: SizedBox(
                                height: mediaQueryHeight(context) * 0.07,
                                width: mediaQueryWidth(context) * 0.95,
                                child: Row(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: Container(
                                            height: 30,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColor.grey.withOpacity(0.25)),
                                            child: const Center(
                                                child: FaIcon(
                                              FontAwesomeIcons.linkedinIn,
                                              color: Colors.blue,
                                            )),
                                          ),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: SizedBox(
                                        width: mediaQueryWidth(context) * 0.5,
                                        child: Text(
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            userdata.linkedin.toString(),
                                            style: const TextStyle(color: Colors.blue)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: mediaQueryWidth(context) * 0.2,
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            onTap: () {
                                              controller
                                                  .launchLinkedInProfileLink(userdata.linkedin);
                                            },
                                            child: const Icon(
                                              Icons.arrow_outward_sharp,
                                              color: AppColor.secondary,
                                            ),
                                          )),
                                    )
                                  ],
                                )),
                          ),
                          Card(
                            color: AppColor.grey.withOpacity(0.1),
                            child: SizedBox(
                                height: mediaQueryHeight(context) * 0.07,
                                width: mediaQueryWidth(context) * 0.95,
                                child: Row(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: Container(
                                            height: 30,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColor.grey.withOpacity(0.25)),
                                            child: const Center(
                                                child: FaIcon(
                                              FontAwesomeIcons.twitter,
                                              color: Colors.blue,
                                            )),
                                          ),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: SizedBox(
                                        width: mediaQueryWidth(context) * 0.5,
                                        child: Text(
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            userdata.twitter.toString(),
                                            style: const TextStyle(color: Colors.blue)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: mediaQueryWidth(context) * 0.2,
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            onTap: () {
                                              controller.twitterlauncher(userdata.twitter);
                                            },
                                            child: const Icon(
                                              Icons.arrow_outward_sharp,
                                              color: AppColor.secondary,
                                            ),
                                          )),
                                    )
                                  ],
                                )),
                          ),
                          Card(
                            color: AppColor.grey.withOpacity(0.1),
                            child: SizedBox(
                                height: mediaQueryHeight(context) * 0.07,
                                width: mediaQueryWidth(context) * 0.95,
                                child: Row(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: Container(
                                            height: 30,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColor.grey.withOpacity(0.25)),
                                            child: const Center(
                                                child: FaIcon(
                                              FontAwesomeIcons.youtube,
                                              color: Colors.red,
                                            )),
                                          ),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: SizedBox(
                                        width: mediaQueryWidth(context) * 0.5,
                                        child: Text(
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          userdata.youtube.toString(),
                                          style: const TextStyle(color: Colors.blue),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: mediaQueryWidth(context) * 0.2,
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            onTap: () {
                                              controller.youtubelaunch(userdata.youtube);
                                            },
                                            child: const Icon(
                                              Icons.arrow_outward_sharp,
                                              color: AppColor.grey,
                                            ),
                                          )),
                                    )
                                  ],
                                )),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          );
        });
  }
}
