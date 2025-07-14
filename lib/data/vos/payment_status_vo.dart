import 'package:json_annotation/json_annotation.dart';

part 'payment_status_vo.g.dart';

@JsonSerializable()
class PaymentStatusVO {
  @JsonKey(name: 'payment_status')
  String? paymentStatus;

  @JsonKey(name: 'transaction_id')
  String? transactionId;

  PaymentStatusVO();

  factory PaymentStatusVO.fromJson(Map<String, dynamic> json) =>
      _$PaymentStatusVOFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentStatusVOToJson(this);
}
