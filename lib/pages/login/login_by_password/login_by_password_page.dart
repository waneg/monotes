import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:monotes/pages/login/login_by_password/login_by_password_controller.dart';
import 'package:monotes/widgets/text_field.dart';
import '../../../common/config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../widgets/UserAgreement.dart';


class LoginByPasswordPage extends GetView<LoginByPasswordController> {
  const LoginByPasswordPage({super.key});

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
                onTap: (){

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