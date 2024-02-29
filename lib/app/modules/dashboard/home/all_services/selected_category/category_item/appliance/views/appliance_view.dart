import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/appliance_controller.dart';

class ApplianceView extends GetView<ApplianceController> {
  const ApplianceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ApplianceView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ApplianceView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
