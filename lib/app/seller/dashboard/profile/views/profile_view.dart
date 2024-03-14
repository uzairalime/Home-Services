import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/seller/dashboard/profile/invite_friend/views/invite_friend_view.dart';
import 'package:home_brigadier/app/seller/dashboard/profile/language_setting/views/language_setting_view.dart';
import 'package:home_brigadier/app/seller/dashboard/profile/privacy_policy/views/privacy_policy_view.dart';
import 'package:home_brigadier/app/seller/dashboard/views/dashboard_view.dart';
import 'package:home_brigadier/app/user/dashboard/profile/payment_setting/views/payment_setting_view.dart';
import 'package:home_brigadier/consts/static_data.dart';
import 'package:home_brigadier/generated/locales.g.dart';
import 'package:home_brigadier/user_role/user_role.dart';
import 'package:home_brigadier/utils/isolate_manager.dart';
import 'package:home_brigadier/utils/shared_preferance.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../consts/app_color.dart';
import '../../../../../consts/media_query.dart';
import '../../../../../widget/cText.dart';
import '../../../../../widget/c_filled_btn.dart';
import '../../../../user/dashboard/views/dashboard_view.dart';
import '../controllers/profile_controller.dart';

class SellerProfileView extends GetView<SellerProfileController> {
  const SellerProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(SellerProfileController());

    // final svgTheme = Theme.of(context).textTheme.titleMedium!.color;
    final txtTheme = Theme.of(context).textTheme.titleMedium!.color;
    final titleLarge = Theme.of(context).textTheme.titleLarge!.fontSize;
    final titleSmall = Theme.of(context).textTheme.titleSmall!.fontSize;
    controller.getUserInfo();
    return GetBuilder(
        init: Get.put(SellerProfileController()),
        builder: (builderContext) {
          return Scaffold(
            body: StreamBuilder(
              stream: controller.getUserInfo().asStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show shimmer while loading
                  return Center(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child:
                          const YourShimmerWidget(), // Replace YourShimmerWidget with your own shimmer widget
                    ),
                  );
                } else if (controller.userName.value.isEmpty) {
                  // Handle empty state
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  // Show actual content
                  return Scaffold(
                    appBar: AppBar(
                      leading: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/icons/ic_launcher_icon.png")),
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                      ),
                      title: CText(
                          text: LocaleKeys.dashboard_items_profile.tr,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontsize: mediaQueryHeight(context) * 0.025),
                    ),
                    body: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: mediaQueryWidth(context) * 0.30,
                          width: mediaQueryWidth(context) * 0.30,
                          decoration: const BoxDecoration(shape: BoxShape.circle),
                          child: SvgPicture.asset(
                            fit: BoxFit.fill,
                            "assets/icons/ic_person_outline.svg",
                          ),
                        ),

                        // const ProfilePic(
                        //   image: CachedNetworkImageProvider(
                        //     "https://homebrigadier.fly.dev/media/uploads/2024/03/05/working_img_57TEUSn.jpg",
                        //   ),
                        // ),
                        // Obx(() => InkWell(
                        //       borderRadius: BorderRadius.circular(50),
                        //       // onTap: () {
                        //       //   Get.to(() => const UserProfileView());
                        //       //   // controller.pickImage();
                        //       //   // Get.toNamed(Routes.USER_PROFILE);
                        //       // },
                        //       child: ProfilePic(
                        //         image:
                        //         CachedNetworkImageProvider(
                        //           "https://homebrigadier.fly.dev${controller.files[0]}",
                        //         ),
                        //       ),
                        //     )),

                        CText(
                          textAlign: TextAlign.center,
                          text:
                              "${LocaleKeys.dashboard_profile_name.tr} : ${controller.firstName.value}",
                          fontWeight: FontWeight.w500,
                          fontsize: titleLarge,
                        ),
                        CText(
                          textAlign: TextAlign.center,
                          text:
                              "${LocaleKeys.dashboard_profile_userName.tr}: ${controller.userName.value}",
                          fontWeight: FontWeight.w500,
                          fontsize: titleSmall,
                        ),
                        // CText(
                        //   textAlign: TextAlign.center,
                        //   text:
                        //       "${LocaleKeys.dashboard_profile_mobile.tr}: ${controller.mobile.value}",
                        //   fontWeight: FontWeight.w500,
                        //   fontsize: titleSmall,
                        // ),
                        const SizedBox(height: 30),
                        Expanded(
                          child: SettingListView(
                            number: controller.userName.value,
                            controller: controller,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          );
        });
  }
}

