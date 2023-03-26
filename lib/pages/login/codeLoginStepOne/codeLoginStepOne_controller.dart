
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:monotes/common/toast_util.dart';

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

  nextButton(){
    String phone_text = phoneController.text;
    if(phone_text.isNotEmpty){
      int phone = int.parse(phone_text);
      if(isChinaPhoneLegal(phone.toString()) && isCheck.value){
        Get.toNamed("/code_login_step_two", arguments: {"phone": phone});
      } else if(!isChinaPhoneLegal(phone.toString())){
        ToastUtil.showBasicToast("手机号格式不正确，请重新输入");
      }else if(!isCheck.value){
        ToastUtil.showBasicToast("请先同意用户协议、隐私政策和儿童隐私保护指引");
      }
    }else{
      ToastUtil.showBasicToast("手机号格式不正确，请重新输入");
    }
  }


}