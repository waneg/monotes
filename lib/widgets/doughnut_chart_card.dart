import 'dart:math';

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:monotes/common/config.dart';
import 'package:monotes/models/expenditure_info.dart';
import 'package:monotes/widgets/separated_card.dart';

class DoughnutChartCard extends StatelessWidget {
  final RxList<ExpenditureInfo> _expenditureYearInfo;
  final RxList<ExpenditureInfo> _expenditureMonthInfo;
  final RxInt _mode;

  DoughnutChartCard(
      this._expenditureYearInfo, this._expenditureMonthInfo, this._mode,
      {Key? key})
      : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SeparatedCard(
        title: "支出分析",
        widget: Obx(() {
          if (_mode.value == 0 && _expenditureYearInfo.isEmpty || _mode.value == 1 && _expenditureMonthInfo.isEmpty) {
            return const Text("暂无数据");
          }
          return BrnDoughnutChart(
            width: double.infinity,
            height: 250.w,
            padding: EdgeInsets.only(
                left: 40.w, right: 40.w, top: 20.w, bottom: 20.w),
            data: getChartData(_mode.value == 0
                ? _expenditureYearInfo
                : _expenditureMonthInfo),
          );
        }));
  }

  List<BrnDoughnutDataItem> getChartData(items) {
    List<BrnDoughnutDataItem> ans = <BrnDoughnutDataItem>[];
    for (var item in items) {
      ans.add(BrnDoughnutDataItem(
          value: item.pct / 100,
          title: SHOPPING_TYPE[item.typeId]!,
          color: Color.fromRGBO(Random().nextInt(255), Random().nextInt(255),
              Random().nextInt(255), 0.5)));
    }
    return ans;
  }
}
