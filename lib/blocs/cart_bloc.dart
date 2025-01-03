import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/product_vo.dart';

class CartBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  ///Products to show
  List<ProductVO> productList = [];
  List<ProductVO> filterProductByIsChecked = [];
  StreamSubscription? _productListSubscription;
  int? totalProductPrice;
  List<int> subTotalPrice = [];
  bool isDisposed = false;
  bool isAllSelectedProduct = false;

  CartBloc(){
    ///first time get products from database
    firstTimeGetProductsFromDatabase();

    ///get product from database
    _productListSubscription =
        _smileShopModel.getProductFromDatabase().listen((products) {
          debugPrint("ProductLength:::${products.length}");
          productList = products;
          notifyListeners();
        });

    if(productList.isNotEmpty){
      calculateTotalProductPrice();
    }
  }

  void onTapSelectAll(){
    isAllSelectedProduct = !isAllSelectedProduct;
    onTapSelectAllProduct();
    firstTimeGetProductsFromDatabase();
    calculateTotalProductPrice();
    _notifySafely();
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
    firstTimeGetProductsFromDatabase();
    calculateTotalProductPrice();
  }

  void onTapIncreaseQty(ProductVO productVO){
    int initialPrice = productVO.variantVO?.first.price ?? 0;
    var newProductVO = productVO.copyWith(qtyCount: productVO.qtyCount!+1);
    var updatedTotalPrice = newProductVO.qtyCount! * (initialPrice);
    _smileShopModel.saveProductToHive(newProductVO.copyWith(totalPrice: updatedTotalPrice));
    firstTimeGetProductsFromDatabase();
    calculateTotalProductPrice();
  }

  void onTapDecreaseQty(ProductVO productVO){
    if (productVO.qtyCount! >= 0){
      int initialQtyPrice = productVO.variantVO?.first.price ?? 0;
      var newProductVO = productVO.copyWith(qtyCount: productVO.qtyCount! - 1);
      var updatedTotalPrice = newProductVO.qtyCount! * (initialQtyPrice);
      _smileShopModel.saveProductToHive(newProductVO.copyWith(totalPrice: updatedTotalPrice));
    }
    if(productVO.qtyCount == 1){
    _smileShopModel.deleteProductById(productVO.id!);
    }
    firstTimeGetProductsFromDatabase();
    calculateTotalProductPrice();
  }

  void calculateTotalProductPrice(){
        filterProductByIsChecked =
            productList.where((product) => product.isChecked == true).toList();
        if(filterProductByIsChecked.isNotEmpty){
          subTotalPrice = filterProductByIsChecked.map((e) => e.totalPrice!).toList();
          totalProductPrice = subTotalPrice.reduce((first,second) => first+second);
          _notifySafely();
        }
        else {
          totalProductPrice = 0;
          _notifySafely();
        }
  }

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  void onTapSelectAllProduct(){
    if(isAllSelectedProduct == true){
      for(var product in productList){
        _smileShopModel.saveProductToHive(product.copyWith(isChecked: true));
      }
    }
    else {
      for(var product in productList){
        _smileShopModel.saveProductToHive(product.copyWith(isChecked: false));
      }
    }
  }


  @override
  void dispose() {
    super.dispose();
    _productListSubscription?.cancel();
    isDisposed = true;
  }

}
