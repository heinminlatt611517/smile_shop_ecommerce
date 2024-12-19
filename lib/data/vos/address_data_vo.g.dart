// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_data_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressDataVO _$AddressDataVOFromJson(Map<String, dynamic> json) =>
    AddressDataVO(
      addressVO: (json['address'] as List<dynamic>?)
          ?.map((e) => AddressVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AddressDataVOToJson(AddressDataVO instance) =>
    <String, dynamic>{
      'address': instance.addressVO,
    };
