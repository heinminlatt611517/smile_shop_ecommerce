import 'package:flutter/material.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/order_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/network/requests/order_cancel_request.dart';

class OrderBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  ///states
  List<OrderVO> orders = [];
  var isLoading = false;
  var isDisposed = false;
  var authToken = "";
  int index = 0;
  var orderType = "";

  OrderBloc(this.index) {
    ///get data from database
    authToken =
        _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";

    ///get order by type
    switch (index) {
      // case 1:
      //   getOrdersByType(kTypeToPay);
      case 0:
        getAllOrder();
      case 1:
        getOrdersByType(kTypeInWarehouse);
      case 2:
        getOrdersByType(kTypeStartDeliver);
      case 3:
        getOrdersByType(kTypeDelivered);
      case 4:
        getOrdersByType(kTypeFailed);
    }
  }

  void getAllOrder() {
    _showLoading();
    _smileShopModel
        .orderList(authToken, kAcceptLanguageEn)
        .then((orderResponse) {
      orders = orderResponse;
      orderType = "";
      notifyListeners();
    }).whenComplete(() => _hideLoading());
  }

  void getOrdersByType(String type) {
    _showLoading();
    if (type == "") {
      _smileShopModel
          .orderList(authToken, kAcceptLanguageEn)
          .then((orderResponse) {
        orders.clear();
        orders = orderResponse;
        orderType = "";
        notifyListeners();
      }).whenComplete(() => _hideLoading());
    } else {
      _smileShopModel
          .getOrderListByOrderType(authToken, kAcceptLanguageEn, type)
          .then((orderResponse) {
        orders.clear();
        orders = orderResponse;
        orderType = type;
        notifyListeners();
      }).whenComplete(() => _hideLoading());
    }
  }

  void onTapCancelOrder(String orderId) {
    var cancelOrderRequest = OrderCancelRequest(orderId);
    _smileShopModel
        .cancelOrder(authToken, kAcceptLanguageEn, cancelOrderRequest)
        .then((value) {
      if (value.status == 200) {
        getOrdersByType(orderType);
      }
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
