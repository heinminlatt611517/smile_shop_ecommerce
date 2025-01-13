import 'package:json_annotation/json_annotation.dart';

part 'payment_data_vo.g.dart';

@JsonSerializable()
class PaymentDataVO {
  @JsonKey(name: "response")
  final dynamic response;

  @JsonKey(name: "response_type")
  final String? responseType;

  @JsonKey(name: "request_status")
  final dynamic requestStatus;

  @JsonKey(name: "title")
  final String? title;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "payment_type")
  final String? paymentType;

  @JsonKey(name: "order_id")
  final String? orderId;

  @JsonKey(name: "order_no")
  final String? orderNo;

  PaymentDataVO({
    this.response,
    this.responseType,
    this.requestStatus,
    this.title,
    this.message,
    this.paymentType,
    this.orderId,
    this.orderNo
  });

  factory PaymentDataVO.fromJson(Map<String, dynamic> json) =>
      _$PaymentDataVOFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentDataVOToJson(this);
}
