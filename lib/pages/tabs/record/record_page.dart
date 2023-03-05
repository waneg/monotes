import 'package:bruno/bruno.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:monotes/common/config.dart';
import 'package:monotes/pages/tabs/record/record_controller.dart';
import 'package:monotes/routes/app_routes.dart';

class RecordPage extends GetView<RecordController> {
  const RecordPage({super.key});

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
                padding: EdgeInsets.all(20.w),
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
                                      Pickers.showDatePicker(context,
                                          onConfirm: (p) {
                                        controller.inputTimeController.text =
                                            "${p.year}-${p.month}-${p.day}";
                                      });
                                    },
                                  ),
                                  contentPadding: const EdgeInsets.all(15),
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
                                  contentPadding: const EdgeInsets.all(15),
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
                          "消费店家",
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        const Spacer(),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: 200.sp,
                          child: TextField(
                              controller: controller.inputMerchantController,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(15),
                                  enabled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ))),
                        )
                      ],
                    ), //消费店家
                    Container(
                        margin: EdgeInsets.all(10.w),
                        height: 300.w,
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              childAspectRatio: 1.0, //显示区域宽高相等
                            ),
                            itemCount: controller.consumptionTypes.length,
                            itemBuilder: (context, index) {
                              var info = controller.consumptionTypes[index];
                              return TextButton.icon(
                                  style: const ButtonStyle(
                                      foregroundColor: MaterialStatePropertyAll(
                                          Colors.black)),
                                  onPressed: () {
                                    controller.selectedType = (index + 1).obs;
                                    print("${index + 1}个图标被点击");
                                  },
                                  icon: SizedBox(
                                    width: 20.w,
                                    child: SvgPicture.asset(info.assetName),
                                  ),
                                  label: Text(info.label));
                            }))
                  ],
                )),
            const Spacer(),
            Column(
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.green,
                  onPressed: () {},
                  child: const Icon(Icons.camera_enhance_outlined),
                ),
                const Text(
                  "扫描账单",
                  style: TextStyle(color: Color(0xFF101010), height: 2.5),
                )
              ],
            ),
            ElevatedButton(onPressed: controller.submitRecord, child: const Text("确定")),
          ],
        ),
      ),
    );
  }
}
