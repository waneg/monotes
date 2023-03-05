import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:monotes/common/config.dart';
import 'package:monotes/models/bills_detail.dart';

class DetailCard extends StatelessWidget {
  final BillsDetail billsDetail;

  const DetailCard(this.billsDetail, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.w), color: Colors.white),
      child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Stack(
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/bill_icons/${billsDetail.typeId}.svg",
                    width: 20.w,
                  ),
                  SizedBox(width: 20.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(billsDetail.merchant,
                          style: TextStyle(fontSize: 14.sp, height: 2)),
                      Text(
                        SHOPPING_TYPE[billsDetail.typeId]!,
                        style: TextStyle(
                            fontSize: 13.sp,
                            color: const Color(0xFF9A9A9A),
                            height: 1.5),
                      ),
                      Text(
                        billsDetail.time.toString(),
                        style: TextStyle(
                            fontSize: 13.sp,
                            color: const Color(0xFF9A9A9A),
                            height: 1.5),
                      )
                    ],
                  )
                ],
              ),
              Positioned(right: 0, top: 0, child: Text("-${billsDetail.amount}", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, height: 1.5),))
            ],
          )),
    );
  }
}
