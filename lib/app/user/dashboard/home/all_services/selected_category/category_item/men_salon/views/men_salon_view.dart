import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/men_salon_controller.dart';

class MenSalonView extends GetView<MenSalonController> {
  const MenSalonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MenSalonView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MenSalonView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
