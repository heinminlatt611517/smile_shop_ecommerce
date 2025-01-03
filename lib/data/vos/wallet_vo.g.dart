// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletVO _$WalletVOFromJson(Map<String, dynamic> json) => WalletVO(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      userType: json['user_type'] as String?,
      isActive: (json['is_active'] as num?)?.toInt(),
      amount: (json['amount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WalletVOToJson(WalletVO instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'user_type': instance.userType,
      'is_active': instance.isActive,
      'amount': instance.amount,
    };
