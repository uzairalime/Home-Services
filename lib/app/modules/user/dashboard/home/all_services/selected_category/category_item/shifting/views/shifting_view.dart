import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/shifting_controller.dart';

class ShiftingView extends GetView<ShiftingController> {
  const ShiftingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShiftingView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ShiftingView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
