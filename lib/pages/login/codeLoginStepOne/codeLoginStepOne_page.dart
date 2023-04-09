import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:monotes/pages/login/codeLoginStepOne/codeLoginStepOne_controller.dart';
import 'package:monotes/widgets/text_field.dart';
import 'package:monotes/widgets/UserAgreement.dart';
import 'package:fluttertoast/fluttertoast.dart';

class codeLoginStepOnePage extends GetView<CodeLoginStepOneController> {
  const codeLoginStepOnePage({Key? key}) : super(key: key);

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
                  controller.nextButton();
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
