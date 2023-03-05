import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:monotes/common/dio_util.dart';
import 'package:monotes/common/storage_util.dart';
import 'package:monotes/common/config.dart';

class LoginByPasswordController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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

  loginByPassword(String phone, String password) async{
    var response = await DioUtils().post("/user/loginByPassword", data: {"phone":phone,"password":password});
    int status = response.data["code"];
    if(status == ResponseStatus.SUCCESS){
      String token =  response.data["data"]["token"];
      await StorageUtil.setToken(token);
    }
    return status;
  }

}