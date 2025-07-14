// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignHistoryResponse _$CampaignHistoryResponseFromJson(
        Map<String, dynamic> json) =>
    CampaignHistoryResponse(
      statusCode: (json['status_code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CampaignHistoryVo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CampaignHistoryResponseToJson(
        CampaignHistoryResponse instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

AddressVO _$AddressVOFromJson(Map<String, dynamic> json) => AddressVO(
      id: (json['id'] as num?)?.toInt(),
      enduserId: (json['enduser_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      categoryId: (json['category_id'] as num?)?.toInt(),
      townshipId: (json['township_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AddressVOToJson(AddressVO instance) => <String, dynamic>{
      'id': instance.id,
      'enduser_id': instance.enduserId,
      'name': instance.name,
      'phone': instance.phone,
      'address': instance.address,
      'category_id': instance.categoryId,
      'township_id': instance.townshipId,
    };
