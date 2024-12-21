import 'package:json_annotation/json_annotation.dart';
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

  PaymentVO({
    this.name,
    this.image,
    this.show,
    this.code
  });

  factory PaymentVO.fromJson(Map<String, dynamic> json) =>
      _$PaymentVOFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentVOToJson(this);
}
