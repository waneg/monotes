import 'package:bruno/bruno.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:monotes/common/config.dart';
import 'package:monotes/common/toast_util.dart';
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
        backgroundColor: ThemeColor.bgColor,
        appBar: AppBar(
          backgroundColor: ThemeColor.appBarColor,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text("账单明细"),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await billsController.getBills();
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 20.w, 20.2, 0),
            child: Column(
              children: [
                Obx(() => ConclusionCard(0, billsController.monthlyPay.value,
                    -billsController.monthlyPay.value)),
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
                        right: 0,
                        top: 0,
                        child: TextButton(
                          onPressed: () {
                            DateTime datetime = DateTime.now();
                            Pickers.showDatePicker(context,
                                mode: DateMode.YM,
                                minDate: PDuration(year: datetime.year - 3),
                                maxDate: PDuration(
                                    year: datetime.year,
                                    month: datetime.month), onConfirm: (p) {
                              int? year = p.year;
                              int? month = p.month;
                              if (year != null && month != null) {
                                billsController.selectBills(year, month);
                              } else {
                                ToastUtil.showBasicToast("筛选失败");
                              }
                            });
                          },
                          child: Text(
                            "筛选",
                            style: TextStyle(
                                color: Colors.indigo,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold),
                          ),
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
                                  onPressed: (context) {
                                    BrnMiddleInputDialog(
                                        title: "修改账单金额",
                                        cancelText: "取消",
                                        confirmText: "确定",
                                        autoFocus: true,
                                        maxLines: 1,
                                        keyboardType: TextInputType.number,
                                        onConfirm: (value) {
                                          if (double.tryParse(value) != null) {
                                            if (double.tryParse(value) == 0) {
                                              ToastUtil.showBasicToast(
                                                  "金额不可为0！");
                                            } else {
                                              billsController.editBill(
                                                  index, double.parse(value));
                                              Get.back();
                                            }
                                          } else {
                                            ToastUtil.showBasicToast("请输入数字！");
                                          }
                                        },
                                        onCancel: () {
                                          Get.back();
                                        }).show(context);
                                  },
                                  backgroundColor: Colors.black45,
                                  foregroundColor: Colors.white,
                                  icon: Icons.edit,
                                  label: '修改',
                                ),
                                SlidableAction(
                                  onPressed: (context) {
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

        ));
  }
}
