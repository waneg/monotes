import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:monotes/pages/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<HomeController>(HomeController());
  }
}