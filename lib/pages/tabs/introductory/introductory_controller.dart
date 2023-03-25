import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:monotes/core/network/dio_util.dart';

import '../../../common/my_exception.dart';
import '../../../common/toast_util.dart';
import '../../../models/bills_detail.dart';

class IntroductoryController extends GetxController {
  ScrollController scrollController = ScrollController();
  RxList labelItem = [].obs;
  RxList billItems = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fillLabelItem();
    getBill();
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
      var response = await DioUtils().get("/bill/getList");
      if (response.data['code'] == 0) {
        var list = response.data['data'];
        for (var item in list) {
          billItems.add(BillsDetail.fromJson(item));
        }
      }
    } on MyException catch (e){
      print(e);
      ToastUtil.showBasicToast(e.msg);
    }on Exception catch (e){
      print(e);
    }
  }

}