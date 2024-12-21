import 'package:flutter/material.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/network/api_constants.dart';

class ProductDetailsBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  ProductVO? productVO;
  bool isLoading = false;
  bool isDisposed = false;

  ProductDetailsBloc(String productId) {
    ///get data from database
    var authToken =
        _smileShopModel.getLoginResponseFromDatabase()?.refreshToken ?? "";
    var endUserId =
        _smileShopModel.getLoginResponseFromDatabase()?.data?.id.toString() ??
            "";

    ///get brands and categories
    _smileShopModel
        .getProductDetails(endUserId, productId, kAcceptLanguageEn, authToken)
        .then((productDetailsResponse) {
      productVO = productDetailsResponse;
      notifyListeners();
    });
  }

  void onTapAddToCart(){
    debugPrint("ProductName>>>>>>>${productVO?.name}");
    _smileShopModel.saveProductToHive(
        productVO?.copyWith(
            totalPrice: 0,
            qtyCount: 1) ?? ProductVO());
  }

  void _showLoading() {
    isLoading = true;
    _notifySafely();
  }

  void _hideLoading() {
    isLoading = false;
    _notifySafely();
  }

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }
}
