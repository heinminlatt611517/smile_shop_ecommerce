// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_wallet_password_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetWalletPasswordRequest _$SetWalletPasswordRequestFromJson(
        Map<String, dynamic> json) =>
    SetWalletPasswordRequest(
      json['password'] as String?,
      json['password_confirmation'] as String?,
    );

Map<String, dynamic> _$SetWalletPasswordRequestToJson(
        SetWalletPasswordRequest instance) =>
    <String, dynamic>{
      'password': instance.password,
      'password_confirmation': instance.passwordConfirmation,
    };
