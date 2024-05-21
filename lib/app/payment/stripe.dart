import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../generated/locales.g.dart';
import '../../services/apis/toast.dart';
import '../../utils/logger.dart';

class PaymentController extends GetxController {
  static PaymentController get to => Get.find();
  Map<String, dynamic>? paymentIntent;

  Future<void> makePayment(
      {required var intents,
      required context,
      required String amount,
      String? name}) async {
    try {
      // STEP 1: Create Payment Intent
      paymentIntent =
          await createPaymentIntent(amount: amount, currency: 'AED');

      var gpay = PaymentSheetGooglePay(
        merchantCountryCode: "UAE",
        currencyCode: "AED",
        testEnv: false, // Set to false for production mode
        amount: amount,
        buttonType: PlatformButtonType.pay,
      );

      // STEP 2: Initialize Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          style: ThemeMode.light,
          customerEphemeralKeySecret: intents["ephemeral_key"],
          billingDetails: const BillingDetails(),
          applePay: const PaymentSheetApplePay(merchantCountryCode: "AED"),
          merchantDisplayName: name ?? "",
          customerId: intents["customer_id"],
          googlePay: gpay,
        ),
      );

      // STEP 3: Display Payment sheet
      displayPaymentSheet(context);
    } catch (err) {
      logger.d("error========= $err");
      showSnackBar(LocaleKeys.location_screen_something_went_wrong.tr, true);
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(
      {required String amount, required String currency}) async {
    try {
      // Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      // Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      );

      logger.d("Intent Res is here ${json.decode(response.body)}");
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<void> displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      showSnackBar(LocaleKeys.snack_bar_successfully_payment.tr);

      paymentIntent = null;
    } on StripeException catch (e) {
      logger.d("result is error $e");
      // Handle Stripe exceptions here
      // For example, show an AlertDialog
    } catch (e) {
      logger.d("result is error $e");
      // Handle other exceptions here
    }
  }

  String calculateAmount(String amount) {
    final calculatedAmout = (double.parse(amount).toInt()) * 100;
    return calculatedAmout.toString();
  }

// Map<String, dynamic>? paymentIntent;
  //
  // Future<void> makePayment(
  //     {required var intents, required context, required String amount}) async {
  //   try {
  //     //STEP 1: Create Payment Intent
  //     paymentIntent = await createPaymentIntent(amount, 'INR');
  //
  //     var applePay = const PaymentSheetApplePay(
  //         merchantCountryCode: 'IND', buttonType: PlatformButtonType.pay);
  //
  //     var gpay = PaymentSheetGooglePay(
  //         merchantCountryCode: "GB",
  //         currencyCode: "GBP",
  //         testEnv: true,
  //         amount: amount,
  //         buttonType: PlatformButtonType.pay);
  //
  //     var paymentIntentId = paymentIntent!['id'];
  //     logger.d("payment id is $paymentIntentId");
  //
  //     //STEP 2: Initialize Payment Sheet
  //     await Stripe.instance.initPaymentSheet(
  //         paymentSheetParameters: SetupPaymentSheetParameters(
  //             paymentIntentClientSecret: paymentIntent!['client_secret'], //Got,
  //             style: ThemeMode.light,
  //             customerEphemeralKeySecret: intents["ephemeral_key"],
  //             billingDetails: const BillingDetails(),
  //             merchantDisplayName: 'Muhammad ',
  //             customerId: intents["customer_id"],
  //             googlePay: gpay,
  //             applePay: applePay));
  //
  //     //STEP 3: Display Payment sheet
  //     displayPaymentSheet(context);
  //   } catch (err) {
  //     logger.d("error========= $err");
  //     showSnackBar(LocaleKeys.location_screen_something_went_wrong.tr, true);
  //   }
  // }
  //
  // createPaymentIntent(String amount, String currency) async {
  //   try {
  //     //Request body
  //     Map<String, dynamic> body = {
  //       'amount': calculateAmount(amount),
  //       'currency': currency,
  //       "payment_method_types[]": "card",
  //     };
  //
  //     //Make post request to Stripe
  //     var response = await http.post(
  //       Uri.parse('https://api.stripe.com/v1/payment_intents'),
  //       headers: {
  //         'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
  //         'Content-Type': 'application/x-www-form-urlencoded'
  //       },
  //       body: body,
  //     );
  //     logger.d("Intent Res is here ${json.decode(response.body)}");
  //     return json.decode(response.body);
  //   } catch (err) {
  //     throw Exception(err.toString());
  //   }
  // }
  //
  // displayPaymentSheet(BuildContext context) async {
  //   try {
  //     await Stripe.instance.presentPaymentSheet();
  //     showSnackBar(LocaleKeys.snack_bar_successfully_payment.tr);
  //
  //     paymentIntent = null;
  //   } on StripeException catch (e) {
  //     logger.d("result is error $e");
  //     const AlertDialog(
  //       content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Row(
  //             children: [
  //               Icon(
  //                 Icons.cancel,
  //                 color: Colors.red,
  //               ),
  //               Text("Payment Failed"),
  //             ],
  //           ),
  //         ],
  //       ),
  //     );
  //   } catch (e) {
  //     logger.d("result is error $e");
  //   }
  // }
  //
  // calculateAmount(String amount) {
  //   final calculatedAmout = (double.parse(amount).toInt()) * 100;
  //   return calculatedAmout.toString();
  // }
}
