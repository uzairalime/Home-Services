// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:home_brigadier/consts/app_color.dart';

class CTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final double contentPadding;
  final double borderRadius;
  final Color borderColor;
  final Color? focusBorderColor;
  final Color errorBorderColor;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool? psdObs;
  final String? obscuringCharacter;
  final Widget? suffix;
  final double? margin;
  final bool? readOnly;
  final bool? enabled;
  final bool? filled;
  final Color? fillColor;
  final TextDirection? textDirection;
  final TextAlign? textAlign;
  final Iterable<String>? autofillHints;
  final TapRegionCallback? onTapOutside;
  final TextInputAction? textInputAction;
  final IconData? prefexIcon;
  final int? maxLines;
  final Function(String)? onChanged;
  final int? maxlength;
  final String? counterText;
  final bool? dense;
  final void Function()? onTap;

  const CTextField(
      {super.key,
      required this.hint,
      required this.controller,
      required this.borderColor,
      this.focusBorderColor,
      required this.borderRadius,
      this.obscuringCharacter,
      this.errorBorderColor = AppColor.red,
      this.contentPadding = 10,
      this.validator,
      this.keyboardType = TextInputType.text,
      this.psdObs,
      this.margin,
      this.suffix,
      this.autofillHints,
      this.onTapOutside,
      this.textInputAction,
      this.enabled,
      this.filled = false,
      this.fillColor,
      this.prefexIcon,
      this.readOnly,
      this.maxLines,
      this.onChanged,
      this.maxlength,
      this.counterText,
      this.textDirection,
      this.dense,
      this.textAlign,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      style: TextStyle(color: AppColor.primary),
      maxLength: maxlength,
      textAlign: textAlign ?? TextAlign.start,
      textDirection: textDirection,
      onChanged: onChanged,
      readOnly: readOnly ?? false,
      controller: controller,
      maxLines: maxLines ?? 1,
      textCapitalization: TextCapitalization.words,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofillHints: autofillHints,
      enabled: enabled,
      keyboardType: keyboardType,
      obscureText: psdObs ?? false,
      obscuringCharacter: obscuringCharacter ?? '•',

      decoration: InputDecoration(
          isDense: dense,
          counterText: '',
          prefixIcon: prefexIcon != null
              ? Icon(
                  prefexIcon,
                  color: Colors.grey.withOpacity(0.75),
                )
              : null,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.withOpacity(0.75), fontWeight: FontWeight.normal),
          contentPadding: EdgeInsets.all(contentPadding),
          border: InputBorder.none,
          suffixIcon: suffix,
          suffixIconColor: AppColor.secondary,
          filled: filled,
          fillColor: fillColor,
          enabledBorder: _outlineInputBorder(borderRadius, borderColor),
          focusedBorder: _outlineInputBorder(borderRadius, focusBorderColor ?? AppColor.secondary),
          errorBorder: _outlineInputBorder(borderRadius, errorBorderColor),
          focusedErrorBorder: _outlineInputBorder(borderRadius, errorBorderColor),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none, borderRadius: BorderRadius.circular(borderRadius))),
      validator: validator,
      textInputAction: textInputAction,
      onTapOutside: onTapOutside ?? (_) => FocusScope.of(context).unfocus()
    );
  }
}

OutlineInputBorder _outlineInputBorder(borderRadius, borderColor) {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: borderColor));
}
