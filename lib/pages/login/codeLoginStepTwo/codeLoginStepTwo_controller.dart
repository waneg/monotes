import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:monotes/common/my_exception.dart';
import 'package:monotes/common/storage_util.dart';
import 'package:monotes/core/network/dio_util.dart';
import 'package:monotes/routes/app_routes.dart';

class codeLoginStepTwoController extends GetxController {
  FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final TextEditingController editingController = TextEditingController();
  RxInt seconds = 60.obs;
  int phone = Get.arguments["phone"];
  late Timer timer;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: android);
    localNotificationsPlugin.initialize(
      initializationSettings,
    );
    sendCode();
  }

  showNotification(String msg) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your channel id', 'your channel name',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await localNotificationsPlugin.show(0, '验证码', msg, platformChannelSpecifics,
        payload: 'item x');
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
      if (e.code == 104) {
        //测试用户，后期删除
        var response = await DioUtils().get("/test/code/${phone}");
        showNotification("欢迎测试用户登录，您的验证码是：${response.data["data"]}");
      }
      timer.cancel();
      seconds.value = 0;
      update();
    }
  }

  loginByCode(String code) async {
    try {
      var response = await DioUtils().post("/user/loginByCode",
          data: {"phone": phone.toString(), "code": code});
      String token = response.data["data"]["token"];
      bool isRegister = response.data["data"]["isRegister"];
      await StorageUtil.setToken(token);
      if (!isRegister) {
        await StorageUtil.setBoolItem("isLogin", true);
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.offAndToNamed(Routes.SET_PASSWORD);
      }
    } on MyException catch (e) {
      print(e);
    }
  }
}
