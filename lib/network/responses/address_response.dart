import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/address_data_vo.dart';

part 'address_response.g.dart';

@JsonSerializable()
class AddressResponse {
  @JsonKey(name: "status_code")
  final int? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final AddressDataVO? data;

  AddressResponse(
      {this.status,
      this.message,
      this.data,
      });

  factory AddressResponse.fromJson(Map<String, dynamic> json) =>
      _$AddressResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddressResponseToJson(this);
}
