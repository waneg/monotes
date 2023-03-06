import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:monotes/common/dio_util.dart';
import 'package:monotes/common/storage_util.dart';
import 'package:monotes/common/config.dart';

class codeLoginStepTwoController extends GetxController {
  final TextEditingController editingController = TextEditingController();
  RxInt seconds = 60.obs;
  int phone = Get.arguments["phone"];


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    countDown();
    sendCode();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  countDown(){
    Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      seconds.value--;
      if (seconds.value == 0) {
        timer.cancel();
      }
      update();
    });
  }

  sendCode() async{
    seconds.value = 60;
    var response = await DioUtils().post("/user/getCode", data: {"phone": phone});
  }
  
  loginByCode(String code) async{
    var response = await DioUtils().post("/user/loginByCode", data: {"phone": phone.toString(), "code": code});
    int status = response.data["code"];
    if(status == ResponseStatus.SUCCESS){
      String token =  response.data["data"]["token"];
      bool isRegister = response.data["data"]["isRegister"];
      await StorageUtil.setToken(token);
      return [status, isRegister];
    }
    return [status];
  }



}