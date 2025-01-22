import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/network/requests/otp_request.dart';
import 'package:smile_shop/network/requests/otp_verify_request.dart';

class OtpBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();


  /// State
  bool isLoading = false;
  bool isDisposed = false;
  var authToken = "";
  var endUserId = "";
  var pinCode = "";
  bool isFromForgotPasswordPage;

  /// Countdown timer variables
  Timer? _timer;
  int remainingSeconds = 240;
  bool isOtpExpired = false;

  OtpBloc(this.isFromForgotPasswordPage){
    authToken = _smileShopModel.getLoginResponseFromDatabase()?.refreshToken ?? "";
    endUserId = _smileShopModel.getLoginResponseFromDatabase()?.data?.id.toString() ?? "";
    startCountdown();
  }

  ///verify otp
  Future onTapVerifyOtp(String requestId) {
    var otpVerifyRequest = OtpVerifyRequest(pinCode, requestId);
    _showLoading();
    return isFromForgotPasswordPage == true ?  _smileShopModel
        .forgotPasswordVerifyOtp(otpVerifyRequest)
        .whenComplete(() => _hideLoading()) : _smileShopModel
        .verifyOtp(otpVerifyRequest)
        .whenComplete(() => _hideLoading());
  }

  ///request otp
  Future requestOtp(String phone,String code) {
    var otpRequest = OtpRequest(phone, code);
    _showLoading();
    return isFromForgotPasswordPage == true ? _smileShopModel
        .forgotPasswordRequestOtp(otpRequest)
        .whenComplete(() => _hideLoading()) : _smileShopModel
        .requestOtp(otpRequest)
        .whenComplete(() => _hideLoading());
  }

  /// Start the countdown timer
  void startCountdown() {
    remainingSeconds = 240;
    isOtpExpired = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        remainingSeconds--;
        _notifySafely();
      } else {
        timer.cancel();
        isOtpExpired = true;
        _notifySafely();
      }
    });
  }

  /// Stop the countdown timer if needed
  void _stopCountdown() {
    _timer?.cancel();
  }

  void onPinCodeChange(String newPinCode){
    pinCode = newPinCode;
    notifyListeners();
  }

  void onCompletePinCode(String completedPinCode){
    pinCode = completedPinCode;
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

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    isDisposed = true;
  }
}
