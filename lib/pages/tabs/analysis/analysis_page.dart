import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:monotes/common/config.dart';
import 'package:monotes/pages/tabs/analysis/analysis_controller.dart';
import 'package:monotes/widgets/doughnut_chart_card.dart';
import 'package:monotes/widgets/separated_card.dart';

class AnalysisPage extends GetView<AnalysisController> {
  AnalysisPage({super.key});

  final _ = Get.put(AnalysisController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeColor.bgColor,
        appBar: AppBar(
          title: const Text("分析"),
          backgroundColor: ThemeColor.appBarColor,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: RefreshIndicator(
          onRefresh: () => Future.delayed(const Duration(seconds: 1), controller.refreshUi),
          child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 10.w,
                    ),
                    child: Row(
                      children: [
                        Obx(() => TextButton(
                              onPressed: () {
                                controller.showMode.value = 0;
                              },
                              child: Text(
                                "年度",
                                style: controller.showMode.value == 0
                                    ? const TextStyle(color: Colors.black)
                                    : const TextStyle(color: Colors.grey),
                              ),
                            )),
                        Obx(() => TextButton(
                            onPressed: () {
                              controller.showMode.value = 1;
                            },
                            child: Text(
                              "月度",
                              style: controller.showMode.value == 1
                                  ? const TextStyle(color: Colors.black)
                                  : const TextStyle(color: Colors.grey),
                            ))),
                        const Spacer(),
                        Obx(() => TextButton(
                              onPressed: () {
                                DateTime datetime = DateTime.now();
                                if (controller.showMode.value == 0) {
                                  Pickers.showDatePicker(context,
                                      mode: DateMode.Y,
                                      minDate:
                                          PDuration(year: datetime.year - 8),
                                      maxDate: PDuration(year: datetime.year),
                                      onConfirm: (p) {
                                    controller.year.value = p.year!;
                                    // TODO : 发送网络请求，更新图表
                                    controller.refreshUi();
                                  });
                                } else {
                                  Pickers.showDatePicker(context,
                                      mode: DateMode.YM,
                                      minDate:
                                          PDuration(year: datetime.year - 10),
                                      maxDate: PDuration(
                                          year: datetime.year,
                                          month: datetime.month),
                                      onConfirm: (p) {
                                    controller.month.value =
                                        DateTime(p.year!, p.month!);
                                    print(controller.month.value);
                                    controller.refreshUi();
                                  });
                                }
                              },
                              style: ButtonStyle(
                                  foregroundColor:
                                      const MaterialStatePropertyAll(
                                          Color(0xff343434)),
                                  textStyle: MaterialStatePropertyAll(TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold))),
                              child: Text(
                                controller.showMode.value == 0
                                    ? "${controller.year.value}年"
                                    : "${controller.month.value.year}年${controller.month.value.month}月",
                              ),
                            ))
                      ],
                    ),
                  ),
                  SeparatedCard(
                      title: "支出趋势",
                      widget: ExpenseLineChart(controller.spotsYear,
                          controller.spotsMonth, controller.showMode)),
                  Obx(()=>DoughnutChartCard(controller.yearItems, controller.monthItems, controller.showMode)),
                  Obx(()=>SeparatedCard(
                      title: "支出构成",
                      widget: Column(
                        children: controller.getExpenditureItems(),
                      )))
                  ,
                ],
              )),
        ));
  }
}

class ExpenseLineChart extends StatefulWidget {
  final RxList<FlSpot> spotsYear;
  final RxList<FlSpot> spotsMonth;
  final RxInt mode;

  ExpenseLineChart(this.spotsYear, this.spotsMonth, this.mode, {super.key});

  @override
  _ExpenseLineChartState createState() => _ExpenseLineChartState();
}

class _ExpenseLineChartState extends State<ExpenseLineChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5.w, right: 5.w),
      height: 150.w,
      child: Obx(() => LineChart(mainData())),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
          getTouchedSpotIndicator:
              (LineChartBarData barData, List<int> spotIndexes) {
            return spotIndexes.map((index) {
              return TouchedSpotIndicatorData(
                  FlLine(
                    color: Colors.blueAccent,
                  ),
                  FlDotData());
            }).toList();
          },
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Colors.blueAccent,
            getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
              return lineBarsSpot.map((lineBarSpot) {
                return LineTooltipItem(
                  lineBarSpot.y.toString(),
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList();
            },
          )),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: false,
      ),
      titlesData: FlTitlesData(
          leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
              axisNameWidget: const Text(
                "金额",
                style: TextStyle(height: 0.1),
              )),
          rightTitles: AxisTitles(
              sideTitles: SideTitles(reservedSize: 70, showTitles: false)),
          topTitles: AxisTitles(
              sideTitles: SideTitles(reservedSize: 80, showTitles: false)),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
            interval: 1,
            reservedSize: 40,
            showTitles: true,
            getTitlesWidget: (value, meta) => value % 3 == 0
                ? Obx(() => Text(
                    "${value.toInt()}${widget.mode.value == 0 ? "月" : "日"}",
                    style:
                        TextStyle(fontSize: 10.sp, color: const Color(0xffBEBEBE))))
                : Container(),
          ))),
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: Colors.black12, width: 1.w),
          left: BorderSide(color: Colors.transparent, width: 10.w),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      ),
      lineBarsData: linesBarData(),
    );
  }

  List<LineChartBarData> linesBarData() {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: widget.mode.value == 0
          ? widget.spotsYear
          : widget.spotsMonth,
      color: ThemeColor.appBarColor,
      isCurved: false,
      barWidth: 3,
      isStrokeCapRound: false,
      dotData: FlDotData(
          show: true,
          getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
              color: Colors.white,
              strokeColor: Colors.blueAccent,
              strokeWidth: 2.sp)),
    );
    return [lineChartBarData1];
  }
}
