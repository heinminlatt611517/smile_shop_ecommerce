import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/payment_vo.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:flutter/material.dart';

import '../data/vos/variant_vo.dart';

class PaymentBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  /// State
  bool isLoading = false;
  bool isDisposed = false;
  var authToken = "";
  List<PaymentVO> payments = [];
  List<ProductVO> products = [];
  int? selectedIndex;
  var selectedPaymentType = "";

  PaymentBloc(this.products) {
    authToken =
        _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";

    debugPrint(authToken);

    ///get payment menthod list
    _smileShopModel
        .payments(authToken, kAcceptLanguageEn)
        .then((paymentListResponse) {
      payments = paymentListResponse;
      _notifySafely();
    });
  }

  ///check out
  Future<void> onTapCheckout(
       int subTotal, List variantVOList) {
    _showLoading();
    return _smileShopModel
        .postOrder(authToken, kAcceptLanguageEn, subTotal,
            selectedPaymentType, variantVOList, 'app')
        .whenComplete(() {
      _hideLoading();
    } );
  }

  void onSelectPayment(int index,String paymentType) {
    selectedIndex = isSelected(index) ? -1 : index;
    selectedPaymentType = paymentType;
    notifyListeners();
  }

  bool isSelected(int index) {
    return index == selectedIndex;
  }

  void clearAddToCartProductByProductIdFromDatabase(){
    for(var product in products){
      _smileShopModel.clearSaveAddToCartProductByProductId(product.id ?? 0);
    }
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

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
