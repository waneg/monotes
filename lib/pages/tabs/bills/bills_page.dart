import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:monotes/common/config.dart';
import 'package:monotes/pages/tabs/bills/bills_controller.dart';
import 'package:monotes/routes/app_routes.dart';
import 'package:monotes/widgets/conclusion_card.dart';
import 'package:monotes/widgets/detail_card.dart';

class BillsPage extends StatelessWidget {
  BillsPage({Key? key}) : super(key: key);

  var billsController = Get.put<BillsController>(BillsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.pageColor,
      appBar: AppBar(
        backgroundColor: ThemeColor.appBarColor,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text("账单明细"),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 20.w, 20.2, 0),
        child: Column(
          children: [
            ConclusionCard(0, 0, 0),
            Padding(
              padding: const EdgeInsets.all(15),
              child: CupertinoButton(
                onPressed: () => {Get.toNamed(Routes.RECORD)},
                color: const Color(0xFF93D2F3),
                child: const Text("添加一条新记账"),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: Stack(
                children: [
                  Positioned(
                      left: 0,
                      top: 0,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text("收支分析 >"),
                      )),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text("筛选"),
                    ),
                  )
                ],
              ),
            ),
            Obx(() => Expanded(
                child: ListView.builder(
                    itemCount: billsController.billItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return DetailCard(billsController.billItems[index]);
                    })))
          ],
        ),
      ),
    );
  }
}
