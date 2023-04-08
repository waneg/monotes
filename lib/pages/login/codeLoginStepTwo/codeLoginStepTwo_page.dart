import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:monotes/routes/app_routes.dart';
import '../../../common/config.dart';
import 'codeLoginStepTwo_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class codeLoginStepTwoPage extends GetView<codeLoginStepTwoController> {
  const codeLoginStepTwoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          "验证码登录",
          style: TextStyle(color: Colors.black, fontSize: 20.sp),
        ),
      ),
      body: Container(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 32, right: 32).w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40.h,
              ),
              Row(
                children: [
                  Text(
                    "该验证码已发送至",
                    style: TextStyle(color: Colors.black54, fontSize: 14.sp),
                  ),
                  Text(
                    "+86 ${controller.phone.toString().replaceRange(4, 7, '****')}",
                    style: TextStyle(color: Colors.black54, fontSize: 14.sp),
                  ),
                ],
              ),
              SizedBox(height: 30.h,),
              PinCodeTextField(
                appContext: context,
                length: 6,
                keyboardType: TextInputType.number,
                autoFocus: true, // 进入就弹出键盘
                obscureText: false,
                animationType: AnimationType.fade,
                dialogConfig: DialogConfig(
                    dialogTitle: "黏贴验证码",
                    dialogContent: "确定要黏贴验证码",
                    affirmativeText: "确定",
                    negativeText: "取消",
                ),
                pinTheme: PinTheme(
                  //样式
                  // 修改边框
                  activeColor: const Color.fromRGBO(243, 243, 243, 1), // 输入文字后边框的颜色
                  selectedColor: const Color.fromRGBO(243, 243, 243, 1), // 选中边框的颜色
                  inactiveColor: const Color.fromRGBO(243, 243, 243, 1), //默认的边框颜色
                  //背景颜色
                  activeFillColor: const Color.fromRGBO(243, 243, 243, 1),
                  selectedFillColor: const Color.fromRGBO(243, 243, 243, 1),
                  inactiveFillColor: const Color.fromRGBO(243, 243, 243, 1),

                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8.w),
                  fieldHeight: 45.w,
                  fieldWidth: 45.w,
                ),
                cursorColor: Colors.black54,
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                controller: controller.editingController,
                onCompleted: (value) async{
                  // 隐藏键盘
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                onChanged: (value) async{
                  if(value.length == 6){
                    await controller.loginByCode(value.toString());
                  }
                },
                beforeTextPaste: (text) {
                  debugPrint("Allowing to paste $text");
                  return true;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(()=>controller.seconds.value==0?
                    TextButton(
                        onPressed: (){
                          controller.sendCode();
                          },
                        child: const Text("重新发送验证码", style: TextStyle(color: Colors.black54),)):
                      Text("重新发送（${controller.seconds.value}）", style: const TextStyle(color: Colors.black54),)
                  ),
                  TextButton(onPressed: (){}, child: const Text("获取帮助")),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}


