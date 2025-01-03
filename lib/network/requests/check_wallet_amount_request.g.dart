// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_wallet_amount_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckWalletAmountRequest _$CheckWalletAmountRequestFromJson(
        Map<String, dynamic> json) =>
    CheckWalletAmountRequest(
      (json['amount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CheckWalletAmountRequestToJson(
        CheckWalletAmountRequest instance) =>
    <String, dynamic>{
      'amount': instance.amount,
    };
