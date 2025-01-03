import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/payment_vo.dart';

part 'payment_response.g.dart';

@JsonSerializable()
class PaymentResponse {
  @JsonKey(name: "status_code")
  final int? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final List<PaymentVO>? data;

  PaymentResponse(
      {this.status,
      this.message,
      this.data,
      });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentResponseToJson(this);
}
