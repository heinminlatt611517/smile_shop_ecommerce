// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_popup_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomePopupDataResponse _$HomePopupDataResponseFromJson(
        Map<String, dynamic> json) =>
    HomePopupDataResponse(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : PopupDataVO.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HomePopupDataResponseToJson(
        HomePopupDataResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
