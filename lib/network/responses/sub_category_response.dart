import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/category_vo.dart';
import 'package:smile_shop/data/vos/sub_category_vo.dart';

part 'sub_category_response.g.dart';

@JsonSerializable()
class SubCategoryResponse {
  @JsonKey(name: "status_code")
  final int? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final List<SubcategoryVO>? data;

  SubCategoryResponse(
      {this.status,
        this.message,
        this.data,
      });

  factory SubCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SubCategoryResponseToJson(this);
}
