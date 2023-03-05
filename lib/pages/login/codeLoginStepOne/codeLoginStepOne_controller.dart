
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
    StorageUtil.setToken("");
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }



}