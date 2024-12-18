// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_data_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoginResponseAdapter extends TypeAdapter<LoginDataVO> {
  @override
  final int typeId = 0;

  @override
  LoginDataVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoginDataVO(
      status: fields[0] as int?,
      message: fields[1] as String?,
      data: fields[5] as UserVO?,
      accessToken: fields[2] as String?,
      expire: fields[3] as dynamic,
      refreshToken: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LoginDataVO obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.accessToken)
      ..writeByte(3)
      ..write(obj.expire)
      ..writeByte(4)
      ..write(obj.refreshToken)
      ..writeByte(5)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginDataVO _$LoginDataVOFromJson(Map<String, dynamic> json) => LoginDataVO(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['user'] == null
          ? null
          : UserVO.fromJson(json['user'] as Map<String, dynamic>),
      accessToken: json['access_token'] as String?,
      expire: json['expires_in'],
      refreshToken: json['refresh_token'] as String?,
    );

Map<String, dynamic> _$LoginDataVOToJson(LoginDataVO instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'access_token': instance.accessToken,
      'expires_in': instance.expire,
      'refresh_token': instance.refreshToken,
      'user': instance.data,
    };
