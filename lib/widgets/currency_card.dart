import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurrencyCard extends StatelessWidget {
  final String name;
  final String abbr;
  final String symbol;
  final double rate;
  const CurrencyCard({Key? key, required this.name, required this.abbr, required this.symbol, required this.rate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding:  EdgeInsets.only(left: 15.w, right: 15.w, top: 12.h, bottom: 12.h),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(239, 239, 239, 0.31),
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(abbr, style:  TextStyle(color: const Color.fromRGBO(97, 121, 145, 0.8), fontWeight: FontWeight.bold,fontSize: 16.sp),),
              Text(name, style: TextStyle(fontSize: 14.sp, color: const Color.fromRGBO(89, 89, 89, 1)),),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(symbol, style:  const TextStyle(color: Color.fromRGBO(97, 121, 145, 0.8), fontWeight: FontWeight.bold,)),
              Text("1CNY=$rate", style: TextStyle(fontSize: 14.sp, color: const Color.fromRGBO(89, 89, 89, 1)),),
            ],
          )
        ],
      ),
    );
  }
}
