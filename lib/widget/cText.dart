// custom_text
// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontsize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  const CText(
      {super.key, required this.text, this.color, this.fontsize, this.fontWeight, this.textAlign});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: color, fontSize: fontsize ?? width * 0.04, fontWeight: fontWeight ?? normal),
      textAlign: textAlign ?? TextAlign.center,
    );
  }
}

class CText2 extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontsize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  const CText2(
      {super.key, required this.text, this.color, this.fontsize, this.fontWeight, this.textAlign});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Text(
      text,
      style: TextStyle(
          color: color, fontSize: fontsize ?? width * 0.04, fontWeight: fontWeight ?? normal),
      textAlign: textAlign ?? TextAlign.center,
    );
  }
}

FontWeight bold = FontWeight.bold;
FontWeight normal = FontWeight.normal;
FontWeight w800 = FontWeight.w800;
FontWeight w500 = FontWeight.w500;
