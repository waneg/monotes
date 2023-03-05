import 'package:get/get.dart';
import 'package:monotes/pages/login/set_password/set_password_controller.dart';


class SetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<SetPasswordController>(SetPasswordController());
  }
}