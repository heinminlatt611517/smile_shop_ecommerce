// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageVO _$PackageVOFromJson(Map<String, dynamic> json) => PackageVO(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      packagePrice: (json['package_price'] as num?)?.toInt(),
      benefits: json['benefits'] as String?,
      currentPurchase: (json['current_purchase'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PackageVOToJson(PackageVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'package_price': instance.packagePrice,
      'benefits': instance.benefits,
      'current_purchase': instance.currentPurchase,
    };
