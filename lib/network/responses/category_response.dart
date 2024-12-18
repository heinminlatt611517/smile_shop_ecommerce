import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/category_vo.dart';

part 'category_response.g.dart';

@JsonSerializable()
class CategoryResponse {
  @JsonKey(name: "status_code")
  final int? statusCode;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final List<CategoryVO>? data;

  CategoryResponse(
      {this.statusCode,
      this.message,
      this.data,
      });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}
