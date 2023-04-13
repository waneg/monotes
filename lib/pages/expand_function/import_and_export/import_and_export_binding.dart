import 'package:get/get.dart';
import 'package:monotes/pages/expand_function/import_and_export/import_and_export_controller.dart';

class ImportAndExportBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<ImportAndExportController>(ImportAndExportController());
  }
}