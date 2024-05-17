import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  final String title;
  final Widget child;

  const WelcomeScreen(this.title, this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          child,
          Text(title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              )),
        ]);
  }
}
