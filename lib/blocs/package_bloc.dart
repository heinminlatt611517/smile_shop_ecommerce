import 'package:flutter/widgets.dart';
import 'package:smile_shop/data/vos/package_vo.dart';
import 'package:smile_shop/network/api_constants.dart';

import '../data/model/smile_shop_model.dart';
import '../data/model/smile_shop_model_impl.dart';

class PackageBloc extends ChangeNotifier {
  List<PackageVO> packages = [];
  bool isLoading = false;
  bool isDisposed = false;
  String authToken = '';
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  PackageBloc() {
    authToken =
        _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";
    getPackages();
  }

  getPackages() {
    _showLoading();
    _smileShopModel.getPackages(authToken, kAcceptLanguageEn).then((response) {
      packages = response;
    }).whenComplete(() => _hideLoading());
    notifyListeners();
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
