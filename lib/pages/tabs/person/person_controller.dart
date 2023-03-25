import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:monotes/common/storage_util.dart';

import '../../../common/dio_util.dart';
import '../../../common/my_exception.dart';
import '../../../common/toast_util.dart';

class PersonController extends GetxController {
  RxString p_username = "".obs;
  RxInt createDay = 0.obs;
  RxInt noteNum = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getUserInfo();
    getStaticsInfo();
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

      DateTime dateTime = DateTime.parse(createTime);
      int days = DateTime.now().difference(dateTime).inDays;
      createDay.value = days;
    }on MyException catch (e) {
      print(e);
      ToastUtil.showBasicToast(e.msg);
    } on Exception catch (e) {
      print(e);
    }
  }

  getStaticsInfo() async{
    try{
      var response = await DioUtils().get("/bill/getList");
      List list = response.data['data'];
      int num = list.length;
      noteNum.value = num;
    }on MyException catch (e) {
      print(e);
      ToastUtil.showBasicToast(e.msg);
    } on Exception catch (e) {
      print(e);
    }
  }
}