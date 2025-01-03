import 'package:json_annotation/json_annotation.dart';
part 'wallet_vo.g.dart';

@JsonSerializable()
class WalletVO {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "user_id")
  final int? userId;

  @JsonKey(name: "user_type")
  final String? userType;

  @JsonKey(name: "is_active")
  final int? isActive;

  @JsonKey(name: "amount")
  final double? amount;

  WalletVO({
    this.id,
    this.userId,
    this.userType,
    this.isActive,
    this.amount,
  });

  factory WalletVO.fromJson(Map<String, dynamic> json) =>
      _$WalletVOFromJson(json);

  Map<String, dynamic> toJson() => _$WalletVOToJson(this);
}