class YourShimmerWidget extends StatelessWidget {
  const YourShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 56.0, // Height of your image or profile picture
            color: Colors.grey[300], // Placeholder color for image
          ),
          const SizedBox(height: 16.0),
          Center(
            child: SizedBox(
              width: double.infinity,
              height: 100.0,
              child: CircleAvatar(
                backgroundColor: Colors.grey[300],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Container(
            width: double.infinity,
            height: 16.0,
            color: Colors.grey[300], // Placeholder color for text
          ),
          const SizedBox(height: 50),
          Expanded(
            child: Container(
              width: double.infinity,
              height: 50.0, // Height of bottom design
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.grey.shade300,
                    Colors.grey.shade200,
                    Colors.grey.shade100,
                    Colors.white,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfilePic extends StatelessWidget {
  const ProfilePic({super.key, required this.image});

  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return
        // Stack(children: [
        CircleAvatar(backgroundImage: image, radius: mediaQueryWidth(context) * 0.13);
    // Positioned(
    //     bottom: mediaQueryHeight(context) * 0.005,
    //     right: mediaQueryWidth(context) * 0.02,
    //     child: SvgPicture.asset(
    //         width: mediaQueryWidth(context) * 0.06,
    //         "assets/icons/ic_pic_edit.svg",
    //         fit: BoxFit.scaleDown))
    // ]);
  }
}

class SettingListView extends StatelessWidget {
  final String? number;
  final SellerProfileController controller;
  const SettingListView({
    super.key,
    this.number,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: ListView(physics: const BouncingScrollPhysics(), children: [
        SettingListItem(
            // onTap: () =>
            // Get.toNamed((Routes.EDIT_PROFILE_SETTING), arguments: number),
            SettingList(
                trailing: Switch.adaptive(
                  activeTrackColor: AppColor.secondary.withOpacity(0.3),
                  activeColor: AppColor.secondary,
                  value: controller.isSeller,
                  onChanged: (value) {
                    if (value == true) {
                      SharedPreference.storeRole(role: "seller");

                      controller.checkRole();
                      Get.offAll(() => const SellerDashboardView());
                    } else if (value == false) {
                      SharedPreference.storeRole(role: "buyer");

                      controller.checkRole();
                      Get.offAll(() => const UserDashboardView());
                    }
                  },
                ),
                leading: const Icon(CupertinoIcons.person),
                title: LocaleKeys.switch_mode_seller_mode.tr)),
        // Divider(
        //   color: AppColor.greylight,
        // ),
        // SettingListItem(
        //     onTap: () => Get.to(() => const NotificationSettingView()),
        //     SettingList(
        //         leading: SvgPicture.asset("assets/icons/ic_notification.svg",
        //             color: AppColor.black.withOpacity(0.5)),
        //         title: LocaleKeys.dashboard_profile_notification.tr)),
        Divider(
          color: AppColor.greylight,
        ),
        SettingListItem(
            onTap: () => Get.to(() => const PaymentSettingView()),
            SettingList(
                leading: const Icon(Icons.account_balance_wallet_outlined),
                title: LocaleKeys.dashboard_profile_payment.tr)),
        Divider(
          color: AppColor.greylight,
        ),
        SettingListItem(
            onTap: () => Get.to(() => const LanguageSettingView()),
            SettingList(
                leading: const Icon(Icons.language),
                title: LocaleKeys.dashboard_profile_language.tr)),
        Divider(
          color: AppColor.greylight,
        ),
        SettingListItem(
            onTap: () => Get.to(() => const PrivacyPolicyView()),
            SettingList(
                leading: const Icon(Icons.lock_outline),
                title: LocaleKeys.dashboard_profile_privacy_policy.tr)),
        Divider(
          color: AppColor.greylight,
        ),
        SettingListItem(
            onTap: () => Get.to(() => const InviteFriendView()),
            SettingList(
                leading: const Icon(Icons.people_alt_outlined),
                title: LocaleKeys.dashboard_profile_invite_a_friend.tr)),
        Divider(
          color: AppColor.greylight,
        ),
        SettingListItem(onTap: () async {
          await showModalBottomSheet(
              isDismissible: true,
              showDragHandle: true,
              context: context,
              builder: (BuildContext context) {
                return buildBottomSheetContent(context);
              });
        },
            SettingList(
                leading: const Icon(Icons.logout), title: LocaleKeys.dashboard_profile_logout.tr)),
        Divider(
          color: AppColor.greylight,
        ),
      ]),
    );
  }

  Widget buildBottomSheetContent(BuildContext context) {
    return Container(
        width: mediaQueryWidth(context),
        padding: EdgeInsets.symmetric(horizontal: mediaQueryWidth(context) * 0.05),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CText(
                  text: LocaleKeys.dashboard_profile__logout_warning_msg.tr,
                  fontsize: Theme.of(context).textTheme.titleLarge!.fontSize),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    Expanded(
                        flex: 1,
                        child: CFilledBtn(
                            text: LocaleKeys.dashboard_profile__logout_cancel.tr,
                            onPressed: () {
                              Get.back();
                            },
                            height: 56,
                            textColor: AppColor.secondary,
                            btnBg: AppColor.grey.withOpacity(0.3))),
                    const SizedBox(width: 10),
                    Expanded(
                        flex: 2,
                        child: CFilledBtn(
                            text: LocaleKeys.dashboard_profile__logout_yes.tr,
                            onPressed: () {
                              IsolateManager isolateManager = IsolateManager();

                              /// clear tokens
                              StaticData.accessToken = '';
                              StaticData.refreshToken = '';
                              StaticData.userName = '';
                              StaticData.firstName = '';
                              StaticData.lastName = '';
                              StaticData.mobile = '';
                              StaticData.role = '';

                              SharedPreference.clearToken();
                              SharedPreference.clearRole();

                              /// terminate isolate
                              isolateManager.terminateIsolate();
                              Get.offAll(() => const UserRoleView());
                            },
                            height: 56,
                            btnBg: AppColor.secondary))
                  ]))
            ]));
  }
}

class SettingListItem extends StatelessWidget {
  final SettingList setting;
  final Function()? onTap;

  const SettingListItem(this.setting, {super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final titleMedium = Theme.of(context).textTheme.titleMedium!.fontSize;
    final txtTheme = Theme.of(context).textTheme.titleMedium!.color;
    return ListTile(
      onTap: onTap,
      leading: setting.leading,
      title: CText(
        text: setting.title,
        fontsize: titleMedium,
        fontWeight: FontWeight.w500,
        textAlign: TextAlign.left,
        color: txtTheme,
      ),
      trailing: setting.trailing,
    );
  }
}
