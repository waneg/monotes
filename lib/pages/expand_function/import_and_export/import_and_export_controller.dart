import 'package:dio/dio.dart' as dio;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:monotes/pages/tabs/bills/bills_controller.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../../common/my_exception.dart';
import '../../../common/toast_util.dart';
import '../../../core/network/dio_util.dart';

class ImportAndExportController extends GetxController {
  FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: android);
    localNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  showNotification(String msg) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your channel id', 'your channel name',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await localNotificationsPlugin
        .show(0, '批量操作结果', msg, platformChannelSpecifics, payload: 'item x');
  }

  getOcr(List<AssetEntity> resultList) async {
    ToastUtil.showBasicToast("您已选择${resultList.length}张图片，后台将为您智能识别");
    List<dio.MultipartFile> images = <dio.MultipartFile>[];
    if (resultList.isNotEmpty) {
      for (AssetEntity asset in resultList) {
        // final byteData = await asset.by;
        // List<int> imageData = byteDatabuffer.;
        dio.MultipartFile imageFile = await multipartFileFromAssetEntity(asset);
        images.add(imageFile);
      }
    }
    var formData = dio.FormData.fromMap({
      "file": images,
    });

    await sendImages(formData).then((value) => {
          if (value >= 0)
            {
              showNotification(
                  "批量识别已完成，识别到$value/${resultList.length}张账单，请前往账单页面查看"),
            }
          else
            {
              showNotification("批量识别失败，请重试"),
            }
        });
  }

  Future<dio.MultipartFile> multipartFileFromAssetEntity(
      AssetEntity entity) async {
    dio.MultipartFile mf;
    // Using the file path.
    final file = await entity.file;
    if (file == null) {
      throw StateError('Unable to obtain file of the entity ${entity.id}.');
    }
    mf = await dio.MultipartFile.fromFile(file.path);
    // Using the bytes.
    final bytes = await entity.originBytes;
    if (bytes == null) {
      throw StateError('Unable to obtain bytes of the entity ${entity.id}.');
    }
    mf = dio.MultipartFile.fromBytes(bytes, filename: entity.title);
    return mf;
  }

  Future<int> sendImages(dio.FormData formData) async {
    try {
      var response = await DioUtils().post('/bill/ocr',
          data: formData,
          options: dio.Options(receiveTimeout: const Duration(seconds: 60)));
      BillsController billsController = Get.find();
      await billsController.refreshAllData();
      // if (response.data["code"] == 1) {
      return response.data["data"];
      // } else {
      //   throw MyException(response["msg"]);
      // }
    } on MyException catch (e) {
      print(e);
      return -1;
    }
  }
}
