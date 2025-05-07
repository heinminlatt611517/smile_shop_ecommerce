// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive_flutter/adapters.dart';

import 'package:smile_shop/data/vos/brand_vo.dart';
import 'package:smile_shop/data/vos/color_vo.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/data/vos/size_vo.dart';
import 'package:smile_shop/data/vos/sub_category_vo.dart';
import 'package:smile_shop/data/vos/variant_vo.dart';
import 'package:smile_shop/persistence/hive_constants.dart';

part 'cart_item_vo.g.dart';

@HiveType(typeId: kHiveTypeCartVo, adapterName: kAdapterCartVO)
class CartItemVo {
  @HiveField(0)
  int? productId;
  @HiveField(1)
  String? productName;
  @HiveField(2)
  String? image;
  @HiveField(3)
  int? price;
  @HiveField(4)
  int? promotionPoint;
  @HiveField(5)
  String? color;
  @HiveField(6)
  String? size;
  @HiveField(7)
  String? variantId;
  @HiveField(8)
  int? quantity;
  @HiveField(9)
  bool? isSelected;
  @HiveField(10)
  int? variantPrice;
  @HiveField(11)
  String? subCategory;

  CartItemVo({
    this.productId,
    this.productName,
    this.image,
    this.price,
    this.promotionPoint,
    this.color,
    this.size,
    this.variantId,
    this.quantity,
    this.isSelected,
    this.variantPrice,
    this.subCategory,
  });

  ProductVO toProductVO() {
    return ProductVO(
        id: productId,
        name: productName,
        image: image,
        price: price,
        size: size,
        subcategory: SubcategoryVO(
          name: subCategory
        ),
        totalPrice: (quantity ?? 0) * (variantPrice ?? 0),
        variantVO: [
          VariantVO(
            id: int.tryParse(variantId ?? ''),
            colorName: color,
            price: variantPrice,
            productId: productId,
            qtyCount: quantity,
            image: image,
            promotionPoint: promotionPoint,
            sizeVO: SizeVO(value: size),
            colorVO: ColorVO(value: color),
          )
        ]);
  }

  @override
  bool operator ==(covariant CartItemVo other) {
    if (identical(this, other)) return true;

    return other.productId == productId &&
        other.productName == productName &&
        other.image == image &&
        other.price == price &&
        other.promotionPoint == promotionPoint &&
        other.color == color &&
        other.size == size &&
        other.variantId == variantId &&
        other.quantity == quantity &&
        other.isSelected == isSelected &&
        other.variantPrice == variantPrice &&
        other.subCategory == subCategory;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
        productName.hashCode ^
        image.hashCode ^
        price.hashCode ^
        promotionPoint.hashCode ^
        color.hashCode ^
        size.hashCode ^
        variantId.hashCode ^
        quantity.hashCode ^
        isSelected.hashCode ^
        variantPrice.hashCode ^
        subCategory.hashCode;
  }

  @override
  String toString() {
    return 'CartItemVo(productId: $productId, productName: $productName, image: $image, price: $price, promotionPoint: $promotionPoint, color: $color, size: $size, variantId: $variantId, quantity: $quantity, isSelected: $isSelected, variantPrice: $variantPrice, subCategory: $subCategory)';
  }
}
