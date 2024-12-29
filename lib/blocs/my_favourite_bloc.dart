import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/product_vo.dart';

class MyFavouriteBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  ///Products to show
  List<ProductVO> favouriteProductList = [];
  StreamSubscription? _productListSubscription;
  bool isDisposed = false;

  MyFavouriteBloc() {
    ///first time get products from database
    firstTimeGetProductsFromDatabase();

    ///get products from database
    _productListSubscription =
        _smileShopModel.getFavouriteProductFromDatabase().listen((products) {
      favouriteProductList = products.where((product) => product.isFavourite == true).toList();
      _notifySafely();
    });
  }

  void firstTimeGetProductsFromDatabase() {
    favouriteProductList = _smileShopModel
        .firstTimeGetFavouriteProductFromDatabase()
        .where((product) => product.isFavourite == true).toList();
    _notifySafely();
  }

  void onTapFavourite(ProductVO? productVO) {
    _smileShopModel.deleteFavouriteProductById(productVO?.id ?? 0);
    firstTimeGetProductsFromDatabase();
  }

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _productListSubscription?.cancel();
    isDisposed = true;
  }
}
