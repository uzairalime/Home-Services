import 'package:flutter/material.dart';

class AppColor {
  static const Color primary = Color(0xff8846e8);
  static const Color secondary = Color(0xff7313fe);

  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color red = Colors.red;
  static const Color grey = Colors.grey;
  static Color greylight = Colors.grey.withOpacity(0.3);
  static const Color darkTile = Color(0xff1F222A);
  static const Color kDarkBlue = Color(0xFF090943);

  static const LinearGradient box1 = LinearGradient(
    transform: GradientRotation(25),
    colors: [Color(0xff8846e8), Color(0xff7313fe)],
  );

  static const LinearGradient box2 = LinearGradient(
    transform: GradientRotation(25),
    colors: [Color(0xffFF5A72), Color(0xffFF7F92)],
  );

  static const LinearGradient box3 = LinearGradient(
    transform: GradientRotation(25),
    colors: [Color(0xffFFAA36), Color(0xffFC980A)],
  );
  static const LinearGradient box4 = LinearGradient(
    transform: GradientRotation(25),
    colors: [Color(0xff26C3A3), Color(0xff34DCBA)],
  );

  static const LinearGradient primaryGradient = LinearGradient(
    transform: GradientRotation(25),
    colors: [primary, secondary],
  );
}
