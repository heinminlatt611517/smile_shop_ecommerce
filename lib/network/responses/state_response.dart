import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/state_vo.dart';

part 'state_response.g.dart';

@JsonSerializable()
class StateResponse {
  @JsonKey(name: "status")
  final int? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final List<StateVO>? data;

  StateResponse(
      {this.status,
      this.message,
      this.data,
      });

  factory StateResponse.fromJson(Map<String, dynamic> json) =>
      _$StateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StateResponseToJson(this);
}
