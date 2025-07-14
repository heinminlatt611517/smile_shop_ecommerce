import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/package_vo.dart';

part 'packages_response.g.dart';

@JsonSerializable()
class PackagesResponse {
  @JsonKey(name: "status_code")
  final int? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final List<PackageVO>? data;

  PackagesResponse(
      {this.status,
      this.message,
      this.data,
      });

  factory PackagesResponse.fromJson(Map<String, dynamic> json) =>
      _$PackagesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PackagesResponseToJson(this);
}
