// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromotionVO _$PromotionVOFromJson(Map<String, dynamic> json) => PromotionVO(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      amount: (json['amount'] as num?)?.toDouble(),
      type: json['type'] as String?,
    );

Map<String, dynamic> _$PromotionVOToJson(PromotionVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'amount': instance.amount,
      'type': instance.type,
    };
