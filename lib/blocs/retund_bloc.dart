import 'package:flutter/widgets.dart';
import 'package:smile_shop/data/vos/refund_vo.dart';
import 'package:smile_shop/network/api_constants.dart';

import '../data/model/smile_shop_model.dart';
import '../data/model/smile_shop_model_impl.dart';

class RefundBloc extends ChangeNotifier {
  List<RefundVO> refundList = [];
  bool isLoading = false;
  bool isDisposed = false;
  String authToken = '';
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  RefundBloc() {
    authToken =
        _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";
    getRefundList();
  }

  getRefundList() {
    _showLoading();
    _smileShopModel.getRefunds(authToken, kAcceptLanguageEn).then((response) {
      refundList = response;
    }).whenComplete(() => _hideLoading());
    _notifySafely();
  }

  getRefundListByStatus(int status) {
    _showLoading();
    _smileShopModel.getRefundsByStatus(authToken, kAcceptLanguageEn,status).then((response) {
      refundList = response;
    }).whenComplete(() => _hideLoading());
    _notifySafely();
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
