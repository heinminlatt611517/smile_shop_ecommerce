import 'package:flutter/foundation.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';

import '../network/requests/login_request.dart';
import '../network/responses/login_response.dart';

class LogInBloc extends ChangeNotifier {
  /// State
  bool isLoading = false;
  String email = "";
  String password = "";
  bool isShowPassword = true;
  bool isDisposed = false;
  bool isChecked = false;

  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  ///sign in
  Future<LoginResponse> onTapSign() {
    var loginRequest = LoginRequest(email, password);
    _showLoading();
    return _smileShopModel
        .login(loginRequest)
        .whenComplete(() => _hideLoading());
  }
  
  void onEmailChanged(String email) {
    this.email = email;
  }

  void onPasswordChanged(String password) {
    this.password = password;
  }

  void _showLoading() {
    isLoading = true;
    _notifySafely();
  }

  void onTapShowPassword() {
    isShowPassword  = !isShowPassword;
    _notifySafely();
  }

  void onCheckChange(){
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
