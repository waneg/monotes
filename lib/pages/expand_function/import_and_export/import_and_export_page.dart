import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:monotes/pages/expand_function/import_and_export/import_and_export_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:monotes/widgets/currency_card.dart';
import 'package:bruno/bruno.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../common/toast_util.dart';

class ImportAndExportPage extends GetView<ImportAndExportController> {
  ImportAndExportPage({super.key});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
          "账单导入与导出",
          style: TextStyle(color: Colors.black, fontSize: 20.sp),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.only(left: 20, right: 20).w,
          children: [
            FunctionCard(
                icon: Icons.call_received_sharp,
                title: "批量导入",
                onTap: () async {
                  List<Asset> resultList = <Asset>[];
                  List<Asset> selectList = <Asset>[];

                  try {
                    resultList = await MultipleImagesPicker.pickImages(
                      maxImages: 9,
                      enableCamera: true,
                      selectedAssets: selectList,
                      cupertinoOptions: const CupertinoOptions(takePhotoIcon: "chat"),
                      materialOptions: const MaterialOptions(
                        statusBarColor: "#000000",
                        actionBarColor: "#000000",
                        actionBarTitle: "图片选择",
                        allViewTitle: "所有图片",
                        useDetailsView: false,
                        selectCircleStrokeColor: "#FF4095",
                      ),
                    );
                  } on Exception catch (e) {
                    ToastUtil.showBasicToast("取消图片选择");
                  }


                  if(resultList.isNotEmpty){
                    controller.getOcr(resultList);
                  }

                }),
            FunctionCard(icon: Icons.call_made, title: "账单导出", onTap: () {
              controller.showNotification("xixi");
            }),
          ],
        ),
      ),
    );
  }
}

class FunctionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function() onTap;
  const FunctionCard(
      {Key? key, required this.icon, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50.h,
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(239, 239, 239, 0.31),
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color.fromRGBO(108, 108, 108, 1),
            ),
            SizedBox(
              width: 5.w,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 15.sp, color: const Color.fromRGBO(89, 89, 89, 1)),
            ),
            const Spacer(),
            const Icon(
              Icons.chevron_right,
              color: Color.fromRGBO(108, 108, 108, 1),
            ),
          ],
        ),
      ),
    );
  }
}
