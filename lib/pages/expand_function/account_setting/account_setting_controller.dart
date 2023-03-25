import 'package:flutter/cupertino.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';
import 'package:get/get.dart';
import 'package:monotes/common/storage_util.dart';
import 'package:monotes/pages/tabs/person/person_controller.dart';

import '../../../core/network/dio_util.dart';
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
      await StorageUtil.setStringItem("username", susername);
      username.value = susername;
      PersonController personController = Get.find();
      personController.p_username.value = susername;
    }on MyException catch (e) {
      print(e);
      ToastUtil.showBasicToast(e.msg);
    } on Exception catch (e) {
      print(e);
    }
    return false;
  }


  showDatePicker(BuildContext context){
    DateTime datetime = DateTime.now();
    Pickers.showDatePicker(context,
        mode: DateMode.YMD,
        selectDate: PDuration(year: 2000, month: 1, day: 1),
        minDate: PDuration(year: 1900),
        maxDate: PDuration(
            year: datetime.year, month: datetime.month, day: datetime.day),
        onConfirm: (p) async{
          int? year = p.year;
          int? month = p.month;
          int? day = p.day;
          if(year != null && month != null && day != null){
            await updateBirthday(year, month, day);
          }
        });
  }

  updateBirthday(int year, int month, int day) async{
    String bir = "$year-${month.toString().padLeft(2,'0')}-${day.toString().padLeft(2,'0')}";
    try{
      await DioUtils().put("/user/updateUser", data: {"birthday" : bir});
      ToastUtil.showBasicToast("修改生日成功");
      await StorageUtil.setStringItem("birthday", bir);
      birthday.value = bir;
    }on MyException catch (e) {
      print(e);
      ToastUtil.showBasicToast(e.msg);
    } on Exception catch (e) {
      print(e);
    }
  }

}