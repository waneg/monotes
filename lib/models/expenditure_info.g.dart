// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expenditure_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenditureInfo _$ExpenditureInfoFromJson(Map<String, dynamic> json) =>
    ExpenditureInfo(
      json['typeId'] as int,
      (json['amount'] as num).toDouble(),
      (json['pct'] as num).toDouble(),
    );

Map<String, dynamic> _$ExpenditureInfoToJson(ExpenditureInfo instance) =>
    <String, dynamic>{
      'typeId': instance.typeId,
      'amount': instance.amount,
      'pct': instance.pct,
    };
