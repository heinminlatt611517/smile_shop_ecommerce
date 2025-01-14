import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/wallet_transaction_vo.dart';
import 'package:smile_shop/data/vos/wallet_vo.dart';
import 'package:smile_shop/network/api_constants.dart';

import '../network/requests/check_wallet_password_request.dart';
import '../network/requests/login_request.dart';
import '../network/requests/wallet_transition_request.dart';
import '../network/responses/login_response.dart';
import '../utils/strings.dart';

class SmileWalletBloc extends ChangeNotifier {
  /// State
  bool isLoading = false;
  bool isDisposed = false;
  WalletVO? walletVO;
  List<WalletTransactionVO> walletTransactions = [];
  var accessToken = "";
  bool isShowSetPasswordText = true;
  int? selectedSegment = 0;
  dynamic walletTransitionRequest;

  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  SmileWalletBloc() {
    accessToken =
        _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";
    walletTransitionRequest = WalletTransitionRequest(1, kLogTypeIncome);

    ///get wallet data
    _smileShopModel.getWallet(accessToken, kAcceptLanguageEn).then((response) {
      walletVO = response;
      _notifySafely();
    });

    ///check wallet password
    checkWalletPassword();

    ///get initial wallet transactions
    getWalletTransaction(walletTransitionRequest);
  }

  void checkWalletPassword(){
    var checkWalletPasswordRequest = CheckWalletPasswordRequest(
        GetStorage().read(kBoxKeyWalletPassword));
    _smileShopModel.checkWalletPassword(
        accessToken, kAcceptLanguageEn, checkWalletPasswordRequest).then((response){
          if(response.status == 200){
            isShowSetPasswordText = false;
          }
          else {
           isShowSetPasswordText = true;
          }
          _notifySafely();
    });
  }

  void getWalletTransaction(WalletTransitionRequest walletTransactionRequest) {
    _showLoading();
    _smileShopModel
        .getWalletTransactions(
            accessToken, kAcceptLanguageEn, walletTransactionRequest)
        .then((response) {
      walletTransactions = response;
      _notifySafely();
    }).whenComplete(() => _hideLoading());
  }

  void onChangedSegmentedControl(int index) {
    selectedSegment = index;
    if (index == 0) {
      walletTransitionRequest = WalletTransitionRequest(1, kLogTypeIncome);
    } else {
      walletTransitionRequest = WalletTransitionRequest(1, kLogTypeOutCome);
    }

    ///get wallet transactions
    getWalletTransaction(walletTransitionRequest);
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
