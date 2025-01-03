import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/payment_data_vo.dart';


part 'success_payment_response.g.dart';

@JsonSerializable()
class SuccessPaymentResponse {
  @JsonKey(name: "status_code")
  final int? statusCode;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final PaymentDataVO? data;

  SuccessPaymentResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  factory SuccessPaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$SuccessPaymentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SuccessPaymentResponseToJson(this);
}
