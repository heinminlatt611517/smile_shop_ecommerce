// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_transaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletTransactionResponse _$WalletTransactionResponseFromJson(
        Map<String, dynamic> json) =>
    WalletTransactionResponse(
      status: (json['status_code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : WalletTransactionDataVO.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WalletTransactionResponseToJson(
        WalletTransactionResponse instance) =>
    <String, dynamic>{
      'status_code': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
