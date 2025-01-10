// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_team_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyTeamVO _$MyTeamVOFromJson(Map<String, dynamic> json) => MyTeamVO(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      userPhoto: json['user_photo'] as String?,
      profileImage: json['profile_image'] as String?,
    );

Map<String, dynamic> _$MyTeamVOToJson(MyTeamVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'user_photo': instance.userPhoto,
      'profile_image': instance.profileImage,
    };
