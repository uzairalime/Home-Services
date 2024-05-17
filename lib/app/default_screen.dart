import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/generated/locales.g.dart';
import 'package:home_brigadier/widget/cText.dart';

class DefaultScreen extends StatefulWidget {
  final String? msg;
  const DefaultScreen({super.key, this.msg});

  @override
  State<DefaultScreen> createState() => _DefaultScreenState();
}

class _DefaultScreenState extends State<DefaultScreen> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CText(
          text: LocaleKeys.connectivity_connection_error.tr,
          fontsize: Theme.of(context).textTheme.headlineSmall!.fontSize,
          color: AppColor.black,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.msg ?? LocaleKeys.connectivity_no_internet.tr),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  setState(() {
                    isCheck = true;
                  });
                  var connectivityResult =
                      await Connectivity().checkConnectivity();
                  if (!connectivityResult.contains(ConnectivityResult.none)) {
                    Get.back();
                  }
                } finally {
                  setState(() {
                    isCheck = false;
                  });
                }
              },
              child: !isCheck
                  ? Text(LocaleKeys.connectivity_refresh.tr)
                  : const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
