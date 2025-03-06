// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_wallet_password_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckWalletPasswordRequest _$CheckWalletPasswordRequestFromJson(
        Map<String, dynamic> json) =>
    CheckWalletPasswordRequest(
      json['password'] as String?,
      CheckWalletPasswordRequest._fromJson(json['type'] as String),
    );

Map<String, dynamic> _$CheckWalletPasswordRequestToJson(
        CheckWalletPasswordRequest instance) =>
    <String, dynamic>{
      'password': instance.password,
      'type': CheckWalletPasswordRequest._toJson(instance.checkPasswordType),
    };
