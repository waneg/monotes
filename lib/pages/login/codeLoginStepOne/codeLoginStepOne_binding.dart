import 'package:get/get.dart';
import 'codeLoginStepOne_controller.dart';

class codeLoginStepOneBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<CodeLoginStepOneController>(CodeLoginStepOneController());
  }
}