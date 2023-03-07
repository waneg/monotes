import 'package:get/get.dart';
import 'package:monotes/pages/tabs/analysis/analysis_controller.dart';

class AnalysisBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => AnalysisController());
  }
}