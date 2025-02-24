import 'package:json_annotation/json_annotation.dart';

part 'sub_payment_vo.g.dart';

@JsonSerializable()
class SubPaymentVO {
  @JsonKey(name: "code")
  final String? code;

  @JsonKey(name: "image")
  final String? image;

  @JsonKey(name: "method")
  final String? method;

  String getCodeFormatted() {
    if (code == "KBZ Direct Pay") {
      return "KBZ Mobile Banking";
    } else {
      return code ?? '';
    }
  }

  SubPaymentVO({this.code, this.image, this.method});

  factory SubPaymentVO.fromJson(Map<String, dynamic> json) => _$SubPaymentVOFromJson(json);

  Map<String, dynamic> toJson() => _$SubPaymentVOToJson(this);
}
