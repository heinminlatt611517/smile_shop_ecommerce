import 'package:json_annotation/json_annotation.dart';

part 'wallet_transaction_vo.g.dart';

@JsonSerializable()
class WalletTransactionVO {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "wallet_id")
  final int? walletId;

  @JsonKey(name: "amount")
  final double? amount;

  @JsonKey(name: "points")
  final double? points;

  @JsonKey(name: "type")
  final String? type;

  @JsonKey(name: "payment_type")
  final String? paymentType;

  @JsonKey(name: "created_at")
  final String? createdAt;

  @JsonKey(name: "updated_at")
  final String? updatedAt;

  WalletTransactionVO({
     this.id,
     this.walletId,
     this.amount,
     this.points,
     this.type,
     this.paymentType,
     this.createdAt,
     this.updatedAt,
  });


  factory WalletTransactionVO.fromJson(Map<String, dynamic> json) =>
      _$WalletTransactionVOFromJson(json);

  Map<String, dynamic> toJson() => _$WalletTransactionVOToJson(this);
}
