import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/reparing_controller.dart';

class ReparingView extends GetView<ReparingController> {
  const ReparingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReparingView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ReparingView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
