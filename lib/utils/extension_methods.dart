import 'package:flutter/material.dart';

extension DirectionExtension on Widget {
  Widget ltrDirectionality() =>
      Directionality(textDirection: TextDirection.ltr, child: this);
}
