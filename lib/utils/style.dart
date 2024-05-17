import 'package:flutter/material.dart';
import 'package:home_brigadier/consts/app_color.dart';

// font weights
FontWeight bold = FontWeight.bold;
FontWeight normal = FontWeight.normal;
FontWeight bold3 = FontWeight.w300;
FontWeight bold6 = FontWeight.w600;
FontWeight bold1 = FontWeight.w100;
FontWeight bold2 = FontWeight.w200;
FontWeight bold4 = FontWeight.w400;
FontWeight bold5 = FontWeight.w500;
FontWeight bold7 = FontWeight.w700;
FontWeight bold8 = FontWeight.w800;
FontWeight bold9 = FontWeight.w900;

double defaultRadius = 12;
double defaultPadding = 25;

double referenceScreenWidth = 375.0;
double bodysize = 20;

class AppTextStyle {
  BuildContext? context;

  static setReferenceScreenWidth(double width) {
    referenceScreenWidth = width;
  }

  static const TextStyle defaultStyle = TextStyle(
    fontSize: 16.0, // Default font size
    color: Colors.black, // Default text color
  );

  static TextStyle headingStyle(BuildContext context) {
    return defaultStyle.copyWith(
      fontSize: adaptiveFontSize(context, 24.0),
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle subheadingStyle(BuildContext context) {
    return defaultStyle.copyWith(
      fontSize: adaptiveFontSize(context, 18.0),
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle bodyStyle(BuildContext context) {
    return defaultStyle.copyWith(
      fontSize: adaptiveFontSize(context, 16.0),
    );
  }

  static TextStyle smallStyle(BuildContext context) {
    return defaultStyle.copyWith(
      fontSize: adaptiveFontSize(context, 14.0),
    );
  }
}

double adaptiveFontSize(BuildContext context, double fontSize) {
  double screenWidth = MediaQuery.of(context).size.width;
  return (fontSize * screenWidth) / referenceScreenWidth;
}

// sizes

double size22 = 22;
double size16 = 16;
double size18 = 18;
double size32 = 32;
double size12 = 12;

// appbar
TextStyle appbar = TextStyle(fontSize: size22, fontWeight: bold6, color: AppColor.black);

// unselected tab
TextStyle unselectedtab = TextStyle(fontWeight: bold5, fontSize: 14, color: AppColor.primary);

// selected tab
TextStyle selectedtab = TextStyle(fontWeight: bold, fontSize: 14, color: AppColor.white);

// tab bar styling

double tabbarradius = 40;

EdgeInsets buttonmargin = const EdgeInsets.symmetric(horizontal: 20);

EdgeInsets tabbatcontentPaddiing = const EdgeInsets.symmetric(vertical: 2, horizontal: 24);

double appbariconsize = 24;

// dark mode check
bool isDarkmode(BuildContext context) =>
    MediaQuery.of(context).platformBrightness == Brightness.dark;

// header action padding

EdgeInsets appbaractionpadding = const EdgeInsets.only(top: 12, left: 12, right: 18, bottom: 12);
