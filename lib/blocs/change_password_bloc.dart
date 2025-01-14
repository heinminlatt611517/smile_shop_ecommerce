import 'package:flutter/foundation.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/firebase_user_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/network/requests/dealer_login_request.dart';

import '../network/firebase_api.dart';
import '../network/requests/login_request.dart';
import '../network/responses/login_response.dart';

class ChangePasswordBloc extends ChangeNotifier {
  /// State
  bool isLoading = false;
  String phone = "";
  String email = "";
  String password = "";
  bool isShowOldPassword = true;
  bool isShowNewPassword = true;
  bool isShowRetypePassword = true;
  bool isDisposed = false;
  bool isChecked = false;
  final FirebaseApi _api = FirebaseApi();

  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  ///sign in
  Future<LoginResponse> onTapSign() {
    var loginRequest = LoginRequest(phone, kTypeEndUser, password);
    _showLoading();
    return _smileShopModel
        .login(loginRequest)
        .whenComplete(() => _hideLoading());
  }

  ///sign in
  Future<LoginResponse> onTapDealerSign() {
    var loginRequest = DealerLoginRequest(email, kTypeDealer, password);
    _showLoading();
    return _smileShopModel
        .dealerLogin(loginRequest)
        .whenComplete(() => _hideLoading());
  }

  void crateFirebaseChatUser(
      {required int id,
      required String name,
      required String phone,
      }) async {
    var firebaseUser = FirebaseUserVo(id: id,name: name,phone: phone,role: 'user');
    await _api.createUser(firebaseUser);
  }

  void onPhoneNumberChanged(String phone) {
    this.phone = phone;
  }

  void onPasswordChanged(String password) {
    this.password = password;
  }

  void onChangedEmail(String newValue){
    email = newValue;
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
