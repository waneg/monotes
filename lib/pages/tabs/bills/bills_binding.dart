import 'package:get/get.dart';
import 'package:monotes/pages/tabs/bills/bills_controller.dart';

class BillsBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<BillsController>(BillsController());
  }
}