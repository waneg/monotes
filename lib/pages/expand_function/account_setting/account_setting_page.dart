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
              trailing: const Text("玛丽亚"),
              onTap: (){
                BrnMiddleInputDialog(
                  title: "修改昵称",
                  hintText: "请输入2~12位昵称",
                  cancelText: "取消",
                  confirmText: "确定",
                  autoFocus: true,
                  maxLines: 1,
                  onConfirm: (value){},
                  onCancel: (){Get.back();}
                ).show(context);
              },
            ),
            const Divider(
              height: 0.0,
              indent: 0.0,
              color: Color.fromRGBO(220, 220, 220, 1.0),
            ),
            const ListTile(
              title: Text(
                "生日",
                style: TextStyle(color: Color.fromRGBO(108, 108, 108, 1)),
              ),
              trailing: Text("1993/01/22"),
            ),
            const Divider(
              height: 0.0,
              indent: 0.0,
              color: Color.fromRGBO(220, 220, 220, 1.0),
            ),
            const ListTile(
              title: Text(
                "手机号",
                style: TextStyle(color: Color.fromRGBO(108, 108, 108, 1)),
              ),
              trailing: Text("15381079286"),
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
            ElevatedButton(
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
            )
          ],
        ),
      ),
    );
  }
}
