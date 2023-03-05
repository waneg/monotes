import 'package:get/get.dart';
import 'login_by_password_controller.dart';

class LoginByPasswordBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<LoginByPasswordController>(LoginByPasswordController());
  }
}