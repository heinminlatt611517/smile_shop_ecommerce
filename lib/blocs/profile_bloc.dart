import 'package:flutter/widgets.dart';
import 'package:smile_shop/data/vos/profile_vo.dart';
import 'package:smile_shop/network/api_constants.dart';

import '../data/model/smile_shop_model.dart';
import '../data/model/smile_shop_model_impl.dart';

class ProfileBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  ProfileVO? userProfile;
  ProfileBloc(){
    var authToken = _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";

    _smileShopModel.userProfile(authToken, kAcceptLanguageEn).then((response){
      userProfile = response;
      notifyListeners();
    });
  }

}