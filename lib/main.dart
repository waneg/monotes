import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monotes/common/config.dart';
import 'package:monotes/common/storage_util.dart';
import 'package:monotes/routes/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.SPLASH,
            getPages: AppPages.pages,
          );
        });
  }
}
