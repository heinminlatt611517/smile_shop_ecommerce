import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/payment_vo.dart';
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
  int? selectedIndex;

  PaymentBloc() {
    authToken =
        _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";

    debugPrint(authToken);

    ///get payment menthod list
    _smileShopModel.payments(authToken,kAcceptLanguageEn).then((paymentListResponse) {
      payments = paymentListResponse;
      _notifySafely();
    });
  }


  ///check out
  Future<void> onTapCheckout(int productId, int subTotal, int paymentType,
      List variantVOList) {
    _showLoading();
    return _smileShopModel
        .postOrder(authToken, kAcceptLanguageEn, productId, subTotal,
            paymentType,variantVOList)
        .whenComplete(() => _hideLoading());
  }

  void onSelectPayment(int index) {
    selectedIndex = isSelected(index) ? -1 : index;
    notifyListeners();
  }

  bool isSelected(int index) {
    return index == selectedIndex;
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
