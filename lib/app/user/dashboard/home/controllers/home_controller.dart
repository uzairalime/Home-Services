import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/generated/locales.g.dart';
import 'package:home_brigadier/model/offer_model.dart';
import 'package:home_brigadier/model/service_model.dart';
import 'package:home_brigadier/services/apis/api_endpoints.dart';
import 'package:home_brigadier/services/apis/api_helper.dart';
import 'package:home_brigadier/utils/logger.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../../model/category_name_model.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  static HomeController get to => Get.find();
  TextEditingController search = TextEditingController();

  RxString currentWord = ''.obs;
  RxString currentCharacter = ''.obs;
  final ReceivePort _receivePort = ReceivePort();
  Isolate? _isolate;

  bool onsearchtab = false;

  //// === for hide

  bool showAppbar = true; //this is to show app bar
  ScrollController scrollBottomBarController =
      ScrollController(); // set controller on scrolling
  bool isScrollingDown = false;
  bool show = true;
  double bottomBarHeight = 75;
  double bottomBarOffset = 0;

//========================

  var initialindex = 0.obs;
  changeinitialIndex(val) {
    initialindex.value = val;
  }

  bool showserch = false;
  setshoeserch(String val) {
    if (val.isEmpty) {
      showserch = false;
    } else {
      showserch = true;
    }
    update();
  }

  final ApiHelper _apiHelper = ApiHelper();
  SfRangeValues values = const SfRangeValues(40.0, 80.0);
  bool isSearch = false;

  // late SharedPreferences prefs;

  List<CetegoryModel> categorylist = [];
  List<OfferModel> offerlist = [];
  List<ServicesModel> servicelist = [];

  setSearch() {
    isSearch = !isSearch;
    update();
  }

  final List<String> category = [
    'Cleaning',
    'Repairing',
  ];

  final List<String> imageList = [
    'https://example.com/image1.jpg',
    'https://example.com/image2.jpg',
    'https://example.com/image3.jpg',
    'https://example.com/image4.jpg',
  ];

  void searchLoop() async {}

  final keyOne = GlobalKey();
  final keyTwo = GlobalKey();
  final keyThree = GlobalKey();
  final keyFour = GlobalKey();

  @override
  onInit() {
    startLoop();
    getCategories();
    getOffers();
    getServices("");
    myScroll();

    super.onInit();
  }

  void showBottomBar() {
    show = true;
    update();
  }

  void hideBottomBar() {
    show = false;
    update();
  }

  void startLoop() async {
    _isolate = await Isolate.spawn(_loopFunction, _receivePort.sendPort);
    _receivePort.listen((message) {
      if (message is String) {
        currentCharacter.value = message;
      }
    });
  }

  static void _loopFunction(SendPort sendPort) {
    final List<String> words = [
      'cleaning',
      'painting',
      'tailor',
      'handyman',
      'pest control',
      'women salon',
      'men salon',
      'spa',
      'electricity',
      'plumbing',
      'ac repair'
    ];

    while (true) {
      // Infinite loop to restart automatically
      for (final word in words) {
        for (int i = 0; i <= word.length; i++) {
          final String subWord = word.substring(0, i);
          sendPort.send(subWord);
          sleep(Duration(milliseconds: 300)); // Adjust the delay as needed
        }
        sleep(
            Duration(milliseconds: 1000)); // Delay before the reverse animation

        for (int i = word.length - 1; i >= 0; i--) {
          final String subWord = word.substring(0, i);
          sendPort.send(subWord);
          sleep(Duration(milliseconds: 200)); // Adjust the delay as needed
        }
      }
    }
  }

  void myScroll() async {
    scrollBottomBarController.addListener(() {
      if (scrollBottomBarController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          showAppbar = false;
          hideBottomBar();
        }
      }
      if (scrollBottomBarController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          showAppbar = true;
          showBottomBar();
        }
      }
    });
  }

  getServices(String category) async {
    servicelist.clear();
    final response = await _apiHelper
        .get(category == "All" ? "user/service" : "user/service/?category=$category");
    final data = response.data;
    List<ServicesModel> serviceList =
        (data as List).map((serviceJson) => ServicesModel.fromJson(serviceJson)).toList();

    servicelist.clear();

    servicelist = serviceList;

    logger.d("length of $category  is  ${servicelist.length}");

    return servicelist;
  }

  getCategories() async {
    final response = await _apiHelper.get(CATEGORY);

    final data = response.data;

    List<CetegoryModel> categoryList = (data as List)
        .map((categoryJson) => CetegoryModel.fromJson(categoryJson))
        .toList();

    categorylist.clear();

    categorylist = categoryList;

    logger.d("categories are  $data");

    return categoryList;
  }

  getOffers() async {
    logger.d("get");
    final response = await _apiHelper.get(USER_OFFER);

    final data = response.data;


    List<OfferModel> offerList =
        (data as List).map((offerJson) => OfferModel.fromJson(offerJson)).toList();

    offerlist.clear();

    offerlist = offerList;

    logger.d("offers are => ${offerlist.length}");

    return offerlist;
  }

  void showBackDialog(context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LocaleKeys.exit_dialog_exit.tr),
          content: Text(
            LocaleKeys.exit_dialog_verify.tr,
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(LocaleKeys.exit_dialog_cancel.tr),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(LocaleKeys.exit_dialog_ok.tr),
              onPressed: () {
                Navigator.pop(context);
                if (Platform.isAndroid) {
                  SystemNavigator.pop(animated: true);
                } else if (Platform.isIOS) {
                  exit(0);
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void onClose() {
    _receivePort.close();
    _isolate?.kill();
    scrollBottomBarController.removeListener(() {});
    super.onClose();
  }
}
