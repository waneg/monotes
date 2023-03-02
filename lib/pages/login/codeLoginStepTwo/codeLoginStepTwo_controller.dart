import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:monotes/common/dio_util.dart';
import 'package:monotes/common/storage_util.dart';

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

  void sendCode() async{
    seconds.value = 60;
    var response = await DioUtils().post("/user/getCode", data: {"phone": phone});
    print(response);
  }
  
  void loginByCode(String code) async{
    var response = await DioUtils().post("/user/loginByCode", data: {"phone": phone.toString(), "code": code});
    print(response);
    if(response.data["msg"] == "success"){
      String token = response.data["data"]["token"];
      setToken(token);
    }

  }

  void setToken(String token) async{
    await StorageUtil.setStringItem("token", token);
  }


}