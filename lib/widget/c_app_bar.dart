import 'package:flutter/material.dart';
import 'package:home_brigadier/consts/app_color.dart';

class CAppBar extends StatelessWidget {
  const CAppBar(
      {super.key,
      required this.title,
      this.actions,
      this.titleColor,
      this.leading,
      this.subtTitle});

  final String title;
  final String? subtTitle;
  final List<Widget>? actions;
  final Color? titleColor;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColor.white,
      leading: leading,
      title: Column(
        children: [
          Text(
            subtTitle ?? '',
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          Text(
            title,
            style: TextStyle(
                color: Theme.of(context).textTheme.titleMedium!.color,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: actions,
    );
  }
}
