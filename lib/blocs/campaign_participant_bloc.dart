import 'package:flutter/widgets.dart';
import 'package:smile_shop/data/vos/campaign_participant_vo.dart';
import 'package:smile_shop/data/vos/campaign_vo.dart';
import 'package:smile_shop/network/api_constants.dart';

import '../data/model/smile_shop_model.dart';
import '../data/model/smile_shop_model_impl.dart';
import '../network/requests/campaign_detail_request.dart';

class CampaignParticipantBloc extends ChangeNotifier{
  List<CampaignParticipantVo> participantLists = [];
  bool isLoading = false;
  bool isDisposed = false;
  String authToken = '';
  int? campaignId;
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  CampaignParticipantBloc(this.campaignId){
    authToken =
        _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";
    getParticipants();
  }

  getParticipants(){
    _showLoading();
    var request = CampaignDetailRequest(campaignId);
    _smileShopModel.getCampaignParticipants(authToken, kAcceptLanguageEn,request).then((response){
      participantLists = response;
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