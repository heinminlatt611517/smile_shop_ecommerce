// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressVO _$AddressVOFromJson(Map<String, dynamic> json) => AddressVO(
      id: (json['id'] as num?)?.toInt(),
      enduserId: (json['enduser_id'] as num?)?.toInt(),
      phone: json['phone'] as String?,
      name: json['name'] as String?,
      address: json['address'] as String?,
      isDefault: (json['is_default'] as num?)?.toInt(),
      categoryId: (json['category_id'] as num?)?.toInt(),
      stateId: (json['state_id'] as num?)?.toInt(),
      type: json['type'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      townshipId: (json['township_id'] as num?)?.toInt(),
      categoryVO: json['category'] == null
          ? null
          : CategoryVO.fromJson(json['category'] as Map<String, dynamic>),
      stateVO: json['state'] == null
          ? null
          : StateVO.fromJson(json['state'] as Map<String, dynamic>),
      townshipVO: json['township'] == null
          ? null
          : TownshipVO.fromJson(json['township'] as Map<String, dynamic>),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$AddressVOToJson(AddressVO instance) => <String, dynamic>{
      'id': instance.id,
      'enduser_id': instance.enduserId,
      'phone': instance.phone,
      'address': instance.address,
      'name': instance.name,
      'is_default': instance.isDefault,
      'category_id': instance.categoryId,
      'state_id': instance.stateId,
      'type': instance.type,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'township_id': instance.townshipId,
      'category': instance.categoryVO,
      'state': instance.stateVO,
      'township': instance.townshipVO,
      'note': instance.note,
    };
