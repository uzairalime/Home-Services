import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/modules/dashboard/profile/payment_setting/controllers/payment_setting_controller.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/consts/media_query.dart';
import 'package:home_brigadier/generated/locales.g.dart';
import 'package:home_brigadier/widget/cText.dart';

import 'card_adding/views/card_view.dart';

class PaymentSettingView extends GetView<PaymentSettingController> {
  const PaymentSettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleMedium = Theme.of(context).textTheme.titleMedium!.fontSize;
    Get.put(PaymentSettingController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: CText(
          text: LocaleKeys.dashboard_profile__payment_payment_method.tr,
          fontsize: titleMedium,
          fontWeight: FontWeight.w500,
          color: AppColor.black,
        ),
      ),
      body: Center(
        child: SizedBox(
          width: mediaQueryWidth(context) * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CText(textAlign: TextAlign.start, text: ''),
              const SizedBox(height: 20),
              SizedBox(
                height: mediaQueryHeight(context) * 0.4,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: PaymentModel.list.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Obx(
                        () => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            dense: false,
                            leading: SizedBox(
                              height: 70,
                              width: 70,
                              child: SvgPicture.asset(
                                PaymentModel.list[index].path.toString(),
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            title: CText(
                              fontWeight: FontWeight.bold,
                              text: PaymentModel.list[index].title.toString(),
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
                      ),
                    );
                  },
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                      dense: false,
                      leading: SizedBox(
                        height: 70,
                        width: 70,
                        child: SvgPicture.asset(
                          "assets/icons/ic_wallet_filled.svg",
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      title: CText(
                        fontWeight: FontWeight.bold,
                        text: LocaleKeys.dashboard_profile__payment_add_a_card.tr,
                        textAlign: TextAlign.start,
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: InkWell(
                          onTap: () {
                            // Get.to(AddingCardView());
                            Get.to(() => AddingCardView());
                          },
                          child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  color: AppColor.grey.withOpacity(0.2), shape: BoxShape.circle),
                              child: Center(child: Icon(Icons.add))),
                        ),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentModel {
  final String? title;
  final String? subtitle;
  final String? path;

  PaymentModel(this.title, this.subtitle, this.path);

  static List<PaymentModel> list = [
    PaymentModel(LocaleKeys.dashboard_profile__payment_google_pay.tr, "Special promo only today!",
        "assets/icons/ic_gmail.svg"),
    PaymentModel(LocaleKeys.dashboard_profile__payment_apple_pay.tr,
        "Special promo only Valid today", "assets/icons/apple_ic.svg"),
    PaymentModel(LocaleKeys.dashboard_profile__payment_master_card.tr, "Special promo only today!",
        "assets/icons/ic_mastercard.svg"),
    PaymentModel(LocaleKeys.dashboard_profile__payment_add_a_card.tr, "Special promo only today!",
        "assets/icons/ic_wallet_filled.svg"),
  ];
}
