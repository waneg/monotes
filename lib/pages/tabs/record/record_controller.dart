import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class RecordController extends GetxController {
  var inputTimeController = TextEditingController();
  var inputCostController = TextEditingController();
  var inputMerchantController = TextEditingController();

  var consumptionTypes = [];
  var selectedTypes = 0.obs;

  @override
  void onInit() {
    // TODO: implement onReady
    super.onReady();
  }
}

