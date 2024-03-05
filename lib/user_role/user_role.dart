import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/routes/app_pages.dart';
import 'package:home_brigadier/app/user/dashboard/home/controllers/home_controller.dart';
import 'package:home_brigadier/app/user/dashboard/views/dashboard_view.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/utils/shared_preferance.dart';
import 'package:home_brigadier/widget/cText.dart';
import 'package:video_player/video_player.dart';

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
      body: Center(
        child: Container(
          height: height,
          width: width,
          color: Colors.white.withOpacity(0.8),
          // color: Colors.amber,
          child: Stack(
            children: [
              Container(
                height: height * 0.8,
                width: width,
                color: Colors.grey.withOpacity(0.3),
                child: const VideoPlayerWidget(
                    videoUrl:
                        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: height * 0.2,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15), topRight: Radius.circular(15))),
                ),
              ),
              SizedBox(
                // color: Colors.white.withOpacity(0.9),
                height: height,
                width: width,
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.6,
                    ),
                    CText(
                      text: "Home Bragedier",
                      fontWeight: FontWeight.bold,
                      fontsize: height * 0.035,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    CText(
                      text: "Home services.\nOn Demand",
                      fontWeight: FontWeight.bold,
                      fontsize: height * 0.02,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            SharedPreference.storeRole(role: "buyer");
                            Get.off(() => const UserDashboardView());

                            Get.put(HomeController());
                          },
                          child: Container(
                            height: height * 0.18,
                            width: width * 0.4,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 1),
                              ),
                            ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: Image.asset("assets/images/ic_find.png")),
                                const CText(
                                  text: "Find a Service",
                                  fontWeight: FontWeight.bold,
                                  fontsize: 15,
                                ),
                                const Text(
                                  " I'm looking for talanted\n   people to work with",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 13,
                                      color: AppColor.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            SharedPreference.storeRole(role: "seller");
                            Get.toNamed(Routes.EMAIL_LOGIN);
                          },
                          child: Container(
                            height: height * 0.18,
                            width: width * 0.4,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 1),
                              ),
                            ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: Image.asset("assets/images/ic_selling.png")),
                                const CText(
                                  text: "Selling a Service",
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
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({super.key, required this.videoUrl});

  @override
  // ignore: library_private_types_in_public_api
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    // ignore: deprecated_member_use
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      showControls: false,
      aspectRatio: 20 / 40,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Chewie(
            controller: _chewieController,
          ),
        ));
  }
}
