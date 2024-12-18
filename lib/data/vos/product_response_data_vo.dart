import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/brand_vo.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/data/vos/sub_category_vo.dart';

part 'product_response_data_vo.g.dart';

@JsonSerializable()
class ProductResponseDataVO {
  @JsonKey(name: 'current_page')
  final int? currentPage;

  @JsonKey(name: 'data')
  final List<ProductVO>? products;

  ProductResponseDataVO({
    this.currentPage,
    this.products
  });

  factory ProductResponseDataVO.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseDataVOFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseDataVOToJson(this);
}
