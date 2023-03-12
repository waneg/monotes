import 'dart:math';

import 'package:common_utils/common_utils.dart';
import 'package:get/get.dart';
import 'package:monotes/common/dio_util.dart';
import 'package:monotes/models/bills_detail.dart';
import 'package:monotes/widgets/detail_card.dart';

class BillsController extends GetxController {
  var billItems = [].obs;

  void fillBillItems() {
    // for (int i = 0; i < 20; i++) {
    //   billItems.add(BillsDetail()
    //     ..billId = 5
    //     ..typeId = 1
    //     ..amount = 99.99
    //     ..merchant = "饿了么"
    //     ..labels = ["聚餐"]
    //     ..time = DateTime(2023));
    // }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    Future future = DioUtils().get("/bill/getList");
    future.then((response) {
      if (response.data['code'] == 0) {
        var list = response.data['data'];
        for (var item in list) {
          billItems.value.add(BillsDetail.fromJson(item));
        }
        print(billItems.value.length);
      } else {
        LogUtil.d(Exception(), tag: "ERROR");
      }
    });
    fillBillItems();
  }
}
