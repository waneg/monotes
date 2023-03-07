import 'dart:async';
import 'package:bruno/bruno.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:monotes/common/config.dart';
import 'package:monotes/common/dio_util.dart';
import '../../../common/my_exception.dart';
import '../../../common/storage_util.dart';
import 'package:monotes/common/toast_util.dart';
import 'package:monotes/common/password_encrypt.dart';

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
    return RegExp("^(?![a-zA-Z]+\$)(?!\d+\$)(?![^\da-zA-Z\s]+\$).{8,16}\$").hasMatch(password);
    // return true;
  }

  checkPassword() async {
    String pass = passwordController.text;
    String pass_confirm = passwordConfirmController.text;
    if (pass.isNotEmpty && pass_confirm.isNotEmpty){
      if(pass == pass_confirm){
        if(pass.length < 8) {
          ToastUtil.showBasicToast("密码位数不得少于8位");
        } else if(pass.length > 16) {
          ToastUtil.showBasicToast("密码位数不得超过16位");
        } else if(!isPasswordLegal(pass)){
          ToastUtil.showBasicToast("密码必须包含字母、数字、符号中的至少两种");
        }else{
          String encrypt_pass = await encrypt(pass)??"";
          if(encrypt_pass != "" && encrypt_pass.isNotEmpty){
            await sendPassword(encrypt_pass);
            Get.offAllNamed("/home");
          }
        }
      }else{
        ToastUtil.showBasicToast("两次密码不一致，请重试");
      }
    }else{
      ToastUtil.showBasicToast("密码不得为空");
    }
  }

  setButton() async{
    try{
      await checkPassword();
    }on MyException catch (e){
      print(e);
      ToastUtil.showBasicToast(e.msg);
    }on Exception catch (e){
      print(e);
    }
  }




}