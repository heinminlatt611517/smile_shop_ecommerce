import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/sub_payment_vo.dart';
part 'payment_vo.g.dart';

@JsonSerializable()
class PaymentVO {
  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "image")
  final String? image;

  @JsonKey(name: "show")
  final bool? show;

  @JsonKey(name: "code")
  final String? code;

  @JsonKey(name: "method")
  final String? method;

  @JsonKey(name: "list")
  final List<SubPaymentVO>? subPaymentVO;


  PaymentVO({
    this.name,
    this.image,
    this.show,
    this.code,
    this.method,
    this.subPaymentVO
  });

  factory PaymentVO.fromJson(Map<String, dynamic> json) =>
      _$PaymentVOFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentVOToJson(this);
}
