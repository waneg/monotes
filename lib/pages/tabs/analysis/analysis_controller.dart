import 'package:get/get.dart';
import 'package:monotes/models/expenditure_info.dart';
import 'package:monotes/widgets/expenditure_item.dart';

class AnalysisController extends GetxController {
  List<ExpenditureInfo> items = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getExpenditureInfo();
  }

  void getExpenditureInfo() {
    for (int i = 1; i < 20; i++) {
      items.add(ExpenditureInfo(i, 1200, 5));
    }
  }

  List<ExpenditureItem> getExpenditureItems() {
    print(items.length);
    List<ExpenditureItem> ans = [];
    for (var item in items) {
      ans.add(ExpenditureItem(
          typeId: item.typeId, amount: item.amount, pct: item.pct));
    }
    return ans;
  }
}
