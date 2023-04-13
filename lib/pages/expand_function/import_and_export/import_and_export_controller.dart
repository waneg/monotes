import 'dart:io';
import 'package:bruno/bruno.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:monotes/pages/tabs/bills/bills_controller.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../common/my_exception.dart';
import '../../../common/toast_util.dart';
import '../../../core/network/dio_util.dart';

class ImportAndExportController extends GetxController {

  FlutterLocalNotificationsPlugin localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void onInit()async{
    // TODO: implement onInit
    super.onInit();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings = InitializationSettings(android: android);
    localNotificationsPlugin.initialize(initializationSettings,);
  }



  showNotification(String msg)async{
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await localNotificationsPlugin.show(0, 'Monotes', msg, platformChannelSpecifics,payload: 'item x');
  }

  getOcr (List<Asset> resultList) async{
    ToastUtil.showBasicToast("您已选择${resultList.length}张图片，后台将为您智能识别");
    List<dio.MultipartFile> images = <dio.MultipartFile>[];
    if(resultList.isNotEmpty && resultList.first.originalHeight != null && resultList.first.originalWidth != null){
      for(Asset asset in resultList){
        final byteData = await asset.getByteData();
        List<int> imageData = byteData.buffer.asUint8List();
        dio.MultipartFile imageFile = dio.MultipartFile.fromBytes(imageData, filename: "${DateTime.now().toString()}.jpg", );
        images.add(imageFile);
      }
    }
    var formData = dio.FormData.fromMap({
      "file": images,
    });

    await sendImages(formData).then((value) => {
      showNotification("批量识别已完成")
    }).catchError((error){
      showNotification("批量识别出错，请重试");
    });

  }




  Future<bool> sendImages(dio.FormData formData)async{
    try{
      var response = await DioUtils().post('/bill/ocr', data: formData, options: dio.Options(receiveTimeout: 60000));
      BillsController billsController = Get.find();
      await billsController.refreshAllData();
      return true;
    }on MyException catch (e) {
      print(e);
      ToastUtil.showBasicToast(e.msg);
      return false;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

}