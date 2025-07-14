import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/payment_status_vo.dart';

part 'payment_status_response.g.dart';

@JsonSerializable()
class PaymentStatusResponse {
  @JsonKey(name: 'status_code')
  int? statusCode;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'data')
  PaymentStatusVO? data;

  PaymentStatusResponse();

  factory PaymentStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentStatusResponseToJson(this);
}
