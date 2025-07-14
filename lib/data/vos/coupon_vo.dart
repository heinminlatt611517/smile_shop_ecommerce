// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'coupon_vo.g.dart';

@JsonSerializable()
class CouponVO {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'discount_type')
  String? discountType;

  @JsonKey(name: 'discount_value')
  String? discountValue;

  @JsonKey(name: 'min_expense')
  String? minExpense;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'pivot')
  CouponPivotVo? couponPivotVo;

  CouponVO({
    this.id,
    this.discountType,
    this.discountValue,
    this.minExpense,
    this.name,
    this.description,
    this.couponPivotVo,
  });

  bool isValid(int totalPrice) {
    try {
      DateTime? expiredAt = DateTime.tryParse(couponPivotVo?.expiredAt ?? '');
      if (expiredAt != null && expiredAt.isBefore(DateTime.now())) {
        return false; // Coupon is expired
      }
      if (couponPivotVo?.isUsed == 1) {
        return false; // Coupon is already used
      }
      return (totalPrice >= (double.tryParse(minExpense ?? "0") ?? 0));
    } catch (e) {
      return false;
    }
  }

  double getDiscountValue() {
    if (discountType == 'percentage') {
      return double.parse(discountValue ?? '0') / 100;
    } else if (discountType == 'fixed') {
      return double.parse(discountValue ?? '0');
    }
    return 0.0;
  }

  factory CouponVO.fromJson(Map<String, dynamic> json) =>
      _$CouponVOFromJson(json);

  Map<String, dynamic> toJson() => _$CouponVOToJson(this);
}

@JsonSerializable()
class CouponPivotVo {
  @JsonKey(name: 'enduser_id')
  int? enduserId;
  @JsonKey(name: 'coupon_id')
  int? couponId;
  @JsonKey(name: 'is_used')
  int? isUsed;
  @JsonKey(name: 'expired_at')
  String? expiredAt;

  CouponPivotVo({
    this.enduserId,
    this.couponId,
    this.isUsed,
    this.expiredAt,
  });

  factory CouponPivotVo.fromJson(Map<String, dynamic> json) =>
      _$CouponPivotVoFromJson(json);

  Map<String, dynamic> toJson() => _$CouponPivotVoToJson(this);
}
