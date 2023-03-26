import 'package:get/get.dart';
import 'package:monotes/core/network/dio_util.dart';
import 'package:monotes/models/bills_detail.dart';

import '../../../common/my_exception.dart';
import '../../../common/toast_util.dart';

class BillsController extends GetxController {
  RxList billItems = [].obs;
  RxDouble monthlyPay = 0.0.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    getBills();
    getMonthlyPay();
    super.onInit();
  }

  getBills() async {
    try {
      var response = await DioUtils().get("/bill/getList");
      var list = response.data['data'];
      var tempList = [];
      for (var item in list) {
        tempList.add(BillsDetail.fromJson(item));
      }
      billItems.value = tempList;
      update();
    } on MyException catch (e) {
      print(e);
      ToastUtil.showBasicToast(e.msg);
    } on Exception catch (e) {
      print(e);
    }
  }

  editBill(int selectedIndex, double price) async {
    try {
      BillsDetail item = billItems[selectedIndex];
      int billId = item.billId;
      var response = await DioUtils().put("/bill/editRecord", data: {"billId":billId, "price": price});
      BillsDetail eitem = BillsDetail(item.billId, item.typeId, price, item.goods, item.time);
      billItems[selectedIndex] = eitem;
      getMonthlyPay();
    } on MyException catch (e) {
      print(e);
      ToastUtil.showBasicToast(e.msg);
    } on Exception catch (e) {
      print(e);
    }
  }


  deleteBill(int selectedIndex) async {
    try {
      BillsDetail item = billItems[selectedIndex];
      String billId = item.billId.toString();
      await DioUtils().delete("/bill/delete/$billId");
      ToastUtil.showBasicToast("删除成功");
      billItems.removeAt(selectedIndex);
      getMonthlyPay();
      update();
    } on MyException catch (e) {
      print(e);
      ToastUtil.showBasicToast(e.msg);
    } on Exception catch (e) {
      print(e);
    }
  }
  
  getMonthlyPay() async{
    try{
      var response = await DioUtils().get("/analysis/curMonthTotal");
      double money = response.data['data'];
      monthlyPay.value = money;
    }on MyException catch (e) {
      print(e);
      ToastUtil.showBasicToast(e.msg);
    } on Exception catch (e) {
      print(e);
    }
  }

  refreshAllData(){
    getBills();
    getMonthlyPay();
  }

  selectBills(int year, int month) async {
    await getBills();
    String format = "$year-${month.toString().padLeft(2,'0')}";
    print(format);
    var tempList = [];
    for(BillsDetail item in billItems){
      if(item.time.startsWith(format)){
        tempList.add(item);
      }
    }
    billItems.value = tempList;
  }
}
