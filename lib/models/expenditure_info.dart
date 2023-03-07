import 'package:json_annotation/json_annotation.dart';

part 'expenditure_info.g.dart';

@JsonSerializable()
class ExpenditureInfo {
  final int typeId;
  final double amount;
  final double pct;

  ExpenditureInfo(this.typeId, this.amount, this.pct);

  factory ExpenditureInfo.fromJson(Map<String, dynamic> json) => _$ExpenditureInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenditureInfoToJson(this);
}
