import 'package:json_annotation/json_annotation.dart';

part 'bills_detail.g.dart';

@JsonSerializable()
class BillsDetail {
  final int billId; // 账单id
  final int typeId; // 消费类型id
  final String merchant = ""; // 商家
  double price; // 消费金额
  final String goods;
  final String time; // 消费时间
  final List<String> labels = []; // 消费标签

  BillsDetail(this.billId, this.typeId,  this.price, this.goods, this.time);

  factory BillsDetail.fromJson(Map<String, dynamic> json) => _$BillsDetailFromJson(json);

  Map<String, dynamic> toJson() => _$BillsDetailToJson(this);
}
