import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/refund_vo.dart';

part 'refund_response.g.dart';

@JsonSerializable()
class RefundResponse {
  @JsonKey(name: "status_code")
  final int? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final List<RefundVO>? data;

  RefundResponse(
      {this.status,
      this.message,
      this.data,
      });

  factory RefundResponse.fromJson(Map<String, dynamic> json) =>
      _$RefundResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RefundResponseToJson(this);
}
