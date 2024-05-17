import 'package:flutter/material.dart';
import 'package:home_brigadier/widget/cText.dart';
import 'package:lottie/lottie.dart';

class AnimationDialog extends StatefulWidget {
  final String? path;
  final String text;

  const AnimationDialog({super.key, this.path, required this.text});

  @override
  State<AnimationDialog> createState() => _AnimationDialogState();
}

class _AnimationDialogState extends State<AnimationDialog> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 3));

    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
        controller.reset();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
                width: widht * 0.3,
                height: widht * 0.3,
                fit: BoxFit.cover,
                widget.path ?? "assets/images/done.json",
                repeat: false,
                controller: controller, onLoaded: (composition) {
              controller.duration = composition.duration;
              controller.forward();
            }),
            SizedBox(
              height: height * 0.03,
            ),
            CText(
              text: widget.text,
              fontsize: widht * 0.04,
              color: Colors.green,
            )
          ],
        ),
      ),
    );
  }
}
