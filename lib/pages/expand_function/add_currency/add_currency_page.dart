import 'add_currency_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:monotes/widgets/currency_card.dart';
import 'package:bruno/bruno.dart';

class AddCurrencyPage extends GetView<AddCurrencyController> {
  const AddCurrencyPage({super.key});

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
          "选择币种",
          style: TextStyle(color: Colors.black, fontSize: 20.sp),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.only(left: 20, right: 20).w,
          children: [
            SizedBox(height: 10.h,),
            const Text("汇率更新时间：3月1日08:00", style: TextStyle(color: Color.fromRGBO(89, 89, 89, 1)),),
            SizedBox(height: 15.h,),
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
                          message: "是否确认添加该币种？",
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