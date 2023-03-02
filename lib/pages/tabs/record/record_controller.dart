import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:monotes/common/config.dart';

class RecordController extends GetxController {
  var inputTimeController = TextEditingController();
  var inputCostController = TextEditingController();
  var inputMerchantController = TextEditingController();

  List<TypeButtonInfo> consumptionTypes = <TypeButtonInfo>[];
  var selectedType = 0.obs;

  @override
  void onInit() {
    super.onInit();
    SHOPPING_TYPE.forEach((key, value) {
      consumptionTypes
          .add(TypeButtonInfo("assets/bill_icons/${key}.svg", value));
    });
  }
}

class TypeButtonInfo {
  String assetName = "";
  String label = "";

  TypeButtonInfo(this.assetName, this.label);
}
