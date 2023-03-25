import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monotes/common/config.dart';
import 'package:monotes/common/dio_util.dart';
import 'package:monotes/common/toast_util.dart';
import 'package:monotes/models/record_detail.dart';

import '../bills/bills_controller.dart';

class RecordController extends GetxController {
  var inputTimeController = TextEditingController();
  var inputCostController = TextEditingController();
  var goodsController = TextEditingController();
  var remarkController = TextEditingController();
  var addLabelController = TextEditingController();

  List<TypeButtonInfo> consumptionTypes = <TypeButtonInfo>[];
  RxList<String> labelList = <String>[].obs;
  var selectedType = 0.obs;

  @override
  void onInit() {
    super.onInit();
    SHOPPING_TYPE.forEach((key, value) {
      consumptionTypes.add(TypeButtonInfo("assets/bill_icons/$key.svg", value));
    });
  }

  void submitRecord() async {
    if (validateInput()) {
      var record = RecordDetail(
          selectedType.value,
          DateTime.parse(inputTimeController.text).toString(),
          double.parse(inputCostController.text),
          "",
          remarkController.text,
          goodsController.text);
      try {
        var response =
            DioUtils().post('/bill/addRecord', data: record.toJson());
        // 返回并刷新
        back();
      } catch (e) {
        LogUtil.d(this, tag: "SUBMIT");
        Get.back();
      }
    }
  }

  Future<RecordDetail> getOcrInfo(File image) async {
    var formData = dio.FormData.fromMap({
      "file": [image]
    });
    var response = await DioUtils().post('/bill/ocr', data: formData);

    return RecordDetail.fromJson(response.data['data'][0]);
  }

  void setInfo(RecordDetail recordDetail) {
    inputTimeController.text = recordDetail.time;
    inputCostController.text = recordDetail.price.toString();
    goodsController.text = recordDetail.shopkeeper.toString();
  }

  bool validateInput() {
    String time = inputTimeController.text;
    String price = inputCostController.text;
    String shopkeeper = goodsController.text;

    if (time.isEmpty ||
        price.isEmpty ||
        shopkeeper.isEmpty ||
        selectedType.value == 0) {
      ToastUtil.showBasicToast("输入信息有误");
      return false;
    }

    return true;
  }

  back() {
    BillsController billsController = Get.find();
    billsController.refreshAllData();
    Get.back();
  }

  addLabel() {
    if (addLabelController.text == "") {
      ToastUtil.showBasicToast("清输入标签名称");
      return;
    }

    if (labelList.length == 4) {
      ToastUtil.showBasicToast("标签数目超出限制");
    }

    String labelName = addLabelController.text;
    if (!labelList.contains(labelName)) {
      labelList.add(labelName);
    }
  }
}

class TypeButtonInfo {
  String assetName = "";
  String label = "";

  TypeButtonInfo(this.assetName, this.label);
}
