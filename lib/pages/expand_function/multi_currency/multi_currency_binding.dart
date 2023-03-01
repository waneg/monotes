import 'package:get/get.dart';
import 'multi_currency_controller.dart';

class MultiCurrencyBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<MultiCurrencyController>(MultiCurrencyController());
  }
}