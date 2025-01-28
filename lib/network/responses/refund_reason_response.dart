import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/banner_vo.dart';
import 'package:smile_shop/data/vos/refund_reason_vo.dart';

part 'refund_reason_response.g.dart';

@JsonSerializable()
class RefundReasonResponse {
  @JsonKey(name: "status")
  final int? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final List<RefundReasonVO>? data;

  RefundReasonResponse(
      {this.status,
      this.message,
      this.data,
      });

  factory RefundReasonResponse.fromJson(Map<String, dynamic> json) =>
      _$RefundReasonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RefundReasonResponseToJson(this);
}
