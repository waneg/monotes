import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:monotes/common/config.dart';
import 'package:monotes/models/expenditure_info.dart';
import 'package:monotes/widgets/expenditure_item.dart';

class AnalysisController extends GetxController {
  List<ExpenditureInfo> items = [];
  var spots = [
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
  ].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getExpenditureInfo();
  }

  void getExpenditureInfo() {
    SHOPPING_TYPE.forEach((key, value) {items.add(ExpenditureInfo(key, 1200, 5));});
  }

  List<ExpenditureItem> getExpenditureItems() {
    // print(items.length);
    List<ExpenditureItem> ans = [];
    for (var item in items) {
      ans.add(ExpenditureItem(
          typeId: item.typeId, amount: item.amount, pct: item.pct));
    }
    return ans;
  }
}
