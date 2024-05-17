// import 'package:flutter_contacts/contact.dart';
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
          withProperties: true, withPhoto: true);
    }
    return null;

    //print(contactsList!.length);
  }

  whatsappLauncher(number) async {
    String url = 'https://wa.me/$number';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  launchMessenger() async {
    String messengerUrl = 'https://m.me/';

    if (await canLaunchUrl(Uri.parse(messengerUrl))) {
      await launchUrl(Uri.parse(messengerUrl));
    } else {
      print("Couldn't launch Messenger.");
    }
  }

  sendSMS(number) async {
    String phoneNumber = number; // Replace with the recipient's phone number
    String message =
        'Hello, this is a test message!'; // Replace with your message

    final String smsUrl = 'sms:$phoneNumber?body=$message';

    if (await canLaunchUrl(Uri.parse(smsUrl))) {
      await launchUrl(Uri.parse(smsUrl));
    } else {
      print("Couldn't launch SMS.");
    }
  }
  // void launchWhatsApp(number) async {
  //   String whatsappUrl = "whatsapp://send?phone=$number";

  //   if (await canLaunch(whatsappUrl)) {
  //     await launch(whatsappUrl);
  //   } else {
  //     print("Couldn't open WhatsApp.");
  //   }
  // }

  final count = 0.obs;

  void increment() => count.value++;
}
