import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class codeLoginStepTwoController extends GetxController {
  final TextEditingController editingController = TextEditingController();
  RxInt seconds = 60.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    countDown();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  countDown(){
    Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      seconds.value--;
      if (seconds.value == 0) {
        timer.cancel();
      }
      update();
    });
  }
}