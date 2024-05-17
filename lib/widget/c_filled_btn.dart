import 'package:flutter/material.dart';
import 'package:home_brigadier/consts/app_color.dart';

class CFilledBtn extends StatelessWidget {
  const CFilledBtn(
      {super.key,
      required this.text,
      this.fontSize,
      this.textColor,
      this.btnBg,
      required this.onPressed,
      this.height,
      this.width});

  final String text;
  final double? fontSize;
  final Color? textColor;
  final Color? btnBg;
  final VoidCallback onPressed;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: btnBg,
          ),
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
            ),
          )),
    );
  }
}

class CButton extends StatelessWidget {
  final String text;
  final Function()? ontab;
  final double? btnwidth;
  final double? btnheight;
  final Color? txtcolor;
  final Color? bgcolor;
  final double? fontsize;
  final double? borderradius;
  final bool shadow;
  final Gradient? gradient;
  final FontWeight? fontWeight;

  const CButton(
      {super.key,
      required this.text,
      this.btnwidth,
      this.btnheight,
      this.txtcolor,
      this.bgcolor,
      this.fontsize,
      this.ontab,
      this.borderradius,
      this.shadow = false,
      this.fontWeight,
      this.gradient});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
          gradient: gradient,
          boxShadow: [
            if (shadow)
              BoxShadow(
                  blurRadius: 3,
                  // ..color: Colors.grey.withOpacity(0.25),
                  color: AppColor.secondary.withOpacity(0.3),
                  spreadRadius: 1,
                  offset: const Offset(0, 2))

            // change background color
          ],
          color: bgcolor ?? AppColor.secondary,
          borderRadius: BorderRadius.circular(borderradius ?? 8)),
      width: btnwidth ?? width,
      height: btnheight ?? height * 0.07,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: ontab,
          child: Center(
            child: Text(
              text,

              // change text color
              style: TextStyle(
                  fontWeight: fontWeight ?? FontWeight.normal,
                  color: txtcolor ?? AppColor.white,
                  fontSize: fontsize ?? width * 0.04),
            ),
          ),
        ),
      ),
    );
  }
}
