import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth/auth_controller.dart';

class TestPage extends StatelessWidget {
  TestPage({super.key});

  RxInt sliderButtonNumber = 0.obs;
 final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      body: SafeArea(
          child: Obx((){return

            CupertinoSlidingSegmentedControl(
            children: const {
              0: Padding(
                padding: EdgeInsets.all(4.0),
                child: Text('Saved Address'),
              ),
              1: Padding(
                padding: EdgeInsets.all(4.0),
                child: Text('Different Address'),
              ),
            },
            onValueChanged: (newButtonNumber) {
              if (newButtonNumber != null) {
                sliderButtonNumber.value = newButtonNumber;
              }
            },
            groupValue: sliderButtonNumber.value,
          ); })

    ),
    );
  }
}
