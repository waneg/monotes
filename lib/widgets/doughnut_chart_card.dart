import 'dart:math';

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:monotes/common/config.dart';
import 'package:monotes/widgets/separated_card.dart';

class DoughnutChartCard extends StatefulWidget {
  const DoughnutChartCard({Key? key}) : super(key: key);

  @override
  State<DoughnutChartCard> createState() => _DoughnutChartCardState();
}

class _DoughnutChartCardState extends State<DoughnutChartCard> {
  @override
  Widget build(BuildContext context) {
    return SeparatedCard(
        title: "支出分析",
        widget: BrnDoughnutChart(
          width: double.infinity,
          height: 250.w,
          padding:
              EdgeInsets.only(left: 50.w, right: 50.w, top: 20.w, bottom: 20.w),
          data: getChartData(),
        ));
  }

  List<BrnDoughnutDataItem> getChartData() {
    List<BrnDoughnutDataItem> ans = [];
    SHOPPING_TYPE.forEach((key, value) {
      ans.add(BrnDoughnutDataItem(
          value: 0.05,
          title: value,
          color: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),
              Random().nextInt(256), 1)));
    });
    return ans;
  }
}
