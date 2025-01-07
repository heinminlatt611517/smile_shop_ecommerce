import 'package:flutter/widgets.dart';
import 'package:smile_shop/data/vos/order_vo.dart';
import 'package:smile_shop/network/api_constants.dart';

import '../data/model/smile_shop_model.dart';
import '../data/model/smile_shop_model_impl.dart';

class OrderDetailBloc extends ChangeNotifier{
  final SmileShopModel _smileShopModel = SmileShopModelImpl();
  OrderVO? orderDetails;
  var authToken = "";
  bool isLoading = false;
  String? orderId;
  OrderDetailBloc(this.orderId){

    authToken =
        _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";
    getOrderDetail(orderId: orderId ?? '');
  }

    getOrderDetail({required String orderId}){
    showLoading();
    _smileShopModel.orderDetails(authToken, kAcceptLanguageEn, orderId).then((orderData){
        orderDetails = orderData;
        notifyListeners();
    }).whenComplete(()=> hideLoading());
  }

  showLoading(){
    isLoading = true;
    notifyListeners();
  }

  hideLoading(){
    isLoading = false;
    notifyListeners();
  }

}