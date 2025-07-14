import 'package:flutter/widgets.dart';
import 'package:smile_shop/data/vos/package_vo.dart';
import 'package:smile_shop/data/vos/user_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/persistence/login_data_dao.dart';
import 'package:smile_shop/persistence/user_data_dao.dart';

import '../data/model/smile_shop_model.dart';
import '../data/model/smile_shop_model_impl.dart';

class PackageBloc extends ChangeNotifier {
  List<PackageVO> packages = [];
  bool isLoading = false;
  bool isDisposed = false;
  String authToken = '';
  final SmileShopModel _smileShopModel = SmileShopModelImpl();
  UserVO? profile;
  final UserDataDao _userDao = UserDataDao();
  final LoginDataDao _loginDataDao = LoginDataDao();
  bool isDealer = false;
  PackageBloc() {
    authToken = _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";
    getPackages();
    getProfile();
  }

  getProfile() {
    profile = _userDao.getUserData() ?? UserVO();
    isDealer = !(_loginDataDao.getLoginData()?.isEndUser() ?? true);
    notifyListeners();
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
