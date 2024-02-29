import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/modules/dashboard/home/all_services/selected_category/category_item/house_cleaning/controllers/booking_controller.dart';
import 'package:home_brigadier/services/apis/toast.dart';
import 'package:home_brigadier/utils/style.dart';
import 'package:home_brigadier/widget/cText.dart';
import 'package:home_brigadier/widget/c_filled_btn.dart';

import '../../../../../../../../../consts/media_query.dart';

class PaymentView extends GetView<BookingController> {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    // final widht = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    final controller = Get.put(BookingController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment Methods",
          style: appbar,
        ),
      ),
      body: Center(
        child: SizedBox(
          width: mediaQueryWidth(context) * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CText(
                  textAlign: TextAlign.start, text: 'Please select a payment refund method'),
              const SizedBox(height: 20),
              Expanded(
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
              CButton(
                text: "Continue",
                btnwidth: mediaQueryWidth(context) * 0.9,
                ontab: () {
                  print("========================${controller.selectedRadio.value}");

                  _proceedPayemtn(context);
                },
              ),
              SizedBox(
                height: mediaQueryHeight(context) * 0.02,
              )
            ],
          ),
        ),
      ),
    );
  }

  _proceedPayemtn(BuildContext context) {
    if (controller.selectedRadio.value == 0) {
    } else {
      showsnackbar("this time only stripe available");
    }
  }
}

class PaymentModel {
  final String? title;
  final String? subtitle;
  final String? path;

  PaymentModel(this.title, this.subtitle, this.path);

  static List<PaymentModel> list = [
    PaymentModel("Stripe", "Special promo only today!", "assets/icons/stripeicon.svg"),
    PaymentModel("Paypal", "Special promo only today!", "assets/icons/ic_paypal.svg"),
    PaymentModel("Google pay", "Special promo only today!", "assets/icons/ic_gmail.svg"),
    PaymentModel("Apple Pay", "Special promo only Valid today", "assets/icons/apple_ic.svg"),
    PaymentModel("Master card", "Special promo only today!", "assets/icons/ic_mastercard.svg"),
    PaymentModel("Cash Money", "Special promo only today!", "assets/icons/ic_wallet_filled.svg"),
  ];
}
