import 'package:get/get.dart';
import 'package:monotes/pages/home/home_binding.dart';
import 'package:monotes/pages/home/home_page.dart';
import 'package:monotes/pages/splash/splash_binding.dart';
import 'package:monotes/pages/splash/splash_page.dart';
import 'package:monotes/pages/tabs/analysis/analysis_binding.dart';
import 'package:monotes/pages/tabs/analysis/analysis_page.dart';
import 'package:monotes/pages/tabs/bills/bills_binding.dart';
import 'package:monotes/pages/tabs/bills/bills_page.dart';
import 'package:monotes/pages/tabs/introductory/introductory_binding.dart';
import 'package:monotes/pages/tabs/introductory/introductory_page.dart';
import 'package:monotes/pages/tabs/person/person_binding.dart';
import 'package:monotes/pages/tabs/person/person_page.dart';
import 'package:monotes/pages/tabs/record/record_binding.dart';
import 'package:monotes/pages/tabs/record/record_page.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
        name: Routes.SPLASH,
        page: () => const SplashPage(),
        binding: SplashBinding()),
    GetPage(name: Routes.HOME, page: () => HomePage(), binding: HomeBinding()),
    GetPage(
        name: Routes.ANALYSIS,
        page: () => AnalysisPage(),
        binding: AnalysisBinding()),
    GetPage(
      name: Routes.INTRODUCTORY,
      page: () => IntroductoryPage(),
      binding: IntroductoryBinding(),
    ),
    GetPage(
      name: Routes.BILLS,
      page: () => BillsPage(),
      binding: BillsBinding(),
    ),
    GetPage(
        name: Routes.PERSON,
        page: () => PersonPage(),
        binding: PersonBinding()),
    GetPage(
        name: Routes.RECORD,
        page: () => RecordPage(),
        binding: RecordBinding()),
  ];

// 命名路由的名称
}

abstract class Routes {
  // 闪屏页面
  static const SPLASH = "/splash";

  // 主页面
  static const HOME = "/home";

  // 首页面
  static const INTRODUCTORY = "/introductory";

  // 账单页面
  static const BILLS = "/bills";

  // 分析页面
  static const ANALYSIS = "/analysis";

  // 个人页面
  static const PERSON = "/person";

  // 记一笔页面
  static const RECORD = "/record";
}
