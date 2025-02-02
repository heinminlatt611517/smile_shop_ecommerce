import 'package:json_annotation/json_annotation.dart';

part 'favourite_product_request.g.dart';

@JsonSerializable()
class FavouriteProductRequest {
  @JsonKey(name: "product_id")
  final int? productId;

  @JsonKey(name: "status")
  final String? status;

  FavouriteProductRequest({
    this.productId,
    this.status,
  });

  factory FavouriteProductRequest.fromJson(Map<String, dynamic> json) =>
      _$FavouriteProductRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FavouriteProductRequestToJson(this);
}
