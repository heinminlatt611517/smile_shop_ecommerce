// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressRequest _$AddressRequestFromJson(Map<String, dynamic> json) =>
    AddressRequest(
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      stateId: (json['state_id'] as num?)?.toInt(),
      regionId: (json['region_id'] as num?)?.toInt(),
      isDefault: (json['is_default'] as num?)?.toInt(),
      categoryId: (json['category_id'] as num?)?.toInt(),
      townshipId: (json['township_id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$AddressRequestToJson(AddressRequest instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'address': instance.address,
      'state_id': instance.stateId,
      'region_id': instance.regionId,
      'is_default': instance.isDefault,
      'category_id': instance.categoryId,
      'township_id': instance.townshipId,
      'name': instance.name,
    };
