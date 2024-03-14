import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/women_salon_controller.dart';

class WomenSalonView extends GetView<WomenSalonController> {
  const WomenSalonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WomenSalonView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'WomenSalonView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
