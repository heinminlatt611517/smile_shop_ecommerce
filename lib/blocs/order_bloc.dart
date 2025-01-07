import 'package:flutter/material.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/order_vo.dart';
import 'package:smile_shop/network/api_constants.dart';

class OrderBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  ///states
  List<OrderVO> orders = [];
  var isLoading = false;
  var isDisposed = false;
  var authToken = "";
  int index = 0;
  OrderBloc(this.index) {
    ///get data from database
    authToken =
        _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";

    ///get order list
    //getAllOrder();

    ///get order by type
    switch (index) {
      case 1:
        getOrdersByType(kTypeToPay);
      case 2:
        getOrdersByType(kTypeToShip);
      case 3:
        getOrdersByType(kTypeToReceive);
      case 4:
        getOrdersByType(kTypeToReview);
    }
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
    _showLoading();
    _smileShopModel
        .getOrderListByOrderType(authToken, kAcceptLanguageEn, type)
        .then((orderResponse) {
      orders = orderResponse;
      notifyListeners();
    }).whenComplete(()=> _hideLoading());
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
