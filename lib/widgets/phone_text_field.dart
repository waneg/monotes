import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhoneTextField extends StatelessWidget {

  const PhoneTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 52.h,
      padding: const EdgeInsets.only(left: 20).w,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(243, 243, 243, 1),
        borderRadius: BorderRadius.circular(10).w,
      ),
      child: TextField(
        style: TextStyle(fontSize: 19.sp),
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          hintText: "请输入手机号",
          border: InputBorder.none
        ),
      ),

    );
  }
}





