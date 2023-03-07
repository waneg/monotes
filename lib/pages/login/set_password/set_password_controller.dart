import 'dart:async';
import 'package:bruno/bruno.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:monotes/common/config.dart';
import 'package:monotes/common/dio_util.dart';

import '../../../common/storage_util.dart';


class SetPasswordController extends GetxController {
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

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

  sendPassword(String password) async{
    var response = await DioUtils().put("/user/setPassword", data: {"password" : password});
    int status = response.data["code"];
    if(status == ResponseStatus.SUCCESS){
      await StorageUtil.setBoolItem("isLogin", true);
    }
    return status;
  }

  isPasswordLegal(String password){
    // return RegExp('/^(((?=.*[0-9])(?=.*[a-zA-Z])|(?=.*[0-9])(?=.*[^\\s0-9a-zA-Z])|(?=.*[a-zA-Z])(?=.*[^\\s0-9a-zA-Z]))[^\\s]+)\$/').hasMatch(password);
    return true;
  }
}