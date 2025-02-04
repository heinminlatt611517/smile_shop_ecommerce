import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/product_vo.dart';

part 'favourite_product_response.g.dart';

@JsonSerializable()
class FavouriteProductResponse {
  @JsonKey(name: "status_code")
  final int? statusCode;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final List<ProductVO>? data;

  FavouriteProductResponse({this.statusCode, this.message, this.data});

  factory FavouriteProductResponse.fromJson(Map<String, dynamic> json) =>
      _$FavouriteProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FavouriteProductResponseToJson(this);
}
