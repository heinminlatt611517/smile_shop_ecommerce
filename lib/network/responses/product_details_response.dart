import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/product_vo.dart';

part 'product_details_response.g.dart';

@JsonSerializable()
class ProductDetailsResponse {
  @JsonKey(name: "status_code")
  final int? statusCode;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final ProductVO? data;

  ProductDetailsResponse({this.statusCode, this.message, this.data});

  factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailsResponseToJson(this);
}
