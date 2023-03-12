// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bills_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillsDetail _$BillsDetailFromJson(Map<String, dynamic> json) => BillsDetail(
      json['billId'] as int,
      json['typeId'] as int,
      (json['price'] as num).toDouble(),
      json['goods'] as String,
      json['time'] as String,
    );

Map<String, dynamic> _$BillsDetailToJson(BillsDetail instance) =>
    <String, dynamic>{
      'billId': instance.billId,
      'typeId': instance.typeId,
      'price': instance.price,
      'goods': instance.goods,
      'time': instance.time,
    };
