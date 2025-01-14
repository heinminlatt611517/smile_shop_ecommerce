import 'package:flutter/widgets.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/network/responses/campaign_history_response.dart';

import '../data/model/smile_shop_model.dart';
import '../data/model/smile_shop_model_impl.dart';

class CampaignHistoryBloc extends ChangeNotifier{
  List<CampaignDataVO> campaignHistories = [];
  bool isLoading = false;
  bool isDisposed = false;
  String authToken = '';
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  CampaignHistoryBloc(){
    authToken =
        _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";
    getCampaignHistories();
  }

  getCampaignHistories(){
    _showLoading();
    _smileShopModel.getCampaignHistory(authToken, kAcceptLanguageEn).then((response){
      campaignHistories = response.data ?? [];
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