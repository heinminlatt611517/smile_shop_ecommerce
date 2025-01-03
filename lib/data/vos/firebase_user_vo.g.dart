// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_user_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirebaseUserVo _$FirebaseUserVoFromJson(Map<String, dynamic> json) =>
    FirebaseUserVo(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$FirebaseUserVoToJson(FirebaseUserVo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'role': instance.role,
    };
