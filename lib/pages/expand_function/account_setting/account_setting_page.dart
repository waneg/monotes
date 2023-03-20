import 'package:monotes/common/config.dart';
import 'package:monotes/common/toast_util.dart';
import 'package:monotes/pages/expand_function/account_setting/account_setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:monotes/widgets/currency_card.dart';
import 'package:bruno/bruno.dart';

import '../../../common/storage_util.dart';

class AccountSettingPage extends GetView<AccountSettingController> {
  const AccountSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          "账户设置",
          style: TextStyle(color: Colors.black, fontSize: 20.sp),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 10, right: 10).w,
        child: Column(
          children: [
            SizedBox(
              height: 40.h,
            ),
            ClipOval(
              child: Image.network(
                "https://mmsweibo.oss-cn-hangzhou.aliyuncs.com/head.jpg",
                width: 100.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            ListTile(
              title: const Text(
                "用户名",
                style: TextStyle(color: Color.fromRGBO(108, 108, 108, 1)),
              ),
              trailing: Obx(()=>Text(controller.username.value)),
              onTap: () {
                BrnMiddleInputDialog(
                  title: "修改昵称",
                  hintText: "请输入2~8位昵称",
                  cancelText: "取消",
                  confirmText: "确定",
                  autoFocus: true,
                  maxLines: 1,
                  onConfirm: (value) async {
                    // 还未调试
                    // if(value.length < 2){
                    //   ToastUtil.showBasicToast("用户名过短！");
                    // }else if(value.length > 8){
                    //   ToastUtil.showBasicToast("用户名过长！");
                    // }else{
                    //   await controller.updateUsername(value);
                    //   Get.back();
                    // }
                  },
                  onCancel: (){Get.back();}
                ).show(context);
              },
            ),
            const Divider(
              height: 0.0,
              indent: 0.0,
              color: Color.fromRGBO(220, 220, 220, 1.0),
            ),
            ListTile(
              title: const Text(
                "生日",
                style: TextStyle(color: Color.fromRGBO(108, 108, 108, 1)),
              ),
              trailing: Obx((){
                if(controller.birthday.isNotEmpty){
                  return Text(controller.birthday.value);
                }else{
                  return TextButton(onPressed: (){}, child: Text("请选择",style: TextStyle(color: ThemeColor.appBarColor),));
                }
              }),
            ),
            const Divider(
              height: 0.0,
              indent: 0.0,
              color: Color.fromRGBO(220, 220, 220, 1.0),
            ),
            ListTile(
              title: const Text(
                "手机号",
                style: TextStyle(color: Color.fromRGBO(108, 108, 108, 1)),
              ),
              trailing: Obx(()=>Text(controller.phone.value)),
            ),
            const Divider(
              height: 0.0,
              indent: 0.0,
              color: Color.fromRGBO(220, 220, 220, 1.0),
            ),
            const ListTile(
              title: Text(
                "修改密码",
                style: TextStyle(color: Color.fromRGBO(108, 108, 108, 1)),
              ),
            ),
            const Divider(
              height: 0.0,
              indent: 0.0,
              color: Color.fromRGBO(220, 220, 220, 1.0),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 50.h),
              child: ElevatedButton(
                  onPressed: (){
                    Get.offAllNamed("/code_login_step_one");
                    StorageUtil.clear();
                  },
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  minimumSize: MaterialStateProperty.all(Size(300.w, 50.h)),
                  backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(239, 239, 239, 1.0),),
                ),
                  child: Text("退出登录", style: TextStyle(color: const Color.fromRGBO(154, 154, 154, 1), fontSize: 18.sp, fontWeight: FontWeight.bold),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
