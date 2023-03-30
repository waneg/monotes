import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:monotes/common/config.dart';

class ExpenditureItem extends StatelessWidget {
  final int typeId;
  final double amount;
  final double pct;

  const ExpenditureItem(
      {Key? key, required this.typeId, required this.amount, required this.pct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.w, bottom: 5.w),
      child: Row(
        children: [
          SizedBox(
            width: 22.w,
            height: 22.w,
            child: SvgPicture.asset(
              "assets/bill_icons/$typeId.svg",
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
              child: Column(
            children: [
              Row(
                children: [
                  Text(
                    SHOPPING_TYPE[typeId]!,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  SizedBox(
                    width: 20.sp,
                  ),
                  Text(
                    "${pct.toStringAsFixed(2)}%",
                    style: TextStyle(color: const Color(0xffBEBEBE), fontSize: 14.sp),
                  ),
                  const Spacer(),
                  Text(
                    "￥${amount.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 14.sp),
                  )
                ],
              ),
              SizedBox(
                height: 6.sp,
              ),
              BrnProgressChart(
                width: double.infinity,
                height: 15.sp,
                value: pct / 100,
                brnProgressIndicatorBuilder:
                    (BuildContext context, double value) {
                  return Text(
                    "${(value * 100).toStringAsFixed(2)}%",
                    style: TextStyle(color: Colors.white, fontSize: 13.sp),
                  );
                },
              )
            ],
          ))
        ],
      ),
    );
  }
}
