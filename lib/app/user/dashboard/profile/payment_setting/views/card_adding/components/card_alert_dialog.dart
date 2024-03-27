import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_brigadier/generated/locales.g.dart';

class CardAlertDialog extends StatelessWidget {
  const CardAlertDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: 80.0,
          top: -90.0,
          child: Image.asset(
            'assets/images/checked.png',
            height: 90,
            width: 90,
          ),
        ),
        Positioned(
          right: -40.0,
          top: -40.0,
          child: InkResponse(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.close, color: Colors.white),
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                LocaleKeys.dashboard_profile__payment__add_a_card_dialog_succeed.tr,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                LocaleKeys.dashboard_profile__payment__add_a_card_dialog_msg.tr,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
