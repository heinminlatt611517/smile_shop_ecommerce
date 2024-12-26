import 'package:json_annotation/json_annotation.dart';

part 'order_variant_vo.g.dart';

@JsonSerializable()
class OrderVariantVO {
  @JsonKey(name: 'variant_product_id')
  final int? variantProductId;

  @JsonKey(name: 'product_id')
  final int? productId;

  @JsonKey(name: 'variant_attribute_value_id')
  final int? variantAttributeValueId;

  @JsonKey(name: 'qty')
  final int? qty;

  @JsonKey(name: 'color_name')
  final String? colorName;

  OrderVariantVO({
     this.variantProductId,
     this.productId,
     this.variantAttributeValueId,
     this.qty,
     this.colorName,
  });

  factory OrderVariantVO.fromJson(Map<String, dynamic> json) =>
      _$OrderVariantVOFromJson(json);

  Map<String, dynamic> toJson() => _$OrderVariantVOToJson(this);

}
