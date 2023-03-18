import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
            Obx(()=> ConclusionCard(0, billsController.monthlyPay.value, 0)),
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
            Obx(() {
              if (billsController.billItems.isNotEmpty) {
                return Expanded(
                    child: SlidableAutoCloseBehavior(
                  child: ListView.separated(
                    itemCount: billsController.billItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Slidable(
                        key: const ValueKey(0),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              // An action can be bigger than the others.
                              onPressed: (context){

                              },
                              backgroundColor: Colors.black45,
                              foregroundColor: Colors.white,
                              icon: Icons.archive,
                              label: '修改',
                            ),
                            SlidableAction(
                              onPressed: (context){
                                billsController.deleteBill(index);
                              },
                              backgroundColor: Colors.redAccent,
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.zero,
                                  right: Radius.circular(8.w)),
                              foregroundColor: Colors.white,
                              icon: Icons.save,
                              label: '删除',
                            ),
                          ],
                        ),
                        child: DetailCard(billsController.billItems[index]),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 10.h,
                      );
                    },
                  ),
                ));
              } else {
                return const Center(
                  child: Text("暂时没有账单"),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
