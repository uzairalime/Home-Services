import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/handyman_controller.dart';

class HandymanView extends GetView<HandymanController> {
  const HandymanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HandymanView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HandymanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
