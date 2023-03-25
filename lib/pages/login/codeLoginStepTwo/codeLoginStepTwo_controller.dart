import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:monotes/common/config.dart';
import 'package:monotes/core/network/dio_util.dart';
import 'package:monotes/common/my_exception.dart';
import 'package:monotes/common/storage_util.dart';
import 'package:monotes/common/toast_util.dart';

class codeLoginStepTwoController extends GetxController {
  final TextEditingController editingController = TextEditingController();
  RxInt seconds = 60.obs;
  int phone = Get.arguments["phone"];
  late Timer timer;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    sendCode();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  countDown() {
    timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      seconds.value--;
      if (seconds.value == 0) {
        timer.cancel();
      }
      update();
    });
  }



  sendCode() async {
    seconds.value = 60;
    countDown();
    try {
      await DioUtils().post("/user/getCode", data: {"phone": phone});
    } on MyException catch (e) {
      print(e);
      //  在这里处理返回的业务相关错误，是后端返回了信息
      //  如果服务器返回发送验证码失败，那么就不需要倒计时
      ToastUtil.showBasicToast(e.msg);
      timer.cancel();
      seconds.value = 0;
      update();
    } on Exception catch (e) {
      //  在这里处理网络请求错误，是后端没有返回信息
      timer.cancel();
      seconds.value = 0;
      update();
    }
  }

  loginByCode(String code) async {
    try{
      var response = await DioUtils().post("/user/loginByCode",
          data: {"phone": phone.toString(), "code": code});
      String token = response.data["data"]["token"];
      bool isRegister = response.data["data"]["isRegister"];
      await StorageUtil.setToken(token);
      if (!isRegister) {
        await StorageUtil.setBoolItem("isLogin", true);
        Get.offAllNamed("/home");
      }else{
        Get.offAndToNamed("/set_password");
      }
    } on MyException catch (e){
      print(e);
      ToastUtil.showBasicToast(e.msg);
    }on Exception catch (e){
      print(e);
    }
  }

}
