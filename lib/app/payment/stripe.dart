// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/services/apis/toast.dart';
import 'package:home_brigadier/utils/logger.dart';
import 'package:http/http.dart' as http;

class PaymetController extends GetxController {
  static PaymetController get to => Get.find();

  Map<String, dynamic>? paymentIntent;

  Future<void> makePayment(BuildContext context, String payment, String intent) async {
    try {
      //STEP 1: Create Payment Intent
      paymentIntent = await createPaymentIntent(payment, 'INR');

      var applePay = PaymentSheetApplePay(
        merchantCountryCode: 'IND',
      );

      var gpay =
          PaymentSheetGooglePay(merchantCountryCode: "IND", currencyCode: "INR", testEnv: true);

      var paymentIntentId = paymentIntent!['id'];
      logger.d("payment id is ${paymentIntentId}");

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'], //Got,
              style: ThemeMode.light,
              merchantDisplayName: 'Muhammad ',
              googlePay: gpay,
              applePay: applePay));

      //STEP 3: Display Payment sheet
      displayPaymentSheet(context);
    } catch (err) {
      logger.d("error========= $err");
      showsnackbar("some thing went wrong", true);
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        "payment_method_types[]": "card",
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      logger.d("res is here ${json.decode(response.body)}");
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet();

      showsnackbar(" successfully payment completed");

      // showDialog(
      //     context: context,
      //     builder: (_) => AlertDialog(
      //           content: Column(
      //             mainAxisSize: MainAxisSize.min,
      //             children: const [
      //               Icon(
      //                 Icons.check_circle,
      //                 color: Colors.green,
      //                 size: 100.0,
      //               ),
      //               SizedBox(height: 10.0),
      //               Text("Payment Successful!"),
      //             ],
      //           ),
      //         ));

      paymentIntent = null;
    } on StripeException catch (e) {
      logger.d("result is error $e");
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      logger.d("result is error $e");
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (double.parse(amount).toInt()) * 100;
    return calculatedAmout.toString();
  }
}
