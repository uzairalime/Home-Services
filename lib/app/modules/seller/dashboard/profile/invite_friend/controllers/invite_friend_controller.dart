// import 'package:flutter_contacts/contact.dart';
import 'dart:io';

import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class InviteFriendController extends GetxController {
  @override
  onInit() {
    getPhoneData();
    super.onInit();
  }

  Future<List<Contact>?> getPhoneData() async {
    // List<Contact>? contactsList;

    if (await FlutterContacts.requestPermission()) {
      return await FlutterContacts.getContacts(
          withProperties: true,
          withPhoto: true,
          deduplicateProperties: false,
          withThumbnail: true);
    }
    return null;

    //print(contactsList!.length);
  }

  whatsappLauncher(String number) async {
    if (Platform.isAndroid || Platform.isIOS) {
      final appId = Platform.isAndroid
          ? 'com.example.home_services'
          : 'com.example.home_services';
      final appUrl = Uri.parse(
        Platform.isAndroid
            ? "https://play.google.com/store/apps/details?id=$appId"
            : "https://apps.apple.com/app/id$appId",
      );

      String message = appUrl.toString();

      String encodedMessage = Uri.encodeComponent(message);

      String url = 'https://wa.me/$number/?text=$encodedMessage';

      if (await canLaunchUrl(Uri.parse(url))) {
        print(url);
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  launchMessenger(number, String name) async {
    if (Platform.isAndroid || Platform.isIOS) {
      final appId = Platform.isAndroid
          ? 'com.example.home_services'
          : 'com.example.home_services';
      final appUrl = Uri.parse(
        Platform.isAndroid
            ? "https://play.google.com/store/apps/details?id=$appId"
            : "https://apps.apple.com/app/id$appId",
      );

      String message = appUrl.toString();

      // Encode the message to ensure special characters are properly handled in the URL
      String encodedMessage = Uri.encodeComponent(message);

      // Construct the Messenger URL with the encoded message
      String messengerUrl = 'https://m.me/$name/?text=$encodedMessage';
      print(messengerUrl);

      if (await canLaunchUrl(Uri.parse(messengerUrl))) {
        await launchUrl(Uri.parse(messengerUrl));
      } else {
        print("Couldn't launch Messenger.");
      }
    }
  }

  sendSMS(number) async {
    String phoneNumber = number;
    if (Platform.isAndroid || Platform.isIOS) {
      final appId = Platform.isAndroid
          ? 'com.example.home_services'
          : 'com.example.home_services';
      final appUrl = Uri.parse(
        Platform.isAndroid
            ? "https://play.google.com/store/apps/details?id=$appId"
            : "https://apps.apple.com/app/id$appId",
      );

      String message = appUrl.toString();

      final String smsUrl = 'sms:$phoneNumber?body=$message';

      if (await canLaunchUrl(Uri.parse(smsUrl))) {
        await launchUrl(Uri.parse(smsUrl));
      } else {
        print("Couldn't launch SMS.");
      }
    }
  }

  final count = 0.obs;

  void increment() => count.value++;
}
