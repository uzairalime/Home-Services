import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/spa_controller.dart';

class SpaView extends GetView<SpaController> {
  const SpaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpaView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SpaView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
