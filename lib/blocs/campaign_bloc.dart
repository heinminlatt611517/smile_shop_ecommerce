import 'package:flutter/widgets.dart';
import 'package:smile_shop/data/vos/campaign_vo.dart';
import 'package:smile_shop/network/api_constants.dart';

import '../data/model/smile_shop_model.dart';
import '../data/model/smile_shop_model_impl.dart';

class CampaignBloc extends ChangeNotifier{
  List<CampaignVo> campaignLists = [];
  bool isLoading = false;
  bool isDisposed = false;
  String authToken = '';

  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  CampaignBloc(){
    authToken =
        _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";
    getCampaign();
  }

  getCampaign(){
    _showLoading();
    _smileShopModel.getCampaign(authToken, kAcceptLanguageEn).then((response){
      campaignLists = response;
    }).whenComplete(()=> _hideLoading());
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