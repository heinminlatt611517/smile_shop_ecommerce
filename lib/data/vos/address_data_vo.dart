import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/address_vo.dart';

part 'address_data_vo.g.dart';

@JsonSerializable()
class AddressDataVO {
  @JsonKey(name: "address")
  final List<AddressVO>? addressVO;

  AddressDataVO({
    this.addressVO,
  });

  factory AddressDataVO.fromJson(Map<String, dynamic> json) =>
      _$AddressDataVOFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDataVOToJson(this);
}
