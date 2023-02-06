import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monotes/pages/home/home_controller.dart';
import 'package:monotes/pages/tabs/analysis/analysis_page.dart';
import 'package:monotes/pages/tabs/bills/bills_page.dart';
import 'package:monotes/pages/tabs/introductory/introductory_page.dart';
import 'package:monotes/pages/tabs/person/person_page.dart';
import 'package:monotes/pages/tabs/record/record_page.dart';
import 'package:monotes/routes/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final tabPages = [
    IntroductoryPage(),
    BillsPage(),
    RecordPage(),
    AnalysisPage(),
    PersonPage()
  ];
  int _currentIndex = 0;
  final barItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
    BottomNavigationBarItem(icon: Icon(Icons.money_rounded), label: "账单"),
    BottomNavigationBarItem(icon: Icon(Icons.abc), label: "记一笔"),
    BottomNavigationBarItem(icon: Icon(Icons.analytics), label: "分析"),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: "我的"),
  ];
  var homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabPages.elementAt(_currentIndex),
      floatingActionButton: FloatingActionButton(
        onPressed: addRecord,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
          fixedColor: const Color.fromRGBO(64, 149, 229, 1),
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              index == 2 ? addRecord() : _currentIndex = index;
            });
          },
          items: barItems),
    );
  }

  void addRecord() {
    Get.toNamed(Routes.RECORD);
  }
}
