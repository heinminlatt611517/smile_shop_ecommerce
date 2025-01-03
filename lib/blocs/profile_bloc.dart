import 'package:flutter/widgets.dart';
import 'package:smile_shop/data/vos/profile_vo.dart';
import 'package:smile_shop/network/api_constants.dart';

import '../data/model/smile_shop_model.dart';
import '../data/model/smile_shop_model_impl.dart';

class ProfileBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  ///states
  ProfileVO? userProfile;
  bool isLoading = false;
  bool isDisposed = false;
  var authToken = "";
  ProfileBloc(){
     authToken = _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";

     getProfile();
  }

  void getProfile(){
    _showLoading();
    _smileShopModel.userProfile(authToken, kAcceptLanguageEn).then((response){
      userProfile = response;
      _notifySafely();
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

}