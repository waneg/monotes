import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:monotes/models/currency_detail.dart';

class MultiCurrencyController extends GetxController {
  RxList<CurrencyDetail> currencyItem = <CurrencyDetail>[].obs;

  void fillCurrency(){
    for(int i = 0; i < 10; i++){
      currencyItem.add(CurrencyDetail()
        ..name = "阿联酋迪拉姆"
        ..abbr = "AED"
        ..symbol = "AED"
        ..rate = 1.8904
      );
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fillCurrency();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

}