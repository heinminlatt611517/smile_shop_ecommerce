import 'package:flutter/material.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/order_vo.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/data/vos/sub_category_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/network/requests/sub_category_request.dart';

class OrderBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  ///states
  List<OrderVO> orders = [];
  var isLoading = false;
  var isDisposed = false;
  var authToken = "";

  OrderBloc() {
    ///get data from database
    authToken =
        _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";

    ///get order list
    getAllOrder();
  }

  void getAllOrder(){
    _smileShopModel
        .orderList(authToken, kAcceptLanguageEn)
        .then((orderResponse) {
      orders = orderResponse;
      notifyListeners();
    });
  }

  void getOrdersByType(String type) {
    _smileShopModel
        .getOrderListByOrderType(authToken, kAcceptLanguageEn, type)
        .then((orderResponse) {
      orders = orderResponse;
      notifyListeners();
    });
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
