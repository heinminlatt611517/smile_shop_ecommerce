import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/banner_vo.dart';

part 'banner_response.g.dart';

@JsonSerializable()
class BannerResponse {
  @JsonKey(name: "status")
  final int? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final List<BannerVO>? data;

  BannerResponse(
      {this.status,
      this.message,
      this.data,
      });

  factory BannerResponse.fromJson(Map<String, dynamic> json) =>
      _$BannerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BannerResponseToJson(this);
}
