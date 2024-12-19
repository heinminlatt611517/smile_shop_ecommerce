import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/category_vo.dart';

part 'address_categories_response.g.dart';

@JsonSerializable()
class AddressCategoriesResponse {
  @JsonKey(name: "status_code")
  final int? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final List<CategoryVO>? data;

  AddressCategoriesResponse(
      {this.status,
        this.message,
        this.data,
      });

  factory AddressCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$AddressCategoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddressCategoriesResponseToJson(this);
}
