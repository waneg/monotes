import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monotes/common/config.dart';
import 'package:monotes/models/record_detail.dart';

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
          .add(TypeButtonInfo("assets/bill_icons/$key.svg", value));
    });
  }

  void submitRecord() async {
    if (validateInput()) {
      var record = RecordDetail(selectedType.value, inputCostController.text, inputTimeController.text, inputMerchantController.text);
      String token = TOKEN;
      try {
        var response = await Dio().get("http://www.baidu.com");
        print(response);
      } catch (e) {
        print(e);
      }


    }

  }

  bool validateInput() {
    String time = inputTimeController.text;
    String price = inputCostController.text;
    String shopkeeper = inputMerchantController.text;

    if (time.isEmpty || price.isEmpty || shopkeeper.isEmpty) {
      Get.defaultDialog(title: "提示", middleText: "输入信息有误", middleTextStyle: const TextStyle(color: Colors.blue));
    }

    return true;
  }
}

class TypeButtonInfo {
  String assetName = "";
  String label = "";

  TypeButtonInfo(this.assetName, this.label);
}
