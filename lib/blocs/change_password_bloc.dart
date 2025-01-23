import 'package:flutter/foundation.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/firebase_user_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/network/requests/dealer_login_request.dart';
import 'package:smile_shop/network/responses/success_network_response.dart';

import '../network/firebase_api.dart';
import '../network/requests/login_request.dart';
import '../network/responses/login_response.dart';

class ChangePasswordBloc extends ChangeNotifier {
  /// State
  bool isLoading = false;
  String oldPassword = "";
  String newPassword = "";
  String confirmPassword = "";
  bool isShowOldPassword = true;
  bool isShowNewPassword = true;
  bool isShowRetypePassword = true;
  bool isDisposed = false;
  bool isChecked = false;
  var authToken = "";
  var endUserId = "";

  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  ChangePasswordBloc() {
    authToken =
        _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";
    endUserId =
        _smileShopModel.getLoginResponseFromDatabase()?.data?.id.toString() ??
            "";
  }

  ///sign in
  Future<SuccessNetworkResponse> onTapConfirm() {
    _showLoading();
    return _smileShopModel
        .changePassword(authToken, kAcceptLanguageEn, int.parse(endUserId),
            oldPassword, newPassword, confirmPassword, 'password')
        .whenComplete(() => _hideLoading());
  }

  void onChangedOldPassword(String password){
    oldPassword = password;
    _notifySafely();
  }

  void onChangedNewPassword(String password){
    newPassword = password;
    _notifySafely();
  }

  void onChangedConfirmPassword(String password){
    confirmPassword = password;
    _notifySafely();
  }

  void _showLoading() {
    isLoading = true;
    _notifySafely();
  }

  void onTapShowOldPassword() {
    isShowOldPassword = !isShowOldPassword;
    _notifySafely();
  }

  void onTapShowNewPassword() {
    isShowNewPassword = !isShowNewPassword;
    _notifySafely();
  }

  void onTapShowRetypePassword() {
    isShowRetypePassword = !isShowRetypePassword;
    _notifySafely();
  }

  void onCheckChange() {
    isChecked = !isChecked;
    notifyListeners();
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
