import 'package:flutter/widgets.dart';
import 'package:smile_shop/data/vos/package_vo.dart';
import 'package:smile_shop/network/api_constants.dart';

import '../data/model/smile_shop_model.dart';
import '../data/model/smile_shop_model_impl.dart';

class PackageDetailsBloc extends ChangeNotifier {
  PackageVO? packages;
  bool isLoading = false;
  bool isDisposed = false;
  String authToken = '';
  int? packageId;
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  PackageDetailsBloc(this.packageId) {
    authToken =
        _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";
    getPackagesById();
  }

  getPackagesById() {
    _showLoading();
    _smileShopModel.getPackageDetails(authToken, kAcceptLanguageEn,packageId ?? 0).then((response) {
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
