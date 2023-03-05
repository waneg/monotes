// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecordDetail _$RecordDetailFromJson(Map<String, dynamic> json) => RecordDetail(
      json['typeId'] as int,
      json['time'] as String,
      json['price'] as String,
      json['shopkeeper'] as String,
    );

Map<String, dynamic> _$RecordDetailToJson(RecordDetail instance) =>
    <String, dynamic>{
      'typeId': instance.typeId,
      'time': instance.time,
      'price': instance.price,
      'shopkeeper': instance.shopkeeper,
    };
