// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_transition_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletTransitionRequest _$WalletTransitionRequestFromJson(
        Map<String, dynamic> json) =>
    WalletTransitionRequest(
      (json['page'] as num?)?.toInt(),
      json['log_type'] as String?,
    );

Map<String, dynamic> _$WalletTransitionRequestToJson(
        WalletTransitionRequest instance) =>
    <String, dynamic>{
      'page': instance.page,
      'log_type': instance.logType,
    };
