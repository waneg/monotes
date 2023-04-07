import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:monotes/common/config.dart';
import 'package:monotes/common/toast_util.dart';
import 'package:monotes/models/record_detail.dart';
import 'package:monotes/pages/tabs/record/record_controller.dart';

class RecordPage extends GetView<RecordController> {
  RecordPage({super.key});

  // 拍摄的照片
  late File _image;

  // 图片获取对象
  final picker = ImagePicker();

  Future getImage(int device) async {
    print("getImage() clicked");
    XFile? pickedFile;
    if (device == 0) {
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    } else {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }

    if (pickedFile != null) {
      print("文件的路径：${pickedFile.path}");
      Future<RecordDetail> future = controller.getOcrInfo(pickedFile.path);
      future.then((value) {
        print(value);
        controller.setInfo(value);
      });
    } else {
      ToastUtil.showBasicToast("选取照片失败");
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: controller.submitRecord,
              icon: const Text(
                "提交",
              ))
        ],
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        automaticallyImplyLeading: true,
        title: const Text("记一笔"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10.w),
        width: double.infinity,
        color: ThemeColor.bgColor,
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(
                    left: 15.w, right: 15.w, top: 15.w, bottom: 4.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.w))),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "消费时间",
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 40.sp,
                          width: 200.sp,
                          child: TextField(
                              controller: controller.inputTimeController,
                              readOnly: true,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.date_range),
                                    onPressed: () {
                                      DateTime datetime = DateTime.now();
                                      Pickers.showDatePicker(context,
                                          minDate: PDuration(
                                              year: datetime.year - 2,
                                              month: datetime.month,
                                              day: datetime.day),
                                          maxDate: PDuration(
                                              year: datetime.year,
                                              month: datetime.month,
                                              day: datetime.day),
                                          onConfirm: (p) {
                                        controller.inputTimeController.text =
                                            DateTime(p.year ?? 2023,
                                                    p.month ?? 12, p.day ?? 12)
                                                .toString();
                                      });
                                    },
                                  ),
                                  contentPadding: const EdgeInsets.all(10),
                                  enabled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ))),
                        )
                      ],
                    ),
                    //消费时间
                    Row(
                      children: [
                        Text(
                          "消费金额",
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        const Spacer(),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          height: 40.sp,
                          width: 200.sp,
                          child: TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter(RegExp("[0-9.]"), allow: true)
                              ],
                              controller: controller.inputCostController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10),
                                  enabled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ))),
                        )
                      ],
                    ),
                    //消费金额
                    Row(
                      children: [
                        Text(
                          "消费信息",
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        const Spacer(),
                        Container(
                          height: 40.sp,
                          margin: const EdgeInsets.only(top: 10),
                          width: 200.sp,
                          child: TextField(
                              controller: controller.goodsController,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(15),
                                  enabled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ))),
                        )
                      ],
                    ),
                    //消费店家
                    SizedBox(
                      height: 10.w,
                    ),
                    TextField(
                        controller: controller.remarkController,
                        style: TextStyle(fontSize: 12.sp),
                        decoration: InputDecoration(
                            fillColor: ThemeColor.bgColor,
                            filled: true,
                            contentPadding: const EdgeInsets.all(10),
                            border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            hintText: "请输入备注",
                            prefix: const Text("备注："),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.transparent, width: 0.5),
                                borderRadius: BorderRadius.circular(5.w)))),
                    // 备注信息
                    Container(
                        margin: EdgeInsets.only(top: 5.w),
                        child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              childAspectRatio: 1.15, //显示区域宽高相等
                            ),
                            itemCount: controller.consumptionTypes.length,
                            itemBuilder: (context, index) {
                              return Obx(() => TextButton(
                                    style: ButtonStyle(
                                        overlayColor: MaterialStateProperty.all(
                                            Colors.transparent),
                                        backgroundColor:
                                            controller.selectedType.value ==
                                                    index + 1
                                                ? MaterialStateProperty.all(
                                                    ThemeColor.bgColor)
                                                : null),
                                    onPressed: () {
                                      controller.selectedType.value = index + 1;
                                    },
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: 18.w,
                                          height: 18.w,
                                          child: SvgPicture.asset(
                                            "assets/bill_icons/${index + 1}.svg",
                                            width: 18.w,
                                            height: 18.w,
                                          ),
                                        ),
                                        Text(SHOPPING_TYPE[index + 1] ?? "",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 12.sp,
                                                height: 2))
                                      ],
                                    ),
                                  ));
                            })),
                    Row(
                      children: [
                        SizedBox(
                          width: 60.sp,
                          height: 35.sp,
                          child: TextField(
                            controller: controller.addLabelController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 10.sp),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.sp)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w,),
                        TextButton(
                            onPressed: controller.addLabel,
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          10.w))),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.blue),
                              foregroundColor:
                                  MaterialStateProperty.all<Color>(Colors.white),
                            ),
                            child: const Text("新增")
                            ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                            child: Obx(() => SizedBox(
                                  width: double.infinity,
                                  child: GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    //子Item的个数
                                    itemCount: controller.labelList.length,
                                    //子布局构建器
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      //取出每个数据
                                      return InputChip(label: Text(controller.labelList[index]),
                                      onDeleted: (){
                                        controller.labelList.removeAt(index);
                                      },);
                                    },
                                    //子布局排列方式
                                    //按照固定列数来排列
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      //次方向的Item间隔
                                      crossAxisSpacing: 3.w,
                                      //每行4列
                                      crossAxisCount: 4,
                                    ),
                                  ),
                                ))),
                      ],
                    )
                  ],
                )),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100.w,
                ),
                Column(
                  children: [
                    FloatingActionButton(
                      backgroundColor: Colors.green,
                      onPressed: () {
                        getImage(0);
                      },
                      child: const Icon(Icons.camera_enhance_outlined),
                    ),
                    const Text(
                      "扫描账单",
                      style: TextStyle(color: Color(0xFF101010), height: 2),
                    )
                  ],
                ),
                SizedBox(
                  width: 10.w,
                ),
                TextButton(
                    onPressed: () {
                      getImage(1);
                    },
                    child: const Text(
                      "从相册中选取图片",
                      style: TextStyle(color: Colors.grey),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
