import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/address_vo.dart';
import 'package:smile_shop/network/api_constants.dart';

class MyAddressBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  List<AddressVO> addressList = [];
  bool isLoading = false;
  bool isDisposed = false;

  MyAddressBloc() {
    ///get address
    _loadAddress();
  }

  /// Call the API to load the address
  void _loadAddress() {
    _showLoading();
    var accessToken = _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";

    debugPrint("AccessToken:::$accessToken");

    _smileShopModel.address(accessToken, kAcceptLanguageEn).then((addressResponse) {
      addressList = addressResponse.data?.addressVO ?? [];
      _hideLoading();
      notifyListeners();
    });
  }

  void refreshAddress() {
    _loadAddress();
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
