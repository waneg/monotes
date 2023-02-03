import 'package:get/get.dart';
import 'codeLoginStepTwo_controller.dart';

class codeLoginStepTwoBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<codeLoginStepTwoController>(codeLoginStepTwoController());
  }
}