import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monotes/common/config.dart';

class ConclusionCard extends StatefulWidget {
  double _income = 0;
  double _expenditure = 0;
  double _balance = 0;

  ConclusionCard(this._income, this._expenditure, this._balance, {Key? key})
      : super(key: key);

  @override
  State<ConclusionCard> createState() => _ConclusionCardState();
}

class _ConclusionCardState extends State<ConclusionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ThemeColor.conclusionBgColor),
      child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "本月收入",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF6B7979)),
                      ),
                      Text(
                        widget._income.toStringAsFixed(2),
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6B7979)),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("本月结余",
                            style: TextStyle(
                                fontSize: 16, color: Color(0xFF6B7979))),
                        Text(
                          widget._balance.toStringAsFixed(2),
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6B7979)),
                        )
                      ])
                ],
              ),
              const SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "本月支出",
                    style: TextStyle(fontSize: 16, color: Color(0xFF6B7979)),
                  ),
                  Text(
                    widget._expenditure.toStringAsFixed(2),
                    style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5FA392)),
                  )
                ],
              )
            ],
          )),
    );
  }
}
