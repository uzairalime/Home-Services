import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/consts/media_query.dart';
import 'package:home_brigadier/generated/locales.g.dart';

import '../../../../../../consts/app_color.dart';
import '../../../../../../widget/cText.dart';
import '../../../../../../widget/c_icon_btn.dart';
import '../controllers/notification_setting_controller.dart';

class NotificationSettingView extends GetView<NotificationSettingController> {
  const NotificationSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme.titleMedium!.color;
    final titleLarge = Theme.of(context).textTheme.titleLarge!.fontSize;

    return Scaffold(
        appBar: AppBar(
            leading: CIconBtn(onPressed: () => Get.back(), child: Icon(Icons.adaptive.arrow_back)),
            title: CText(
                text: LocaleKeys.dashboard_profile_notification.tr,
                color: txtTheme,
                fontsize: titleLarge,
                fontWeight: FontWeight.w500)),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: mediaQueryWidth(context) * 0.05,
            ),
            child: Obx(() => Column(children: [
                  NotificationListTile(
                      title: LocaleKeys.dashboard_profile__notification_sound.tr,
                      btn: Switch.adaptive(
                          activeTrackColor: AppColor.secondary,
                          value: controller.soundSwitch.value,
                          onChanged: (value) {
                            controller.notifiSwitch(value: value, title: "Sound");
                          })),
                  NotificationListTile(
                      title: LocaleKeys.dashboard_profile__notification_vibrate.tr,
                      btn: Switch.adaptive(
                          activeTrackColor: AppColor.secondary,
                          value: controller.vibrationSwitch.value,
                          onChanged: (value) {
                            controller.notifiSwitch(value: value, title: "Vibration");
                          })),
                  NotificationListTile(
                      title: LocaleKeys.dashboard_profile__notification_special_offer.tr,
                      btn: Switch.adaptive(
                          activeTrackColor: AppColor.secondary,
                          value: controller.specialOfferSwitch.value,
                          onChanged: (value) {
                            controller.notifiSwitch(value: value, title: "Special Offer");
                          })),
                  NotificationListTile(
                      title: LocaleKeys.dashboard_profile__notification_promo_discount.tr,
                      btn: Switch.adaptive(
                          activeTrackColor: AppColor.secondary,
                          value: controller.promoDiscountSwitch.value,
                          onChanged: (value) {
                            controller.notifiSwitch(value: value, title: "Promo % Discount");
                          })),
                  NotificationListTile(
                      title: LocaleKeys.dashboard_profile__notification_payment.tr,
                      btn: Switch.adaptive(
                          activeTrackColor: AppColor.secondary,
                          value: controller.paymentsSwitch.value,
                          onChanged: (value) {
                            controller.notifiSwitch(value: value, title: "Payments");
                          })),
                  NotificationListTile(
                      title: LocaleKeys.dashboard_profile__notification_cashBack.tr,
                      btn: Switch.adaptive(
                          activeTrackColor: AppColor.secondary,
                          value: controller.cashbackSwitch.value,
                          onChanged: (value) {
                            controller.notifiSwitch(value: value, title: "Cashback");
                          })),
                  // NotificationListTile(
                  //     title: "App Updates",
                  //     btn: Switch.adaptive(
                  //         activeTrackColor: AppColor.secondary,
                  //         value: controller.appUpdatesSwitch.value,
                  //         onChanged: (value) {
                  //           controller.notifiSwitch(value: value, title: "App Updates");
                  //         })),
                  // NotificationListTile(
                  //     title: "New Services Available",
                  //     btn: Switch.adaptive(
                  //         activeTrackColor: AppColor.secondary,
                  //         value: controller.newServicesSwitch.value,
                  //         onChanged: (value) {
                  //           controller.notifiSwitch(value: value, title: "New Services Available");
                  //         })),
                  // NotificationListTile(
                  //     title: "New Tips Available",
                  //     btn: Switch.adaptive(
                  //         activeTrackColor: AppColor.secondary,
                  //         value: controller.newTipsSwitch.value,
                  //         onChanged: (value) {
                  //           controller.notifiSwitch(value: value, title: "New Tips Available");
                  //         })),

                  // NotificationListTile(
                  //     title: "Sound",
                  //     btn: Switch.adaptive(
                  //         activeTrackColor: AppColor.secondary,
                  //         value: true,
                  //         onChanged: (value) {})),
                  // NotificationListTile(
                  //     title: "Vibrate",
                  //     btn: Switch.adaptive(
                  //         activeTrackColor: AppColor.secondary,
                  //         value: true,
                  //         onChanged: (value) {})),
                  // NotificationListTile(
                  //     title: "Special Offer",
                  //     btn: Switch.adaptive(
                  //         activeTrackColor: AppColor.secondary,
                  //         value: true,
                  //         onChanged: (value) {})),
                  // NotificationListTile(
                  //     title: "Promo & Discount",
                  //     btn: Switch.adaptive(
                  //         activeTrackColor: AppColor.secondary,
                  //         value: true,
                  //         onChanged: (value) {})),
                  // NotificationListTile(
                  //     title: "Payment",
                  //     btn: Switch.adaptive(
                  //         activeTrackColor: AppColor.secondary,
                  //         value: true,
                  //         onChanged: (value) {})),
                  // NotificationListTile(
                  //     title: "Cashback",
                  //     btn: Switch.adaptive(
                  //         activeTrackColor: AppColor.secondary,
                  //         value: true,
                  //         onChanged: (value) {})),
                  // NotificationListTile(
                  //     title: "App Updates",
                  //     btn: Switch.adaptive(
                  //         activeTrackColor: AppColor.secondary,
                  //         value: true,
                  //         onChanged: (value) {})),
                  // NotificationListTile(
                  //     title: "New Services Available",
                  //     btn: Switch.adaptive(
                  //         activeTrackColor: AppColor.secondary,
                  //         value: true,
                  //         onChanged: (value) {})),
                  // NotificationListTile(
                  //     title: "New Tips Available",
                  //     btn: Switch.adaptive(
                  //         activeTrackColor: AppColor.secondary,
                  //         value: true,
                  //         onChanged: (value) {})),
                ]))));
  }
}

class NotificationListTile extends StatelessWidget {
  const NotificationListTile({super.key, required this.title, required this.btn});

  final String title;
  final Widget btn;

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme.titleMedium!.color;
    final titleMedium = Theme.of(context).textTheme.titleMedium!.fontSize;
    return SizedBox(
      height: mediaQueryHeight(context) * 0.075,
      child: ListTile(
          title: CText(
            text: title,
            color: txtTheme,
            fontsize: titleMedium,
            textAlign: TextAlign.left,
            fontWeight: FontWeight.w500,
          ),
          trailing: Transform.scale(scale: 0.8, child: btn)),
    );
  }
}
