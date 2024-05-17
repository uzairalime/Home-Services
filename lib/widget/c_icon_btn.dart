import 'package:flutter/material.dart';

class CIconBtn extends StatelessWidget {
  const CIconBtn({super.key, required this.onPressed, required this.child});

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onPressed, icon: child);
  }
}
