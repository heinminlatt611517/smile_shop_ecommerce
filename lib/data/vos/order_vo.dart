import 'package:json_annotation/json_annotation.dart';

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

  @JsonKey(name: 'order_products')
  final List<OrderProductVO>? orderProducts;

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
    this.orderProducts,
  });

  factory OrderVO.fromJson(Map<String, dynamic> json) => _$OrderVOFromJson(json);

  Map<String, dynamic> toJson() => _$OrderVOToJson(this);
}