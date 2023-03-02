import 'package:bruno/bruno.dart';

import 'multi_currency_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:monotes/widgets/currency_card.dart';

class MultiCurrencyPage extends GetView<MultiCurrencyController> {
  const MultiCurrencyPage({super.key});

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
          "多币种",
          style: TextStyle(color: Colors.black, fontSize: 20.sp),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 120.w,
        child: FloatingActionButton(
          onPressed: () { Get.toNamed("/add_currency"); },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.w),
          ),
          backgroundColor: const Color.fromRGBO(184, 202, 222, 1.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.add, color: Color.fromRGBO(32, 42, 47, 1.0),),
              Text("添加币种", style: TextStyle(color: Color.fromRGBO(32, 42, 47, 1.0),),),
            ],
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.only(left: 20, right: 20).w,
          children: [
            Text(
              "默认币种",
              style: TextStyle(
                  fontSize: 18.sp,
                  color: const Color.fromRGBO(63, 63, 63, 1.0))
              ,
            ),
            SizedBox(height: 16.h,),
            const CurrencyCard(name: "人民币", abbr: "CNY", symbol: "￥", rate: 1.000),
            SizedBox(height: 20.h,),
            Text(
              "其他币种",
              style: TextStyle(
                  fontSize: 18.sp,
                  color: const Color.fromRGBO(63, 63, 63, 1.0))
              ,
            ),
            SizedBox(height: 16.h,),
            ListView.builder(
                itemCount: controller.currencyItem.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  String name = controller.currencyItem[index].name;
                  String abbr = controller.currencyItem[index].abbr;
                  String symbol = controller.currencyItem[index].symbol;
                  double rate = controller.currencyItem[index].rate;
                  return InkWell(
                    child:  CurrencyCard(name: name, abbr: abbr, symbol: symbol, rate: rate),
                    onTap: (){
                      BrnDialogManager.showConfirmDialog(
                          context,
                          message: "是否确认删除该币种？",
                          cancel: "取消",
                          confirm: "确认",
                        onCancel: (){Get.back();},
                        onConfirm: (){}
                      );
                    },
                  );
                }
            ),

          ],
        ),
      ),
    );
  }

}

