import 'package:json_annotation/json_annotation.dart';
part 'inventory_vo.g.dart';

@JsonSerializable()
class InventoryVO {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'product_variant_id')
  final int? productVariantId;

  @JsonKey(name: 'warehouse_id')
  final int? warehouseId;

  @JsonKey(name: 'quantity')
  final String? quantity;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @JsonKey(name: 'deleted_at')
  final String? deletedAt;

  InventoryVO({
    this.id,
    this.productVariantId,
    this.warehouseId,
    this.quantity,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory InventoryVO.fromJson(Map<String, dynamic> json) =>
      _$InventoryVOFromJson(json);

  Map<String, dynamic> toJson() => _$InventoryVOToJson(this);
}