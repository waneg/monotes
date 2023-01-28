import 'package:get/get.dart';
import 'package:monotes/pages/tabs/person/person_controller.dart';

class PersonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PersonController());
  }
}