import 'package:flutter/material.dart';
import '../../../widgets/detail_card.dart';
import 'introductory_controller.dart';
import 'package:get/get.dart';
import 'package:monotes/common/config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bruno/bruno.dart';

class IntroductoryPage extends GetView<IntroductoryController> {
  const IntroductoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: ThemeColor.pageColor,
      appBar: AppBar(
        title: Text("首页"),
        backgroundColor: ThemeColor.appBarColor,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        children: [
          const Center(
            child: Text("待放东西，没想好"),
          ),
          SizedBox(height: 30.h,),
          Text("常用标签", style: TextStyle(fontSize: 20.sp, color: const Color.fromRGBO(31, 41, 51, 1.0)),),
          SizedBox(height: 20.h,),
          Wrap(
              alignment: WrapAlignment.center,
              spacing: 10, //主轴间距
              runSpacing: 10, //次轴间距
              children: List.generate(controller.labelItem.length, (index){return LabelCard(str: controller.labelItem[index]);})
          ),
          SizedBox(height: 30.h,),
          Text("近3日账单", style: TextStyle(fontSize: 20.sp, color: const Color.fromRGBO(31, 41, 51, 1.0)),),
          SizedBox(height: 20.h,),
          Obx((){
            if(controller.billItems.isNotEmpty){
              return ListView.builder(
                  shrinkWrap: true,
                  controller: controller.scrollController,
                  itemCount: controller.billItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return DetailCard(controller.billItems[index]);
                  }
              );
            }else {
              return const Center(child: Text("暂时没有账单", style: TextStyle(color: Colors.black54),),);
            }
          })
        ],
        ),
      );
  }
}

class LabelCard extends StatelessWidget {
  final String str;
  const LabelCard({Key? key, required this.str}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.w),
      ),
      alignment: Alignment.center,
      child: Text(str),
    );
  }
}
