import 'package:flutter/material.dart';
import 'package:smile_shop/data/vos/address_vo.dart';
import 'package:smile_shop/data/vos/campaign_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/network/requests/campaign_detail_request.dart';
import 'package:smile_shop/network/requests/campaign_join_request.dart';
import 'package:smile_shop/pages/my_address_page.dart';
import 'package:smile_shop/utils/colors.dart';

import '../data/model/smile_shop_model.dart';
import '../data/model/smile_shop_model_impl.dart';

class CampaignDetailBloc extends ChangeNotifier {
  CampaignVo? campaignDetail;
  bool isLoading = false;
  bool isDisposed = false;
  String authToken = '';
  int? campaignId;
  int? userId;
  final SmileShopModel _smileShopModel = SmileShopModelImpl();
  List<String> images = [];
  List<AddressVO> addressList = [];

  CampaignDetailBloc(this.campaignId) {
    campaignId = campaignId;
    authToken =
        _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";
    userId = _smileShopModel.getLoginResponseFromDatabase()?.data?.id ?? 0;
    getCampaignDetail();
    _loadAddress();
  }

  getCampaignDetail() {
    _showLoading();
    var request = CampaignDetailRequest(campaignId);
    _smileShopModel
        .getCampaignDetail(authToken, kAcceptLanguageEn, request)
        .then((response) {
      campaignDetail = response;
      images = response.joinedUsers?.isNotEmpty ?? true
          ? response.joinedUsers?.map((e) => e.profileImage ?? "").toList() ??
              []
          : [];
    }).whenComplete(() => _hideLoading());
    notifyListeners();
  }

  Future joinCampaign(BuildContext context) async {
    bool isDefaultAddressExists = checkDefaultAddressExists();
    if (!isDefaultAddressExists) {
      showNeedAddressDialog(context);
      return;
    }

    final confirmResult = await showConfirmDialog(context);

    if (confirmResult == false) {
      return;
    }

    var request = CampaignJoinRequest(campaignId, userId);
    return _smileShopModel
        .joinCampaign(authToken, kAcceptLanguageEn, request)
        .whenComplete(() {
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

  bool checkDefaultAddressExists() {
    return addressList.any((address) => address.isDefault == 1);
  }

  /// Call the API to load the address
  void _loadAddress() {
    _showLoading();
    var accessToken =
        _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";

    _smileShopModel
        .address(accessToken, kAcceptLanguageEn)
        .then((addressResponse) {
      addressList = addressResponse.data?.addressVO ?? [];
      _hideLoading();
      notifyListeners();
    });
  }

  Future<bool> showConfirmDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ready to Join?'),
          content: Text(
            'If you’d like to participate in this campaign, it will cost ${campaignDetail?.price ?? 0} Smile Points. Are you sure you want to continue?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(
                'No, Thanks',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
              ),
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Yes, Join!'),
            ),
          ],
        );
      },
    );
    return result ?? false;
  }

  void showNeedAddressDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text(
            'We need your default address to deliver if you win the prize.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Cancel
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
              ),
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                await Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (context) =>
                            const MyAddressPage(needReturnValue: false)))
                    .then(
                  (value) {
                    _loadAddress();
                  },
                );
              },
              child: const Text('Check My Addresses'),
            ),
          ],
        );
      },
    );
  }
}
