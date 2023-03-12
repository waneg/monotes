import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:monotes/common/dio_util.dart';

import '../../../common/my_exception.dart';
import '../../../common/toast_util.dart';
import '../../../models/bills_detail.dart';

class IntroductoryController extends GetxController {
  ScrollController scrollController = ScrollController();
  List labelItem = [];
  List billItems = [];

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

  void fillBillItems() {
    // for (int i = 0; i < 6; i++) {
    //   billItems.add(BillsDetail()
    //     ..billId = 5
    //     ..typeId = 1
    //     ..amount = 99.99
    //     ..merchant = "饿了么"
    //     ..labels = ["聚餐"]
    //     ..time = DateTime(2023));
    // }
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