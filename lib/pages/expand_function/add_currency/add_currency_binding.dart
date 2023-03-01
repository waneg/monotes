import 'package:get/get.dart';
import 'add_currency_controller.dart';

class AddCurrencyBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<AddCurrencyController>(AddCurrencyController());
  }
}