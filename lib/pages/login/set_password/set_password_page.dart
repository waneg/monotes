import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:monotes/common/config.dart';
import 'package:monotes/common/storage_util.dart';
import 'package:monotes/pages/login/set_password/set_password_controller.dart';
import 'package:monotes/widgets/UserAgreement.dart';
import 'package:monotes/widgets/text_field.dart';

class SetPasswordPage extends GetView<SetPasswordController> {
  const SetPasswordPage({super.key});

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
        title: Text(
          "设置密码",
          style: TextStyle(color: Colors.black, fontSize: 20.sp),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 32, right: 32).w,
        child: Column(
          children: [
            SizedBox(
              height: 60.h,
            ),
            PasswordTextField(
              hintText: "密码(至少8位字符)",
              controller: controller.passwordController,
              onChanged: (value) {},
            ),
            SizedBox(
              height: 30.h,
            ),
            PasswordTextField(
              hintText: "确认密码(至少8位字符)",
              controller: controller.passwordConfirmController,
              onChanged: (value) {},
            ),
            SizedBox(
              height: 30.h,
            ),
            Text(
              "密码长度为8-16个字符；不能包含空格；必须包含字母、数字、符号中至少有两种",
              style: TextStyle(color: Colors.black54, fontSize: 15.sp),
            ),
            SizedBox(
              height: 50.h,
            ),
            BrnBigMainButton(
                title: "开始使用",
                onTap: () async {
                  String pass = controller.passwordController.text;
                  String pass_confirm = controller.passwordConfirmController.text;
                  if(pass.isNotEmpty && pass_confirm.isNotEmpty){
                    if(pass == pass_confirm){
                      if(pass.length < 8){
                        BrnToast.showInCenter(text: "密码位数不得少于8位", context: context);
                      }else if(pass.length > 16){
                        BrnToast.showInCenter(text: "密码位数不得超过16位", context: context);
                      }else if(!controller.isPasswordLegal(pass)){
                        BrnToast.showInCenter(text: "密码必须包含字母、数字、符号中的至少两种", context: context);
                      }else{
                        int status = await controller.sendPassword(pass);
                        if(status == ResponseStatus.SUCCESS){
                          Get.offAllNamed("/home");
                        }else if(status == ResponseStatus.SET_PASSWORD_NOT_ALLOW){
                          BrnToast.showInCenter(text: "超时未设置密码，已失效，请重新获取验证码", context: context);
                        }else{
                          BrnToast.showInCenter(text: "设置密码失败，请稍后再试", context: context);
                        }
                      }
                    }else{
                      BrnToast.showInCenter(text: "两次密码不一致，请重试", context: context);
                    }
                  }else{
                    BrnToast.showInCenter(text: "密码不得为空", context: context);
                  }
                }
            ),
          ],
        ),
      ),
    );
  }
}
