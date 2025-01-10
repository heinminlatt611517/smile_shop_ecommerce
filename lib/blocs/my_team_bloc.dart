import 'package:flutter/widgets.dart';
import 'package:smile_shop/data/vos/my_team_vo.dart';
import 'package:smile_shop/data/vos/user_vo.dart';

import '../data/model/smile_shop_model.dart';
import '../data/model/smile_shop_model_impl.dart';
import '../network/api_constants.dart';

class MyTeamBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  ///states
  UserVO? userProfile;
  List<MyTeamVO> myTeams = [];
  bool isLoading = false;
  bool isDisposed = false;
  var authToken = "";

  MyTeamBloc() {
    authToken =
        _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";
    userProfile = _smileShopModel.getUserDataFromDatabase();
    getMyTeams();
  }

  getMyTeams() {
    _showLoading();
    _smileShopModel.getMyTeams(authToken, kAcceptLanguageEn).then((response) {
      myTeams = response;
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
