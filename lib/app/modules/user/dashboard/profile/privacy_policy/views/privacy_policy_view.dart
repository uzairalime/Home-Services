import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/generated/locales.g.dart';
import 'package:home_brigadier/widget/cText.dart';

import '../../../../../seller/dashboard/profile/privacy_policy/controllers/privacy_policy_controller.dart';

class PrivacyPolicyView extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    final titleMedium = Theme.of(context).textTheme.titleMedium!.fontSize;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        actions: const [],
        title: Text(
          LocaleKeys.dashboard_profile_privacy_policy.tr,
          style: TextStyle(
              color: Theme.of(context).textTheme.titleMedium!.color,
              fontSize: titleMedium,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 13, right: 13, top: 5),
            child: Text(
              LocaleKeys.dashboard_profile__privacy_policy_detail_0.tr,
              style: const TextStyle(
                color: AppColor.grey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: CText(
              text: LocaleKeys.dashboard_profile__privacy_policy_txt_1.tr,
              fontsize: titleMedium,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13, right: 13, top: 5),
            child: Text(
              LocaleKeys.dashboard_profile__privacy_policy_detail_1.tr,
              style: const TextStyle(
                color: AppColor.grey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: CText(
              text: LocaleKeys.dashboard_profile__privacy_policy_txt_2.tr,
              fontsize: titleMedium,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13, right: 13, top: 5),
            child: Text(
              LocaleKeys.dashboard_profile__privacy_policy_detail_2.tr,
              style: const TextStyle(color: AppColor.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: CText(
              text: LocaleKeys.dashboard_profile__privacy_policy_txt_3.tr,
              fontsize: titleMedium,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13, right: 13, top: 5),
            child: Text(
              LocaleKeys.dashboard_profile__privacy_policy_detail_3.tr,
              style: const TextStyle(color: AppColor.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: CText(
              text: LocaleKeys.dashboard_profile__privacy_policy_txt_4.tr,
              fontsize: titleMedium,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13, right: 13, top: 5),
            child: Text(
              LocaleKeys.dashboard_profile__privacy_policy_detail_4.tr,
              style: const TextStyle(color: AppColor.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: CText(
              text: LocaleKeys.dashboard_profile__privacy_policy_txt_5.tr,
              fontsize: titleMedium,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13, right: 13, top: 5),
            child: Text(
              LocaleKeys.dashboard_profile__privacy_policy_detail_5.tr,
              style: const TextStyle(color: AppColor.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: CText(
              text: LocaleKeys.dashboard_profile__privacy_policy_txt_6.tr,
              fontsize: titleMedium,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13, right: 13, top: 5),
            child: Text(
              LocaleKeys.dashboard_profile__privacy_policy_detail_6.tr,
              style: const TextStyle(color: AppColor.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: CText(
              text: LocaleKeys.dashboard_profile__privacy_policy_txt_7.tr,
              fontsize: titleMedium,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13, right: 13, top: 5),
            child: Text(
              LocaleKeys.dashboard_profile__privacy_policy_detail_7.tr,
              style: const TextStyle(color: AppColor.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: CText(
              text: LocaleKeys.dashboard_profile__privacy_policy_txt_8.tr,
              fontsize: titleMedium,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 13, right: 13, top: 5, bottom: 13),
            child: Text(
              LocaleKeys.dashboard_profile__privacy_policy_detail_8.tr,
              style: const TextStyle(color: AppColor.grey),
            ),
          ),
        ],
      ),
    );
  }
}
