import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/coupon_vo.dart';

part 'coupon_response.g.dart';

@JsonSerializable()
class CouponResponse {
  @JsonKey(name: "status_code")
  final int? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final List<CouponVO>? data;

  CouponResponse({
    this.status,
    this.message,
    this.data,
  });

  factory CouponResponse.fromJson(Map<String, dynamic> json) =>
      _$CouponResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CouponResponseToJson(this);
}
