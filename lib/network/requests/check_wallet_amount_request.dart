import 'package:json_annotation/json_annotation.dart';

part 'check_wallet_amount_request.g.dart';

@JsonSerializable()
class CheckWalletAmountRequest {
  @JsonKey(name: "amount")
  int? amount;

  CheckWalletAmountRequest(this.amount);

  factory CheckWalletAmountRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckWalletAmountRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckWalletAmountRequestToJson(this);
}
