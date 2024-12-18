import 'package:flutter/material.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/address_vo.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/network/responses/address_response.dart';

class MyAddressBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  List<AddressVO> addressList = [];
  bool isLoading = false;
  bool isDisposed = false;

  MyAddressBloc() {
    _showLoading();
    ///get data from database
    var accessToken =
        _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";

    ///get address
    _smileShopModel
        .address(accessToken, kAcceptLanguageEn)
        .then((addressResponse) {
      addressList = addressResponse.data ?? [];
      _hideLoading();
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
}
