
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:monotes/common/dio_util.dart';
import 'package:monotes/common/storage_util.dart';

class codeLoginStepOneController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  RxBool isCheck = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  bool isChinaPhoneLegal(String str) {
    return RegExp('^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$').hasMatch(str);
  }


}