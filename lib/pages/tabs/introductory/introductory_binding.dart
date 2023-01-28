import 'package:get/get.dart';
import 'package:monotes/pages/tabs/introductory/introductory_controller.dart';

class IntroductoryBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<IntroductoryController>(IntroductoryController());
  }
}