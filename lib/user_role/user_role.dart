import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../app/routes/app_pages.dart';
import '../app/user/dashboard/home/controllers/home_controller.dart';
import '../app/user/dashboard/views/dashboard_view.dart';
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
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: height * 0.82,
              width: width,
              child: const VideoPlayerWidget(),
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Container(
          //     height: height * 0.25, // Adjusted height
          //     decoration: const BoxDecoration(
          //         color: AppColor.white,
          //         borderRadius: BorderRadius.only(
          //             topLeft: Radius.circular(25),
          //             topRight: Radius.circular(25))),
          //     child: Align(
          //       alignment: Alignment.bottomCenter,
          //       child: SizedBox(
          //         height: height * 0.13,
          //         child: Column(
          //           mainAxisSize: MainAxisSize.max,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             CText(
          //               text: "Home Brigadier",
          //               color: AppColor.secondary,
          //               textAlign: TextAlign.center,
          //               fontWeight: FontWeight.w500,
          //               fontsize:
          //                   Theme.of(context).textTheme.headlineSmall!.fontSize,
          //             ),
          //             SizedBox(
          //               height: height * 0.01,
          //             ),
          //             CText(
          //               text: "Home  Services on Demand",
          //               textAlign: TextAlign.center,
          //               color: AppColor.primary,
          //               fontsize:
          //                   Theme.of(context).textTheme.titleSmall!.fontSize,
          //             )
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

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
                                " I'm looking for talanted people",
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
                        Get.toNamed(Routes.EMAIL_LOGIN);
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

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  @override
  void initState() {
    videoPlayerController =
        VideoPlayerController.asset("assets/video/intro_video.mp4");

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      showControls: false,
      allowFullScreen: true,
      aspectRatio: 0.62,
      autoPlay: true,
      looping: true,
    );
    setState(() {});

    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: chewieController,
    );
  }
}
