import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/app/routes/app_pages.dart';
import 'package:home_brigadier/consts/app_color.dart';
import 'package:home_brigadier/widget/cText.dart';
import 'package:home_brigadier/widget/c_filled_btn.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SizedBox(
      width: widht,
      height: height,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: height * 0.1,
            ),
            Image.asset(
              "assets/images/new_img.png",
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: height * 0.03,
            ),
            CText(
              text: "Let's You In",
              fontWeight: FontWeight.bold,
              fontsize: widht * 0.08,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            const CIconButton(
              path: 'assets/icons/fb_ic.svg',
              text: "Continue with Facebook",
            ),
            SizedBox(
              height: height * 0.025,
            ),
            const CIconButton(
              path: 'assets/icons/ic_gmail.svg',
              text: "Continue with Google",
            ),
            SizedBox(
              height: height * 0.025,
            ),
            const CIconButton(
              path: 'assets/icons/apple_ic.svg',
              text: "Continue with Apple",
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                    child: Divider(
                  thickness: 1,
                  color: Colors.grey.withOpacity(0.2),
                )),
                SizedBox(
                  width: widht * 0.02,
                ),
                const CText(
                  text: "or",
                  color: Colors.black,
                ),
                SizedBox(
                  width: widht * 0.02,
                ),
                Expanded(
                    child: Divider(
                  thickness: 1,
                  color: Colors.grey.withOpacity(0.2),
                )),
              ],
            ),
            const Spacer(
              flex: 1,
            ),
            CButton(
              text: 'Login with Phone',
              fontsize: widht * 0.04,
              fontWeight: FontWeight.w500,
              shadow: true,
              ontab: () => Get.toNamed(Routes.EMAIL_LOGIN),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CText(
                  text: "Don't have an account?",
                  color: Colors.grey.withOpacity(0.75),
                  fontsize: widht * 0.03,
                ),
                SizedBox(
                  width: widht * 0.02,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.SIGNUP);
                  },
                  child: CText(
                    text: "Sign up",
                    color: AppColor.primary,
                    fontsize: widht * 0.03,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}

class CIconButton extends StatelessWidget {
  const CIconButton({
    super.key,
    this.widht,
    this.height,
    this.onTap,
    required this.path,
    this.text,
  });

  final double? widht;
  final double? height;
  final Function()? onTap;
  final String path;
  final String? text;

  @override
  Widget build(BuildContext context) {
    final widht1 = MediaQuery.of(context).size.width;
    final height1 = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        onTap;
      },
      child: Container(
        width: widht ?? widht1,
        height: height ?? height1 * 0.065,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.grey.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              path,
              fit: BoxFit.cover,
              width: 21,
              height: 21,
            ),
            SizedBox(
              width: widht1 * 0.03,
            ),
            CText(
              text: text ?? "",
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
