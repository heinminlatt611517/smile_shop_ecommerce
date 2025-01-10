import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/address_data_vo.dart';
import 'package:smile_shop/data/vos/package_vo.dart';

part 'package_details_response.g.dart';

@JsonSerializable()
class PackageDetailsResponse {
  @JsonKey(name: "status_code")
  final int? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final PackageVO? data;

  PackageDetailsResponse(
      {this.status,
      this.message,
      this.data,
      });

  factory PackageDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$PackageDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PackageDetailsResponseToJson(this);
}
