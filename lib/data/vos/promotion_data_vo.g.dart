// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion_data_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromotionDataVO _$PromotionDataVOFromJson(Map<String, dynamic> json) =>
    PromotionDataVO(
      currentPoint: (json['current_point'] as num?)?.toInt(),
      promotions: (json['logs'] as List<dynamic>?)
          ?.map((e) => PromotionVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PromotionDataVOToJson(PromotionDataVO instance) =>
    <String, dynamic>{
      'current_point': instance.currentPoint,
      'logs': instance.promotions,
    };
