import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/laundry_controller.dart';

class LaundryView extends GetView<LaundryController> {
  const LaundryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LaundryView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'LaundryView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
