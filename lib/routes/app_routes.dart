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
import 'package:monotes/pages/login/codeLoginStepOne/codeLoginStepOne_page.dart';
import 'package:monotes/pages/login/codeLoginStepOne/codeLoginStepOne_binding.dart';
import 'package:monotes/pages/login/codeLoginStepTwo/codeLoginStepTwo_page.dart';
import 'package:monotes/pages/login/codeLoginStepTwo/codeLoginStepTwo_binding.dart';

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
        binding: RecordBinding()
    ),
    GetPage(
        name: Routes.CODE_LOGIN_STEP_ONE,
        page: () => codeLoginStepOnePage(),
        binding: codeLoginStepOneBinding()
    ),
    GetPage(
        name: Routes.CODE_LOGIN_STEP_TWO,
        page: () => codeLoginStepTwoPage(),
        binding: codeLoginStepTwoBinding()
    ),

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

  // 验证码登录第一步——输入手机号
  static const CODE_LOGIN_STEP_ONE = "/code-login-step-one";

  // 验证码登录第二步——输入验证码
  static const CODE_LOGIN_STEP_TWO = "/code-login-step-two";
}
