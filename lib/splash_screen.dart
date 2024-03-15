import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:home_brigadier/connectivity_service.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/widget/cText.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = Tween<double>(begin: 0, end: 1).animate(controller);
    controller.forward();
    ConnectivityService.checkInternetConnectivity(controller: controller);
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: size.width,
        height: size.height,
        color: AppColor.white,
        padding: const EdgeInsets.all(24.0),
        child: Stack(
          children: [
            FadeTransition(
              opacity: animation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 120,
                    width: 120,
                    // color: Colors.white,
                    child: Image.asset(
                      "assets/icons/ic_splash.png",
                      fit: BoxFit.fill,
                      height: 120,
                      width: 120,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  const CText(
                    text: "Home Brigadier",
                    color: AppColor.secondary,
                    fontWeight: FontWeight.bold,
                    fontsize: 32,
                  ),
                  SizedBox(height: size.height * 0.02),
                  const CText2(
                    textAlign: TextAlign.center,
                    text: "Bringing Home Services to Your Doorstep!",
                    fontWeight: FontWeight.bold,
                    fontsize: 16,
                    color: AppColor.secondary,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: size.height * 0.05,
              left: 0,
              right: 0,
              child: const Center(
                  child: SpinKitFadingCircle(
                color: AppColor.secondary,
                size: 40.0,
              )),
            ),
          ],
        ),
      ),
    );
  }
}
