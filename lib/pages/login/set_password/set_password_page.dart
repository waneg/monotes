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

  void _toast(String text){
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
              hintText: "密码(至少6位字符)",
              controller: controller.passwordController,
              onChanged: (value) {},
            ),
            SizedBox(
              height: 30.h,
            ),
            PasswordTextField(
              hintText: "确认密码(至少6位字符)",
              controller: controller.passwordConfirmController,
              onChanged: (value) {},
            ),
            SizedBox(
              height: 30.h,
            ),
            Text(
              "密码长度为6-24个字符；不能包含空格；必须包含字母、数字、符号中至少有两种",
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
                      int status = await controller.sendPassword(pass);
                      print(status);
                      if(status == ResponseStatus.SUCCESS){
                        Get.toNamed("/Home");
                      }else if(status == ResponseStatus.SET_PASSWORD_NOT_ALLOW){
                        _toast("超时未设置密码，已失效，请重新获取验证码");
                      }else{
                        _toast("设置密码失败，请稍后再试");
                      }
                    }
                  }else{
                    _toast("密码不得为空");
                  }
                }
            ),
          ],
        ),
      ),
    );
  }
}
