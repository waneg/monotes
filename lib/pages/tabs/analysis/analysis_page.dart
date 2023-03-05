import 'package:bruno/bruno.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:monotes/common/config.dart';

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeColor.bgColor,
        appBar: AppBar(
          title: Text("分析"),
          backgroundColor: ThemeColor.appBarColor,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 0),
            child: ListView(
              children: [ExpenseLineChart()],
            )));
  }
}

class ExpenseLineChart extends StatefulWidget {
  const ExpenseLineChart({super.key});

  @override
  _ExpenseLineChartState createState() => _ExpenseLineChartState();
}

class _ExpenseLineChartState extends State<ExpenseLineChart> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                color: Color(0xffffffff)),
            child: Padding(
                padding: EdgeInsets.only(
                    right: 16.sp, left: 16.sp, top: 12.sp, bottom: 12.sp),
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text("收支分析", style: TextStyle(fontSize: 16.sp),),
                  Divider(),
                  SizedBox(height: 10.sp,),
                  SizedBox(
                  height: 200.w,
                  child: LineChart(
                    mainData(),
                  ),
                )],)
                ),
          ),
        ],
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: false,
      ),
      titlesData: FlTitlesData(
          leftTitles: AxisTitles(
              sideTitles: SideTitles(reservedSize: 40, showTitles: true)),
          rightTitles: AxisTitles(
              sideTitles: SideTitles(reservedSize: 40, showTitles: false)),
          topTitles: AxisTitles(
              sideTitles: SideTitles(reservedSize: 40, showTitles: false)),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(reservedSize: 40, showTitles: true))),
      minX: 1,
      maxX: 12,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: [
        FlSpot(1, 3),
        FlSpot(2, 2),
        FlSpot(3, 5),
        FlSpot(4, 3.1),
        FlSpot(5, 4),
        FlSpot(6, 3),
        FlSpot(7, 4),
        FlSpot(8, 3),
        FlSpot(9, 3.5),
        FlSpot(10, 3.2),
        FlSpot(11, 3.9),
        FlSpot(12, 2.9)
      ],
      isCurved: false,
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
    );
    return [lineChartBarData1];
  }
}
