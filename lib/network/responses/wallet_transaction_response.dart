import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/wallet_transaction_data_vo.dart';

part 'wallet_transaction_response.g.dart';

@JsonSerializable()
class WalletTransactionResponse {
  @JsonKey(name: "status_code")
  final int? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final WalletTransactionDataVO? data;

  WalletTransactionResponse(
      {this.status,
      this.message,
      this.data,
      });

  factory WalletTransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$WalletTransactionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WalletTransactionResponseToJson(this);
}
