import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/address_vo.dart';
import 'package:smile_shop/data/vos/wallet_transaction_vo.dart';

part 'wallet_transaction_data_vo.g.dart';

@JsonSerializable()
class WalletTransactionDataVO {
  @JsonKey(name: "data")
  final List<WalletTransactionVO>? walletTransactions;

  WalletTransactionDataVO({
    this.walletTransactions,
  });

  factory WalletTransactionDataVO.fromJson(Map<String, dynamic> json) =>
      _$WalletTransactionDataVOFromJson(json);

  Map<String, dynamic> toJson() => _$WalletTransactionDataVOToJson(this);
}
