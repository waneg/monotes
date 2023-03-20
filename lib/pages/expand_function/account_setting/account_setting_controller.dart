import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:monotes/common/storage_util.dart';

import '../../../common/dio_util.dart';
import '../../../common/my_exception.dart';
import '../../../common/toast_util.dart';


class AccountSettingController extends GetxController {
  RxString username = "".obs;
  RxString phone = "".obs;
  RxString birthday = "".obs;

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


  getUserInfo() async {
    String p_username = await StorageUtil.getStringItem("username");
    String p_phone = await StorageUtil.getStringItem("phone");
    String p_birthday = await StorageUtil.getStringItem("birthday");
    if(p_username.isNotEmpty){
      username.value = p_username;
    }else{
      username.value = "手机用户$p_phone";
    }
    phone.value = p_phone;
    if(p_birthday.isNotEmpty){
      birthday.value = p_birthday;
    }
  }

  updateUsername(String susername) async{
    try{
      await DioUtils().put("/user/updateUser", data: {"username" : susername});
      ToastUtil.showBasicToast("修改用户名成功");
    }on MyException catch (e) {
      print(e);
      ToastUtil.showBasicToast(e.msg);
    } on Exception catch (e) {
      print(e);
    }
    return false;
  }

}