import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/plumbing_controller.dart';

class PlumbingView extends GetView<PlumbingController> {
  const PlumbingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PlumbingView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PlumbingView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
