import 'dart:math';

import 'package:get/get.dart';
import 'package:monotes/models/bills_detail.dart';
import 'package:monotes/widgets/detail_card.dart';

class BillsController extends GetxController {
  List billItems = [];

  void fillBillItems() {
    for (int i = 0; i < 20; i++) {
      billItems.add(BillsDetail()
        ..id = 5
        ..typeId = 1
        ..amount = 99.99
        ..merchant = "饿了么"
        ..labels = ["聚餐"]
        ..time = DateTime(2023));
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fillBillItems();
  }
}
