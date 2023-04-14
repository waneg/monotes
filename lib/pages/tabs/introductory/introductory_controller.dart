import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:monotes/core/network/dio_util.dart';
import 'package:monotes/pages/tabs/person/person_controller.dart';

import '../../../common/my_exception.dart';
import '../../../common/storage_util.dart';
import '../../../models/bills_detail.dart';

class IntroductoryController extends GetxController {
  ScrollController scrollController = ScrollController();
  RxList labelItem = [].obs;
  RxList billItems = [].obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    await fillLabelItem();
    await EasyLoading.show(status: '加载中...', dismissOnTap: false);
    await getBill();
    await EasyLoading.dismiss();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  fillLabelItem() {
    for (int i = 0; i < 6; i++) {
      labelItem.add("#第$i个标签");
    }
    labelItem[0] = "#早餐";
    labelItem[1] = "#火锅";
    labelItem[2] = "#书籍";
    labelItem[3] = "#旅游";
    labelItem[4] = "#电影";
    labelItem[5] = "#机票";
  }

  getBill() async {
    try {
      var response = await DioUtils().get("/bill/getList",
          options: dio.Options(receiveTimeout: const Duration(seconds: 30)));
      // if (response.data['code'] == 0) {
      var list = response.data['data'];
      for (var item in list) {
        billItems.add(BillsDetail.fromJson(item));
      }
      // }
      await StorageUtil.setIntItem("StatisticNum", billItems.length);
      PersonController personController = Get.find();
      personController.getStaticsInfo();
    } on MyException catch (e) {
      print(e);
    }
  }
}
