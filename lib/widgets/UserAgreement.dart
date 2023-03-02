import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bruno/bruno.dart';
import 'package:get/get.dart';

import '../pages/login/codeLoginStepOne/codeLoginStepOne_controller.dart';

class UserAgreement extends StatefulWidget {
  const UserAgreement({super.key});

  @override
  State<UserAgreement> createState() => _UserAgreementState();
}

class _UserAgreementState extends State<UserAgreement> {
  late bool _checkValue = false;
  final controller = Get.find<codeLoginStepOneController>();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Container(
          width: 20.w,
          child: Transform.scale(
            scale:0.7,
            child: Checkbox(
                activeColor: const Color.fromRGBO(64, 149, 229, 1),
                value: _checkValue,
                onChanged: (v){
                  controller.isCheck.value = v!;
                  setState(() {
                    _checkValue = v!;
                  });
                },
            ),
          ),
        ),
        const Text("同意", style: TextStyle(color: Color.fromRGBO(154, 154, 154, 1)),),
        const Text(
          "用户协议",
          style: TextStyle(color: Color.fromRGBO(64, 149, 229, 1), decoration: TextDecoration.underline, decorationColor: Color.fromRGBO(64, 149, 229, 1)),
        ),
        const Text("，",style: TextStyle(color: Color.fromRGBO(154, 154, 154, 1)),),
        const Text(
          "隐私政策",
          style: TextStyle(color: Color.fromRGBO(64, 149, 229, 1), decoration: TextDecoration.underline, decorationColor: Color.fromRGBO(64, 149, 229, 1)),
        ),
        const Text("和",style: TextStyle(color: Color.fromRGBO(154, 154, 154, 1)),),
        const Text(
          "儿童隐私保护指引",
          style: TextStyle(color: Color.fromRGBO(64, 149, 229, 1), decoration: TextDecoration.underline, decorationColor: Color.fromRGBO(64, 149, 229, 1)),
        )
      ],
    );
  }
}


