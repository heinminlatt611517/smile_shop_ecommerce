import 'package:flutter/widgets.dart';
import 'package:smile_shop/data/vos/campaign_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/network/requests/campaign_detail_request.dart';
import 'package:smile_shop/network/requests/campaign_join_request.dart';

import '../data/model/smile_shop_model.dart';
import '../data/model/smile_shop_model_impl.dart';

class CampaignDetailBloc extends ChangeNotifier{
  CampaignVo? campaignDetail;
  bool isLoading = false;
  bool isDisposed = false;
  String authToken = '';
  int? campaignId;
  int? userId;
  final SmileShopModel _smileShopModel = SmileShopModelImpl();
  List<String> images = [];

  CampaignDetailBloc(this.campaignId){
    campaignId = campaignId;
    authToken =
        _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";
    userId = _smileShopModel.getLoginResponseFromDatabase()?.data?.id ?? 0;
    getCampaignDetail();
  }

  getCampaignDetail(){
    _showLoading();
    var request = CampaignDetailRequest(campaignId);
    _smileShopModel.getCampaignDetail(authToken, kAcceptLanguageEn, request).then((response){
      campaignDetail = response;
      images = response.joinedUsers?.isNotEmpty ?? true
          ? response.joinedUsers
          ?.map((e) => e.profileImage ?? "")
          .toList() ??
          []
          : [];
    }).whenComplete(()=> _hideLoading());
    notifyListeners();
  }

 Future joinCampaign(){
    var request = CampaignJoinRequest(campaignId, userId);
   return _smileShopModel.joinCampaign(authToken, kAcceptLanguageEn, request).whenComplete((){
     _notifySafely();
   });
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