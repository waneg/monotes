import 'dart:io';

import 'package:bruno/bruno.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:monotes/common/config.dart';
import 'package:monotes/models/record_detail.dart';
import 'package:monotes/pages/tabs/record/record_controller.dart';
import 'package:monotes/routes/app_routes.dart';

class RecordPage extends GetView<RecordController> {
  RecordPage({super.key});

  late File _image;

  final picker = ImagePicker();

  Future getImage() async {
    print("getImage() clicked");
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      Future<RecordDetail> future = controller.getOcrInfo(_image);
      future.then((value) {
        print(value);
        controller.setInfo(value);
      });
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.w),
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
                        Container(
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
                    ), //消费时间
                    Row(
                      children: [
                        Text(
                          "消费金额",
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        const Spacer(),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: 200.sp,
                          child: TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
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
                    ), //消费金额
                    Row(
                      children: [
                        Text(
                          "消费信息",
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        const Spacer(),
                        Container(
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
                    ), //消费店家
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
                    Container(
                        margin: EdgeInsets.all(8.w),
                        child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              childAspectRatio: 1.0, //显示区域宽高相等
                            ),
                            itemCount: controller.consumptionTypes.length,
                            itemBuilder: (context, index) {
                              var info = controller.consumptionTypes[index];
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
                                          width: 20.w,
                                          height: 20.w,
                                          child: SvgPicture.asset(
                                            "assets/bill_icons/${index + 1}.svg",
                                            width: 20.w,
                                            height: 20.w,
                                          ),
                                        ),
                                        Text(SHOPPING_TYPE[index + 1] ?? "",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 13.sp,
                                                height: 2))
                                      ],
                                    ),
                                  ));
                            }))
                  ],
                )),
            const Spacer(),
            Column(
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.green,
                  onPressed: getImage,
                  child: const Icon(Icons.camera_enhance_outlined),
                ),
                const Text(
                  "扫描账单",
                  style: TextStyle(color: Color(0xFF101010), height: 2),
                )
              ],
            ),
            ElevatedButton(
                onPressed: controller.submitRecord, child: const Text("确定")),
          ],
        ),
      ),
    );
  }
}
