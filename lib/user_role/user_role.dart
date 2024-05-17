import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/modules/email_login/views/email_login_view.dart';
import 'package:video_player/video_player.dart';

import '../app/modules/user/dashboard/home/controllers/home_controller.dart';
import '../app/modules/user/dashboard/views/dashboard_view.dart';
import '../consts/app_color.dart';
import '../consts/media_query.dart';
import '../utils/shared_preferance.dart';
import '../widget/cText.dart';

class UserRoleView extends StatefulWidget {
  const UserRoleView({super.key});

  @override
  State<UserRoleView> createState() => _UserRoleViewState();
}

class _UserRoleViewState extends State<UserRoleView> {
  @override
  void initState() {
    if (Platform.isIOS) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    }
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: height * .80,
              width: width,
              child: const VideoPlayerScreen(),
            ),
          ),
          // Platform.isIOS
          //     ? Align(
          //         alignment: Alignment.topCenter,
          //         child: SizedBox(
          //           height: height * .81,
          //           width: width,
          //           child: const VideoPlayerScreen(),
          //         ),
          //       )
          //     : Align(
          //         alignment: Alignment.topCenter,
          //         child: SizedBox(
          //           height: height * 0.82,
          //           width: width,
          //           child: const VideoPlayerScreen(),
          //         ),
          //       ),
          Positioned(
            left: 0,
            right: 0,
            bottom: mediaQueryHeight(context) * 0.05,
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.1,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CText(
                        text: "Home Brigadier",
                        color: AppColor.white,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w500,
                        fontsize:
                            Theme.of(context).textTheme.headlineSmall!.fontSize,
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      CText(
                        text: "Home  Services on Demand",
                        textAlign: TextAlign.center,
                        color: AppColor.white,
                        fontsize:
                            Theme.of(context).textTheme.titleSmall!.fontSize,
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        SharedPreference.storeRole(role: "buyer");
                        Get.offAll(() => const UserDashboardView());

                        Get.put(HomeController());
                      },
                      child: SizedBox(
                        height: height * 0.18,
                        width: width * 0.4,
                        child: Card(
                          shadowColor: AppColor.greylight,
                          elevation: 15,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                  height: 40,
                                  width: 40,
                                  child:
                                      Image.asset("assets/images/ic_find.png")),
                              const CText(
                                text: "Find a Service",
                                fontWeight: FontWeight.bold,
                                fontsize: 15,
                              ),
                              const Text(
                                textAlign: TextAlign.center,
                                " I'm looking for talented people",
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13,
                                    color: AppColor.grey),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        SharedPreference.storeRole(role: "seller");
                        Get.to(() => const EmailLoginView());
                      },
                      child: SizedBox(
                        height: height * 0.18,
                        width: width * 0.4,
                        child: Card(
                          shadowColor: AppColor.greylight,
                          elevation: 15,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: Image.asset(
                                      "assets/images/ic_selling.png")),
                              const CText(
                                text: "Find Customers",
                                fontWeight: FontWeight.bold,
                                fontsize: 15,
                              ),
                              const Text(
                                "I'd like to offer my\n         Service",
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13,
                                    color: AppColor.grey),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with a video asset
    _controller = VideoPlayerController.asset('assets/video/intro_video.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized
        setState(() {});
        _controller.play(); // Play the video automatically
        _controller.setLooping(true);
      });
    // Hide the status bar
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
  }

  @override
  void dispose() {
    _controller.dispose();
    // Show the status bar when the screen is disposed
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: _controller.value.isInitialized
              ? FittedBox(
                  fit: BoxFit.fill,
                  child: SizedBox(
                    width: mediaQueryWidth(context),
                    height: mediaQueryWidth(context) /
                        _controller.value.aspectRatio,
                    child: VideoPlayer(_controller), // Your VideoPlayer widget
                  ),
                )
              : const SizedBox()),
    );
  }
}
