// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentVO _$PaymentVOFromJson(Map<String, dynamic> json) => PaymentVO(
      name: json['name'] as String?,
      image: json['image'] as String?,
      show: json['show'] as bool?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$PaymentVOToJson(PaymentVO instance) => <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'show': instance.show,
      'code': instance.code,
    };
