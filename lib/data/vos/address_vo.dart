import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/category_vo.dart';
import 'package:smile_shop/data/vos/state_vo.dart';
import 'package:smile_shop/data/vos/township_vo.dart';

part 'address_vo.g.dart';

@JsonSerializable()
class AddressVO {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "enduser_id")
  final int? enduserId;

  @JsonKey(name: "phone")
  final String? phone;

  @JsonKey(name: "address")
  final String? address;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "is_default")
  final int? isDefault;

  @JsonKey(name: "category_id")
  final int? categoryId;

  @JsonKey(name: "state_id")
  final int? stateId;

  @JsonKey(name: "type")
  final String? type;

  @JsonKey(name: "created_at")
  final String? createdAt;

  @JsonKey(name: "updated_at")
  final String? updatedAt;

  @JsonKey(name: "township_id")
  final int? townshipId;

  @JsonKey(name: "category")
  final CategoryVO? categoryVO;

  @JsonKey(name: "state")
  final StateVO? stateVO;

  @JsonKey(name: "township")
  final TownshipVO? townshipVO;

  @JsonKey(name: "note")
  final String? note;

  AddressVO(
      {this.id,
      this.enduserId,
      this.phone,
      this.name,
      this.address,
      this.isDefault,
      this.categoryId,
      this.stateId,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.townshipId,
      this.categoryVO,
      this.stateVO,
      this.townshipVO,
      this.note});

  factory AddressVO.fromJson(Map<String, dynamic> json) =>
      _$AddressVOFromJson(json);

  Map<String, dynamic> toJson() => _$AddressVOToJson(this);
}
