import 'package:json_annotation/json_annotation.dart';

part 'wallet_transition_request.g.dart';

@JsonSerializable()
class WalletTransitionRequest {
  @JsonKey(name: "page")
  int? page;

  @JsonKey(name: "log_type")
  String? logType;

  WalletTransitionRequest(this.page,this.logType);

  factory WalletTransitionRequest.fromJson(Map<String, dynamic> json) =>
      _$WalletTransitionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WalletTransitionRequestToJson(this);
}
