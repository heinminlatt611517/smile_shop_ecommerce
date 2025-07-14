import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/address_vo.dart';
import 'package:smile_shop/data/vos/delivery_history_vo.dart';

import 'order_product_vo.dart';

part 'order_vo.g.dart';

@JsonSerializable()
class OrderVO {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'head_id')
  final int? headId;

  @JsonKey(name: 'enduser_id')
  final int? enduserId;

  @JsonKey(name: 'order_no')
  final String? orderNo;

  @JsonKey(name: 'subtotal')
  final String? subtotal;

  @JsonKey(name: 'payment_type')
  final String? paymentType;

  @JsonKey(name: 'payment_status')
  final String? paymentStatus;

  @JsonKey(name: 'user_type')
  final String? userType;

  @JsonKey(name: 'enduser_address_id')
  final int? enduserAddressId;

  @JsonKey(name: 'delivery_status')
  final String? deliveryStatus;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @JsonKey(name: 'image')
  final String? image;

  @JsonKey(name: 'address')
  final AddressVO? addressVO;

  @JsonKey(name: 'order_products')
  final List<OrderProductVO>? orderProducts;

  @JsonKey(name: 'delivery_histories')
  final List<DeliveryHistoryVO>? deliveryHistory;

  @JsonKey(name: 'delivery_type')
  final String? deliveryType;

  @JsonKey(name: 'delivery_fees')
  final int? deliveryFee;

  @JsonKey(name: 'coupon_discount_amount')
  final String? couponDiscountAmount;

  @JsonKey(name: 'used_points')
  final int? usedPoints;

  String getStatus() {
    if (paymentStatus == "cancel" || paymentStatus == "paid") {
      return paymentStatus!;
    } else {
      return deliveryStatus ?? '';
    }
  }

  bool isCOD() =>
      (paymentType?.toString() == "cod" || paymentType?.toString() == "cod");

  double getTotalFees() {
    double totalProdutPrice = orderProducts?.fold(
            0.0,
            (sum, item) =>
                (sum ?? 0) + (double.tryParse(item.subtotal ?? "0") ?? 0)) ??
        0.0;

    return totalProdutPrice +
        (double.tryParse(deliveryFee?.toString() ?? '0') ?? 0) -
        (double.tryParse(couponDiscountAmount?.toString() ?? '0') ?? 0);
  }

  OrderVO({
    this.id,
    this.headId,
    this.enduserId,
    this.orderNo,
    this.subtotal,
    this.paymentType,
    this.paymentStatus,
    this.userType,
    this.enduserAddressId,
    this.deliveryStatus,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.addressVO,
    this.orderProducts,
    this.deliveryHistory,
    this.deliveryType,
    this.deliveryFee,
    this.couponDiscountAmount,
    this.usedPoints,
  });

  factory OrderVO.fromJson(Map<String, dynamic> json) =>
      _$OrderVOFromJson(json);

  Map<String, dynamic> toJson() => _$OrderVOToJson(this);
}
