import 'package:flutter/material.dart';
import 'package:monotes/widgets/separated_card.dart';
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
          SizedBox(height: 30.h,),
          SeparatedCard(title: "消费建议", widget: Text("首先，建议你做好每个月的消费预算，将收入和支出进行明细的分析和统计。在购买商品或服务时，可以比较不同品牌和商家的价格和质量，选择最适合自己的商品或服务。同时也可以寻找优惠券、折扣和赠品等，尽可能节省开支。此外，还要注意日常生活中的小开支，比如减少外出用餐的频率、尽可能自己做饭，避免过多的娱乐和消费。总之，理性消费是一种生活态度和消费习惯的养成，只有坚持下来，才能真正实现合理消费。",
          style: TextStyle(fontSize: 14.sp),),
          ),
          SizedBox(
            height: 30.h,
          ),
          Text(
            "常用标签",
            style: TextStyle(
                fontSize: 20.sp, color: const Color.fromRGBO(31, 41, 51, 1.0)),
          ),
          SizedBox(
            height: 20.h,
          ),
          Wrap(
              alignment: WrapAlignment.center,
              spacing: 10, //主轴间距
              runSpacing: 10, //次轴间距
              children: List.generate(controller.labelItem.length, (index) {
                return LabelCard(str: controller.labelItem[index]);
              })),
          SizedBox(
            height: 30.h,
          ),
          Text(
            "近3日账单",
            style: TextStyle(
                fontSize: 20.sp, color: const Color.fromRGBO(31, 41, 51, 1.0)),
          ),
          SizedBox(
            height: 20.h,
          ),
          Obx(() {
            if (controller.billItems.isNotEmpty) {
              return ListView.separated(
                shrinkWrap: true,
                controller: controller.scrollController,
                itemCount: controller.billItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return DetailCard(controller.billItems[index]);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 10.h,
                  );
                },
              );
            } else {
              return const Center(
                child: Text(
                  "暂时没有账单",
                  style: TextStyle(color: Colors.black54),
                ),
              );
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
