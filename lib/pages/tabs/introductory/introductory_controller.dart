import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:monotes/core/network/dio_util.dart';
import 'package:monotes/pages/tabs/person/person_controller.dart';

import '../../../common/my_exception.dart';
import '../../../common/storage_util.dart';
import '../../../common/toast_util.dart';
import '../../../models/bills_detail.dart';

class IntroductoryController extends GetxController {
  ScrollController scrollController = ScrollController();
  RxList labelItem = [].obs;
  RxList billItems = [].obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await EasyLoading.show(status: 'loading...');
    await fillLabelItem();
    await getBill();
    await EasyLoading.dismiss();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  fillLabelItem(){
    for(int i = 0; i < 6; i++){
      labelItem.add("#第$i个标签");
    }
    labelItem[0] = "#早餐";
  }

  getBill() async {
    try{
      var response = await DioUtils().get("/bill/getList",options: dio.Options(receiveTimeout: 30000));
      if (response.data['code'] == 0) {
        var list = response.data['data'];
        for (var item in list) {
          billItems.add(BillsDetail.fromJson(item));
        }
      }
      await StorageUtil.setIntItem("StatisticNum", billItems.length);
      PersonController personController = Get.find();
      personController.getStaticsInfo();
    } on MyException catch (e){
      print(e);
      ToastUtil.showBasicToast(e.msg);
    }on Exception catch (e){
      print(e);
    }
  }

}