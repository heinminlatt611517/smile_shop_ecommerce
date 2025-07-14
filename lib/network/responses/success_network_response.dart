import 'package:json_annotation/json_annotation.dart';

part 'success_network_response.g.dart';

@JsonSerializable()
class SuccessNetworkResponse {
  @JsonKey(name: "status_code")
  final int? status;

  @JsonKey(name: "message")
  final String? message;

  SuccessNetworkResponse(
      {this.status,
      this.message,
      });

  factory SuccessNetworkResponse.fromJson(Map<String, dynamic> json) =>
      _$SuccessNetworkResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SuccessNetworkResponseToJson(this);
}
