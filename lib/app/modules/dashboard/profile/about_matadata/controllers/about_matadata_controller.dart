import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../model/meta_data.dart';
import '../../../../../../services/apis/api_endpoints.dart';
import '../../../../../../services/apis/api_helper.dart';

class AboutMatadataController extends GetxController {
  late ApiHelper apiHelper;
  @override
  void onInit() {
    apiHelper = ApiHelper();
    getUsermetadata();
    super.onInit();
  }

  Future<MetaDataModel> getUsermetadata() async {
    final response = await apiHelper.get(METADATA);
    return MetaDataModel.fromJson(response.data);
  }

  dail_launcher(phonenumber) async {
    final url = Uri.parse('tel:$phonenumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  launchLinkedInProfileLink(linkdin) async {
    if (await canLaunchUrl(linkdin)) {
      await launchUrl(linkdin);
    } else {
      throw 'Could not launch $linkdin';
    }
  }

  mail_launcher(email) async {
    final url = Uri.parse('mailto:$email');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  whatsapplauncher(number) async {
    String url = 'https://wa.me/$number';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  facebooklaauncher(facebook) async {
    if (await canLaunchUrl(facebook)) {
      await launchUrl(facebook);
    } else {
      // Handle the case where the Facebook app or browser cannot be launched
      throw 'Could not launch $facebook';
    }
  }

  instagramlauncher(instagram) async {
    if (await canLaunchUrl(instagram)) {
      await launchUrl(instagram);
    } else {
      // Handle the case where the Instagram app or browser cannot be launched
      throw 'Could not launch $instagram';
    }
  }

  twitterlauncher(twitterUsername) async {
    // Using the twitter:// URL scheme
    if (await canLaunchUrl(twitterUsername)) {
      await launchUrl(twitterUsername);
    } else {
      // Handle the case where the Twitter app is not installed
      throw 'Could not launch $twitterUsername';
    }
  }

  dynamic youtubelaunch(youtubelink) async {
    if (await canLaunchUrl(youtubelink)) {
      await launchUrl(youtubelink);
    } else {
      // Handle the case where the YouTube app or browser cannot be launched
      throw 'Could not launch $youtubelink';
    }
  }
}
