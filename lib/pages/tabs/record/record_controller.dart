import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:monotes/common/config.dart';
import 'package:monotes/common/my_exception.dart';
import 'package:monotes/common/toast_util.dart';
import 'package:monotes/core/network/dio_util.dart';
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
  onInit() {
    super.onInit();
    SHOPPING_TYPE.forEach((key, value) {
      consumptionTypes.add(TypeButtonInfo("assets/bill_icons/$key.svg", value));
    });
  }

  submitRecord() async {
    if (validateInput()) {
      var record = RecordDetail(
          selectedType.value,
          DateTime.parse(inputTimeController.text).toString(),
          double.parse(inputCostController.text),
          "",
          remarkController.text,
          goodsController.text);
      try {
        EasyLoading.show(status: '提交中...', dismissOnTap: false);
        var response =
            await DioUtils().post('/bill/addRecord', data: record.toJson());
        // 返回并刷新
        Get.back();
        ToastUtil.showBasicToast("添加成功");
      } catch (e) {
        LogUtil.v(record, tag: "SUBMIT");
        // Get.back();
      } finally {
        await EasyLoading.dismiss();
      }
    }
  }

  Future<RecordDetail?> getOcrInfo(String filePath) async {
    debugPrint("图片的大小：${await File(filePath).length()}");
    var formData = dio.FormData.fromMap({
      "file": [
        dio.MultipartFile.fromBytes(await File(filePath).readAsBytes(),
            filename: "${DateTime.now().toString()}.jpg")
      ]
    });

    await EasyLoading.show(status: '识别中...', dismissOnTap: false);
    try {
      var response = await DioUtils().post('/bill/ocr',
          data: formData,
          options: dio.Options(receiveTimeout: const Duration(seconds: 10)));
      return RecordDetail.fromJson(response.data['data']);
    } on MyException catch (e) {
      return null;
    } finally {
      await EasyLoading.dismiss();
    }
  }

  setInfo(RecordDetail recordDetail) {
    inputTimeController.text = recordDetail.time;
    inputCostController.text = recordDetail.price.toString();
    goodsController.text = recordDetail.goods.toString();
    selectedType.value = recordDetail.typeId;
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

  back() async {
    BillsController billsController = Get.find();
    await billsController.refreshAllData();
    Get.back();
  }

  addLabel() {
    if (addLabelController.text == "") {
      ToastUtil.showBasicToast("清输入标签名称");
      return;
    }

    if (labelList.length == 4) {
      ToastUtil.showBasicToast("标签数目超出限制");
      return;
    }

    String labelName = addLabelController.text;
    if (!labelList.contains(labelName)) {
      labelList.add(labelName);
    } else {
      ToastUtil.showBasicToast("请勿重复输入标签");
    }
  }
}

class TypeButtonInfo {
  String assetName = "";
  String label = "";

  TypeButtonInfo(this.assetName, this.label);
}
