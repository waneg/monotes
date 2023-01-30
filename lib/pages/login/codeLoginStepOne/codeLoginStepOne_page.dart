import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:monotes/pages/login/codeLoginStepOne/codeLoginStepOne_controller.dart';
import 'package:monotes/widgets/phone_text_field.dart';
import 'package:monotes/widgets/UserAgreement.dart';

class codeLoginStepOnePage extends GetView<codeLoginStepOneController> {
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
                onPressed: () {},
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
          padding: const EdgeInsets.only(left: 32, top: 44, right: 32).w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "验证码登录",
                style: TextStyle(color: Colors.black, fontSize: 25.sp),
              ),
              SizedBox(width: 1.w,height: 15.h,),
              Text(
                "首次登录会创建新账号",
                style: TextStyle(color: Colors.black54, fontSize: 15.sp),
              ),
              SizedBox(width: 1.w, height: 45.h,),
              const PhoneTextField(),
              SizedBox(width: 1.w, height: 10.h,),
              const UserAgreement(),
              SizedBox(width: 1.w, height: 25.h,),
              BrnBigMainButton(
                title: "下一步",
                onTap: (){

                }
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(bottom: 30).h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("更多登录方式", style: TextStyle(color: Color.fromRGBO(154, 154, 154, 1)),),
                    InkWell(
                      onTap: (){

                      },
                      child: Transform.scale(
                        scale: 0.8,
                        child: Container(
                          padding: const EdgeInsets.all(3).w,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(3, 191, 155, 1),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Icon(Icons.wechat, color: Colors.white,),
                        ),
                      ),
                    )
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
