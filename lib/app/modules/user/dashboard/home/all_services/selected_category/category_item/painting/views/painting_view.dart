import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/painting_controller.dart';

class PaintingView extends GetView<PaintingController> {
  const PaintingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PaintingView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PaintingView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
