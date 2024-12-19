import 'package:json_annotation/json_annotation.dart';

part 'sub_category_request.g.dart';

@JsonSerializable()
class SubCategoryRequest {
  @JsonKey(name: "category_id")
  final int? categoryId;

  SubCategoryRequest({
    this.categoryId,
  });

  factory SubCategoryRequest.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SubCategoryRequestToJson(this);
}
