// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AppTextStyles {
  final TextStyle? displayLarge;
  final TextStyle? displayMedium;
  final TextStyle? displaySmall;
  final TextStyle? headlineLarge;
  final TextStyle? headlineMedium;
  final TextStyle? headlineSmall;
  final TextStyle? titleLarge;
  final TextStyle? titleMedium;
  final TextStyle? titleSmall;
  final TextStyle? bodyLarge;
  final TextStyle? bodyMedium;
  final TextStyle? bodySmall;
  final TextStyle? labelLarge;
  final TextStyle? labelMedium;
  final TextStyle? labelSmall;

  AppTextStyles({
    this.displayLarge,
    this.displayMedium,
    this.displaySmall,
    this.headlineLarge,
    this.headlineMedium,
    this.headlineSmall,
    this.titleLarge,
    this.titleMedium,
    this.titleSmall,
    this.bodyLarge,
    this.bodyMedium,
    this.bodySmall,
    this.labelLarge,
    this.labelMedium,
    this.labelSmall,
  });

  factory AppTextStyles.build(BuildContext context) {
    double scaleFactor = MediaQuery.of(context).textScaleFactor;

    return AppTextStyles(
      displayLarge: TextStyle(fontSize: 32.0 * scaleFactor),
      displayMedium: TextStyle(fontSize: 24.0 * scaleFactor),
      displaySmall: TextStyle(fontSize: 18.0 * scaleFactor),
      headlineLarge:
          TextStyle(fontSize: 28.0 * scaleFactor, fontWeight: FontWeight.bold),
      headlineMedium:
          TextStyle(fontSize: 20.0 * scaleFactor, fontWeight: FontWeight.bold),
      headlineSmall:
          TextStyle(fontSize: 16.0 * scaleFactor, fontWeight: FontWeight.bold),
      titleLarge:
          TextStyle(fontSize: 24.0 * scaleFactor, fontWeight: FontWeight.bold),
      titleMedium:
          TextStyle(fontSize: 18.0 * scaleFactor, fontWeight: FontWeight.bold),
      titleSmall:
          TextStyle(fontSize: 16.0 * scaleFactor, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 16.0 * scaleFactor),
      bodyMedium: TextStyle(fontSize: 14.0 * scaleFactor),
      bodySmall: TextStyle(fontSize: 12.0 * scaleFactor),
      labelLarge: TextStyle(fontSize: 14.0 * scaleFactor),
      labelMedium: TextStyle(fontSize: 12.0 * scaleFactor),
      labelSmall: TextStyle(fontSize: 10.0 * scaleFactor),
    );
  }
}
