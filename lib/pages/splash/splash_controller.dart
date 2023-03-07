import 'package:get/get.dart';
import 'package:monotes/common/storage_util.dart';
import 'package:monotes/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    countDown();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  countDown() async {
    var _duration = const Duration(seconds: 3);
    bool? isLogin = await StorageUtil.getBoolItem("isLogin") ?? false;
    print(isLogin);
    if (isLogin != null && isLogin) {
      Future.delayed(_duration, newHomePage);
    } else {
      Future.delayed(_duration, newLoginPage);
    }
  }

  newLoginPage() {
    Get.toNamed(Routes.CODE_LOGIN_STEP_ONE);
  }

  newHomePage() {
    Get.offAllNamed(Routes.HOME);
  }
}
