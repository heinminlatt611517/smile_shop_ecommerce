import 'package:json_annotation/json_annotation.dart';

part 'address_request.g.dart';

@JsonSerializable()
class AddressRequest {
  @JsonKey(name: "phone")
  final String? phone;

  @JsonKey(name: "address")
  final String? address;

  @JsonKey(name: "state_id")
  final int? stateId;

  @JsonKey(name: "region_id")
  final int? regionId;

  @JsonKey(name: "is_default")
  final int? isDefault;

  @JsonKey(name: "category_id")
  final int? categoryId;

  @JsonKey(name: "township_id")
  final int? townshipId;

  @JsonKey(name: "name")
  final String? name;

  AddressRequest({
    this.phone,
    this.address,
    this.stateId,
    this.regionId,
    this.isDefault,
    this.categoryId,
    this.townshipId,
    this.name
  });

  factory AddressRequest.fromJson(Map<String, dynamic> json) =>
      _$AddressRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddressRequestToJson(this);
}
