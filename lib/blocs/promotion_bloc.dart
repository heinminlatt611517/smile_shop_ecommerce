import 'package:flutter/foundation.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/promotion_vo.dart';
import 'package:smile_shop/data/vos/wallet_transaction_vo.dart';
import 'package:smile_shop/data/vos/wallet_vo.dart';
import 'package:smile_shop/network/api_constants.dart';

import '../network/requests/login_request.dart';
import '../network/requests/wallet_transition_request.dart';
import '../network/responses/login_response.dart';

class PromotionBloc extends ChangeNotifier {
  /// State
  bool isLoading = false;
  bool isDisposed = false;
  WalletVO? walletVO;
  List<PromotionVO> promotions = [];
  var accessToken = "";
  int? selectedSegment = 0;
  dynamic walletTransitionRequest;

  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  PromotionBloc() {
    accessToken =
        _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";
    walletTransitionRequest = WalletTransitionRequest(1, kLogTypeIncome);

    ///get wallet data
    _smileShopModel.getWallet(accessToken, kAcceptLanguageEn).then((response) {
      walletVO = response;
      _notifySafely();
    });

    ///get initial promotion
    getPromotionByStatus();
  }

  void getPromotionByStatus() {
    _showLoading();
    _smileShopModel
        .getPromotionLogsByStatus(
            accessToken, kAcceptLanguageEn,selectedSegment == 0 ? kStatusIncome : kStatusOutCome)
        .then((response) {
      promotions = response;
      _notifySafely();
    }).whenComplete(() => _hideLoading());
  }

  void onChangedSegmentedControl(int index) {
    selectedSegment = index;
    getPromotionByStatus();
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

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
