import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:monotes/common/storage_util.dart';

import '../../../common/dio_util.dart';
import '../../../common/my_exception.dart';
import '../../../common/toast_util.dart';

class PersonController extends GetxController {
  RxString p_username = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getUserInfo();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  getUserInfo() async{
    try{
      var response = await DioUtils().get("/user/info");

      String phone = response.data["data"]["phone"];
      String? username = response.data["data"]["username"];
      String? birthday = response.data["data"]["birthday"];
      String createTime = response.data["data"]["createTime"];

      StorageUtil.setStringItem("phone", phone);
      StorageUtil.setStringItem("username", username??"");
      StorageUtil.setStringItem("birthday", birthday??"");
      StorageUtil.setStringItem("createTime", createTime);

      if(username != null){
        p_username.value = username;
      }else{
        p_username.value = "手机用户${phone.substring(0,4)}...";
      }
    }on MyException catch (e) {
      print(e);
      ToastUtil.showBasicToast(e.msg);
    } on Exception catch (e) {
      print(e);
    }
  }
}