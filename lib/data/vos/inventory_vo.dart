import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../persistence/hive_constants.dart';
part 'inventory_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: kHiveInventoryVO, adapterName: kAdapterInventoryVO)
class InventoryVO {
  @JsonKey(name: 'id')
  @HiveField(0)
  final int? id;

  @JsonKey(name: 'product_variant_id')
  @HiveField(1)
  final int? productVariantId;

  @JsonKey(name: 'warehouse_id')
  @HiveField(2)
  final int? warehouseId;

  @JsonKey(name: 'quantity')
  @HiveField(3)
  final String? quantity;

  @JsonKey(name: 'created_at')
  @HiveField(4)
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  @HiveField(5)
  final String? updatedAt;

  @JsonKey(name: 'deleted_at')
  @HiveField(6)
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