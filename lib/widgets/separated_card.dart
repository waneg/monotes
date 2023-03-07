import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SeparatedCard extends StatelessWidget {
  final String title;
  final Widget widget;

  const SeparatedCard({Key? key, required this.title, required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.w),
      padding: EdgeInsets.all(12.w),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8.w)),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(title, style: TextStyle(fontSize: 14.sp),), const Divider(), widget]),
    );
  }
}
