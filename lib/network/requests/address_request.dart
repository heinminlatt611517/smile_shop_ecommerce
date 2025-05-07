// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  @JsonKey(name: "note")
  final String? note;

  AddressRequest(
      {this.phone,
      this.address,
      this.stateId,
      this.regionId,
      this.isDefault,
      this.categoryId,
      this.townshipId,
      this.name,
      this.note});

  factory AddressRequest.fromJson(Map<String, dynamic> json) =>
      _$AddressRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddressRequestToJson(this);

  @override
  String toString() {
    return 'AddressRequest(phone: $phone, address: $address, stateId: $stateId, regionId: $regionId, isDefault: $isDefault, categoryId: $categoryId, townshipId: $townshipId, name: $name)';
  }
}
