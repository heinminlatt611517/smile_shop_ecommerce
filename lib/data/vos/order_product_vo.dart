import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/data/vos/variant_vo.dart';

part 'order_product_vo.g.dart';

@JsonSerializable()
class OrderProductVO {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'enduser_id')
  final int? enduserId;

  @JsonKey(name: 'enduser_order_id')
  final String? enduserOrderId;

  @JsonKey(name: 'varient_product_id')
  final int? variantProductId;

  @JsonKey(name: 'variant_attribute_value_id')
  final int? variantAttributeValueId;

  @JsonKey(name: 'product_id')
  final int? productId;

  @JsonKey(name: 'color')
  final String? color;

  @JsonKey(name: 'size')
  final String? size;

  @JsonKey(name: 'qty')
  final int? qty;

  @JsonKey(name: 'price')
  final String? price;

  @JsonKey(name: 'subtotal')
  final String? subtotal;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @JsonKey(name: 'product')
  final ProductVO? product;

  @JsonKey(name: 'product_variant')
  final VariantVO? productVariant;

  OrderProductVO({
    this.id,
    this.enduserId,
    this.enduserOrderId,
    this.variantProductId,
    this.variantAttributeValueId,
    this.productId,
    this.color,
    this.size,
    this.qty,
    this.price,
    this.subtotal,
    this.createdAt,
    this.updatedAt,
    this.product,
    this.productVariant,
  });

  factory OrderProductVO.fromJson(Map<String, dynamic> json) => _$OrderProductVOFromJson(json);

  Map<String, dynamic> toJson() => _$OrderProductVOToJson(this);

  int getTotalPrice() {
    return ((double.tryParse(price ?? '0') ?? 0) * (qty ?? 1)).floor();
  }
}
