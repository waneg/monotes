import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:monotes/common/dio_util.dart';
import 'package:monotes/common/storage_util.dart';
import 'package:monotes/common/config.dart';

import '../../../common/my_exception.dart';
import '../../../common/password_encrypt.dart';
import '../../../common/toast_util.dart';

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

  loginByPassword() async{
    String phone = phoneController.text;
    String password = passwordController.text;

    try{
      String encrypt_pass = await encrypt(password)??"";
      if(encrypt_pass != "" && encrypt_pass.isNotEmpty){
        var response = await DioUtils().post("/user/loginByPassword", data: {"phone":phone,"password":encrypt_pass});
        String token =  response.data["data"]["token"];
        await StorageUtil.setToken(token);
        await StorageUtil.setBoolItem("isLogin", true);
        Get.offAndToNamed("/home");
      }
    }on MyException catch (e){
      print(e);
      ToastUtil.showBasicToast(e.msg);
    }on Exception catch (e){
      print(e);
    }
  }

}