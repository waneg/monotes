import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:monotes/core/network/dio_util.dart';
import 'package:monotes/models/expenditure_info.dart';
import 'package:monotes/widgets/expenditure_item.dart';

class AnalysisController extends GetxController {
  // 0 月度， 1表示年度
  RxInt showMode = 0.obs;
  RxInt year = 2023.obs;
  Rx<DateTime> month = DateTime(2023, 3).obs;

  RxList<ExpenditureInfo> yearItems = <ExpenditureInfo>[].obs;
  RxList<ExpenditureInfo> monthItems = <ExpenditureInfo>[].obs;

  var spotsYear = [
    const FlSpot(1, 0),
    const FlSpot(2, 0),
    const FlSpot(3, 0),
    const FlSpot(4, 0),
    const FlSpot(5, 0),
    const FlSpot(6, 0),
    const FlSpot(7, 0),
    const FlSpot(8, 0),
    const FlSpot(9, 0),
    const FlSpot(10, 0),
    const FlSpot(11, 0),
    const FlSpot(12, 0)
  ].obs;

  RxList<FlSpot> spotsMonth = <FlSpot>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getMonthTrendInfo(year.value);
    getDayTrendInfo(month.value.year, month.value.month);
    getProportion(Period.year, year: year.value);
    getProportion(Period.month, month: month.value);
  }

  // 刷新界面
  void refreshUi() {
    getMonthTrendInfo(year.value);
    getDayTrendInfo(month.value.year, month.value.month);
    getProportion(Period.year, year: year.value);
    getProportion(Period.month, month: month.value);
  }

  // 获取消费条目，返回一个组件列表
  List<ExpenditureItem> getExpenditureItems() {
    // print(items.length);
    List<ExpenditureItem> ans = [];
    var items = showMode.value == 0 ? yearItems : monthItems;
    for (var item in items) {
      ans.add(ExpenditureItem(
          typeId: item.typeId, amount: item.amount, pct: item.pct));
    }
    return ans;
  }

  // 获取月度消费趋势
  getMonthTrendInfo(int year) async {
    var response =
        await DioUtils().get('/analysis/trend/month/$year-1/$year-12');
    var data = response.data;
    clearYearSpots();
    for (var item in data['data']) {
      int month = item['month'];
      spotsYear[month - 1] = FlSpot(month.toDouble(), item['total']);
      print("月度信息${spotsMonth[month - 1]}");
    }
    print(data);
  }

  // 获取日度消费趋势
  getDayTrendInfo(int year, int month) async {
    var response = await DioUtils()
        .get('/analysis/trend/day/$year-$month-1/$year-$month-30');
    var data = response.data;
    clearMonthSpots();
    for (var item in data['data']) {
      int day = int.parse(item['date'].split('-')[2]);
      spotsMonth[day - 1] = FlSpot(day.toDouble(), item['total']);
    }
  }

  void clearYearSpots() {
    spotsYear.clear();
    for (int i = 1; i <= 12; i++) {
      spotsYear.add(FlSpot(i.toDouble(), 0.0));
    }
  }

  void clearMonthSpots() {
    spotsMonth.clear();
    var cnt = DateTime(year.value, month.value.month + 1, 0).day;
    for (int i = 1; i <= cnt; i++) {
      spotsMonth.add(FlSpot(i.toDouble(), 0.0));
    }
  }

  void getProportion(Period p, {int year = 2023, var month}) async {
    var response;
    if (p == Period.year) {
      response = await DioUtils().get('/analysis/typeProportion/year/$year');
      yearItems.clear();
      for (var item in response.data['data']) {
        yearItems.add(ExpenditureInfo(
            item['typeId'], item['total'], item['percent'] * 100));
      }
    } else {
      response = await DioUtils()
          .get('/analysis/typeProportion/month/${month.year}-${month.month}');
      monthItems.clear();
      for (var item in response.data['data']) {
        monthItems.add(ExpenditureInfo(
            item['typeId'], item['total'], item['percent'] * 100));
      }
    }
  }
}

enum Period {
  year,
  month
}