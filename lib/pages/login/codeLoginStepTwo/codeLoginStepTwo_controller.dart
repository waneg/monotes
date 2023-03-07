import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:monotes/common/config.dart';
import 'package:monotes/common/dio_util.dart';
import 'package:monotes/common/my_exception.dart';
import 'package:monotes/common/storage_util.dart';

class codeLoginStepTwoController extends GetxController {
  final TextEditingController editingController = TextEditingController();
  RxInt seconds = 60.obs;
  int phone = Get.arguments["phone"];
  var countDownTimer;

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

  countDown() {
    countDownTimer =
        Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      seconds.value--;
      if (seconds.value == 0) {
        timer.cancel();
      }
      update();
    });
  }

  sendCode() async {
    seconds.value = 60;
    try {
      var response =
          await DioUtils().post("/user/getCode", data: {"phone": phone});
    } on MyException catch (e) {
      print(e);
      //  在这里处理返回的业务相关错误，是后端返回了信息
      //  如果服务器返回发送验证码失败，那么就不需要倒计时
      print("发送验证码失败,toast提示");
      seconds.value = 0;
      countDownTimer.cancel();
      update();
    } on Exception catch (e) {
      //  在这里处理网络请求错误，是后端没有返回信息
      seconds.value = 0;
      countDownTimer.cancel();
      update();
    }
  }

  loginByCode(String code) async {
    var response = await DioUtils().post("/user/loginByCode",
        data: {"phone": phone.toString(), "code": code});
    int status = response.data["code"];
    if (status == ResponseStatus.SUCCESS) {
      String token = response.data["data"]["token"];
      bool isRegister = response.data["data"]["isRegister"];
      await StorageUtil.setToken(token);
      if (!isRegister) {
        await StorageUtil.setBoolItem("isLogin", true);
      }
      return {'status': status, 'isRegister': isRegister};
    }
    return {'status': status};
  }
}
