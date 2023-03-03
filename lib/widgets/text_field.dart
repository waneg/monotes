import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhoneTextField extends StatelessWidget {
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  const PhoneTextField({super.key,this.controller,this.onChanged});

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
          controller: controller,
          style: TextStyle(fontSize: 19.sp),
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
              hintText: "请输入手机号",
              border: InputBorder.none,
              ),
          onChanged: onChanged,
        ),
    );
  }
}

class PasswordTextField extends StatelessWidget {
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final String hintText;
  const PasswordTextField({super.key,this.controller,this.onChanged, required this.hintText});

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
        controller: controller,
        style: TextStyle(fontSize: 19.sp),
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          // suffixIcon:
        ),
        onChanged: onChanged,
      ),
    );
  }
}

