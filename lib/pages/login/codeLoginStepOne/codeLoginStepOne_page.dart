import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:monotes/pages/login/codeLoginStepOne/codeLoginStepOne_controller.dart';
import 'package:monotes/widgets/text_field.dart';
import 'package:monotes/widgets/UserAgreement.dart';
import 'package:fluttertoast/fluttertoast.dart';

class codeLoginStepOnePage extends GetView<codeLoginStepOneController> {
  const codeLoginStepOnePage({Key? key}) : super(key: key);

  static bool isChinaPhoneLegal(String str) {
    return RegExp('^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$').hasMatch(str);
  }

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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15).w,
            child: TextButton(
                onPressed: () {Get.toNamed("/login_by_password");},
                child: Text("密码登录",
                    style: TextStyle(color: Colors.black, fontSize: 20.sp))
            ),
          )
        ],
      ),
      body: Container(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 32, right: 32).w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h,),
              Text(
                "验证码登录",
                style: TextStyle(color: Colors.black, fontSize: 25.sp),
              ),
              SizedBox(height: 15.h,),
              Text(
                "首次登录会创建新账号",
                style: TextStyle(color: Colors.black54, fontSize: 15.sp),
              ),
              SizedBox(height: 45.h,),
              PhoneTextField(
                controller: controller.phoneController,
                onChanged: (value){

                },
              ),
              SizedBox(height: 10.h,),
              UserAgreement(controller: controller,),
              SizedBox(height: 25.h,),
              BrnBigMainButton(
                title: "下一步",
                onTap: (){
                  String phone_text = controller.phoneController.text;
                  if(phone_text.isNotEmpty){
                    int phone = int.parse(controller.phoneController.text);
                    if(isChinaPhoneLegal(phone.toString()) && controller.isCheck.value){
                      Get.toNamed("/code-login-step-two", arguments: {"phone": phone});
                    } else if(!isChinaPhoneLegal(phone.toString())){
                      _toast("手机号格式不正确，请重新输入");
                    }else if(!controller.isCheck.value){
                      _toast("请先同意用户协议、隐私政策和儿童隐私保护指引");
                    }
                  }else{
                    _toast("手机号格式不正确，请重新输入");
                  }


                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
