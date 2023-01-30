import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:monotes/common/styleColor.dart';
import 'package:bruno/bruno.dart';

class UserAgreement extends StatefulWidget {
  const UserAgreement({Key? key}) : super(key: key);

  @override
  State<UserAgreement> createState() => _UserAgreementState();
}

class _UserAgreementState extends State<UserAgreement> {
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
                activeColor: primary_color,
                value: false,
                onChanged: (v) {

                }
            ),
          ),
        ),
        const Text("同意", style: TextStyle(color: Color.fromRGBO(154, 154, 154, 1)),),
        const Text(
          "用户协议",
          style: TextStyle(color: primary_color, decoration: TextDecoration.underline, decorationColor: primary_color),
        ),
        const Text("，",style: TextStyle(color: Color.fromRGBO(154, 154, 154, 1)),),
        const Text(
          "隐私政策",
          style: TextStyle(color: primary_color, decoration: TextDecoration.underline, decorationColor: primary_color),
        ),
        const Text("和",style: TextStyle(color: Color.fromRGBO(154, 154, 154, 1)),),
        const Text(
          "儿童隐私保护指引",
          style: TextStyle(color: primary_color, decoration: TextDecoration.underline, decorationColor: primary_color),
        )
      ],
    );
  }
}


