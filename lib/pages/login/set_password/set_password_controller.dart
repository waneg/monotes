import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class SetPasswordController extends GetxController {
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  sendPassword(){
    String pass = passwordController.text;
    String pass_confirm = passwordConfirmController.text;

  }


}