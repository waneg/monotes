import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'person_controller.dart';

class PersonPage extends GetView<PersonController> {
  const PersonPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.only(left: 20, right: 20).w,
          children: [
            const InformationCard(),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                StatisticCard(
                    title: "总记账天数", value: 0, icon: Icons.calendar_month),
                StatisticCard(
                    title: "总记账次数", value: 0, icon: Icons.calendar_view_day),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "全部功能",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15.h,),
            FunctionCard(icon: Icons.add, title: "收支分析", onTap: (){}),
            FunctionCard(icon: Icons.add, title: "数据报表", onTap: (){}),
            FunctionCard(icon: Icons.add, title: "记账分类管理", onTap: (){}),
            FunctionCard(icon: Icons.add, title: "多币种", onTap: (){Get.toNamed("/multi_currency");}),
            FunctionCard(icon: Icons.add, title: "订阅和分期", onTap: (){}),
            FunctionCard(icon: Icons.add, title: "账单导入与导出", onTap: (){}),
          ],
        ),
      ),

    );
  }
}

class InformationCard extends StatelessWidget {
  const InformationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 103.h,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(239, 239, 239, 0.31),
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 20.w,
          ),
          ClipOval(
            child: Image.network(
              "https://mmsweibo.oss-cn-hangzhou.aliyuncs.com/head.jpg",
              width: 70.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          Text(
            "Daniel Hua",
            style: TextStyle(
                color: const Color.fromRGBO(64, 64, 64, 1),
                fontSize: 24.sp,
                fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          const Icon(
            Icons.chevron_right,
            color: Color.fromRGBO(187, 187, 187, 1),
          ),
        ],
      ),
    );
  }
}

class StatisticCard extends StatelessWidget {
  final String title;
  final int value;
  final IconData icon;
  const StatisticCard(
      {Key? key, required this.title, required this.value, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      width: 160.w,
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(239, 239, 239, 0.31),
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: const Color.fromRGBO(108, 108, 108, 1),
                size: 18.w,
              ),
              SizedBox(
                width: 3.w,
              ),
              Text(
                title,
                style: TextStyle(
                    color: const Color.fromRGBO(108, 108, 108, 1),
                    fontSize: 14.sp),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "$value",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              title == "总记账天数"
                  ? Text(
                "天",
                style: TextStyle(
                    color: const Color.fromRGBO(108, 108, 108, 1),
                    fontSize: 14.sp),
              )
                  : Text(
                "次",
                style: TextStyle(
                    color: const Color.fromRGBO(108, 108, 108, 1),
                    fontSize: 14.sp),
              )
            ],
          )
        ],
      ),
    );
  }
}

class FunctionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function() onTap;
  const FunctionCard({Key? key, required this.icon, required this.title, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48.h,
        margin: EdgeInsets.only(bottom: 8.h),
        padding:  EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(239, 239, 239, 0.31),
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Row(
          children: [
            Icon(icon,color: const Color.fromRGBO(108, 108, 108, 1),),
            SizedBox(width: 5.w,),
            Text(title, style: TextStyle(fontSize: 15.sp, color: const Color.fromRGBO(89, 89, 89, 1)),),
            const Spacer(),
            const Icon(Icons.chevron_right, color:Color.fromRGBO(108, 108, 108, 1),),
          ],
        ),
      ),
    );
  }
}
