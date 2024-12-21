import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/product_vo.dart';

class CartBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  ///Products to show
  List<ProductVO> productList = [];
  StreamSubscription? _productListSubscription;

  CartBloc(){
    ///first time get products from database
    firstTimeGetProductsFromDatabase();

    ///get books from database
    _productListSubscription =
        _smileShopModel.getProductFromDatabase().listen((books) {
          debugPrint("ProductLength:::${books.length}");
          productList = books;
          notifyListeners();
        });
  }

  void firstTimeGetProductsFromDatabase() {
    productList = _smileShopModel.firstTimeGetProductFromDatabase();
    notifyListeners();
  }

  void onTapChecked(ProductVO productVO){
    if(productVO.isChecked == true){
      var newProductVO = productVO.copyWith(isChecked: false);
      _smileShopModel.saveProductToHive(newProductVO);
    }
    else {
      var newProductVO = productVO.copyWith(isChecked: true);
      _smileShopModel.saveProductToHive(newProductVO);
    }
  }

  void onTapIncreaseQty(ProductVO productVO){
    int initialPrice = productVO.price!;
    var newProductVO = productVO.copyWith(qtyCount: productVO.qtyCount!+1);
    var updatedTotalPrice = newProductVO.qtyCount! * (initialPrice);
    _smileShopModel.saveProductToHive(newProductVO.copyWith(totalPrice: updatedTotalPrice));
  }

  void onTapDecreaseQty(ProductVO productVO){
    debugPrint("QtyCount:::::${productVO.qtyCount}");

    if (productVO.qtyCount! >= 0){
      int initialQtyPrice = productVO.price!;
      var newProductVO = productVO.copyWith(qtyCount: productVO.qtyCount! - 1);
      var updatedTotalPrice = newProductVO.qtyCount! * (initialQtyPrice);
      _smileShopModel.saveProductToHive(newProductVO.copyWith(totalPrice: updatedTotalPrice));
    }
    if(productVO.qtyCount == 1){
    _smileShopModel.deleteProductById(productVO.id!);
    }

  }


  @override
  void dispose() {
    _productListSubscription?.cancel();
    super.dispose();
  }

}
