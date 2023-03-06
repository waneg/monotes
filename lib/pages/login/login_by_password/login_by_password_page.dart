import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:monotes/common/dio_util.dart';
import 'package:monotes/common/storage_util.dart';
import 'package:monotes/pages/login/login_by_password/login_by_password_controller.dart';
import 'package:monotes/routes/app_routes.dart';
import 'package:monotes/widgets/text_field.dart';
import '../../../common/config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../widgets/UserAgreement.dart';


class LoginByPasswordPage extends GetView<LoginByPasswordController> {
  const LoginByPasswordPage({super.key});

  static void _toast(String text){
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT, //提示时间 只针对安卓平台
        gravity: ToastGravity.CENTER, //方位
        timeInSecForIosWeb: 1,  //提示时间 针对ios和web
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15).w,
            child: TextButton(
                onPressed: () {Get.toNamed("/code_login_step_one");},
                child: Text("验证码登录",
                    style: TextStyle(color: Colors.black, fontSize: 20.sp))
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 32, right: 32).w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40.h,),
            Text(
              "密码登录",
              style: TextStyle(color: Colors.black, fontSize: 25.sp),
            ),
            SizedBox(height: 45.h,),
            PhoneTextField(controller: controller.phoneController,onChanged: (value){},),
            SizedBox(height: 20.h,),
            PasswordTextField(hintText: "密码(至少6位字符)", controller: controller.passwordController,),
            SizedBox(height: 10.h,),
            UserAgreement(controller: controller,),
            SizedBox(height: 25.h,),
            BrnBigMainButton(
                title: "登录",
                onTap:() async {
                  String phoneNumber = controller.phoneController.text;
                  String password = controller.passwordController.text;
                  var map = {'phone': phoneNumber, 'password': password};
                  var response = await DioUtils().post('/user/loginByPassword', data: map);
                  if (response.data['code'] == ResponseStatus.SUCCESS) {
                    StorageUtil.setToken(response.data['data']['token']);
                    Get.toNamed(Routes.HOME);
                  } else {
                    _toast(response.data['msg']);
                  }
                }
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: (){},
                  child: Text("找回密码", style: TextStyle(fontSize: 16.sp),)
              ),
            ),

          ],
        ),
      ),
    );
  }

}