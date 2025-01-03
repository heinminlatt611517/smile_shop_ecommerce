// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_transaction_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletTransactionVO _$WalletTransactionVOFromJson(Map<String, dynamic> json) =>
    WalletTransactionVO(
      id: (json['id'] as num?)?.toInt(),
      walletId: (json['wallet_id'] as num?)?.toInt(),
      amount: (json['amount'] as num?)?.toDouble(),
      points: (json['points'] as num?)?.toDouble(),
      type: json['type'] as String?,
      paymentType: json['payment_type'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$WalletTransactionVOToJson(
        WalletTransactionVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'wallet_id': instance.walletId,
      'amount': instance.amount,
      'points': instance.points,
      'type': instance.type,
      'payment_type': instance.paymentType,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
