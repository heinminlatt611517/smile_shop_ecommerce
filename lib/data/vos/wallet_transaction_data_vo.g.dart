// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_transaction_data_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletTransactionDataVO _$WalletTransactionDataVOFromJson(
        Map<String, dynamic> json) =>
    WalletTransactionDataVO(
      walletTransactions: (json['data'] as List<dynamic>?)
          ?.map((e) => WalletTransactionVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WalletTransactionDataVOToJson(
        WalletTransactionDataVO instance) =>
    <String, dynamic>{
      'data': instance.walletTransactions,
    };
