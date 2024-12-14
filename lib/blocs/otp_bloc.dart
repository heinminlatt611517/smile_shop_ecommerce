import 'package:flutter/foundation.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/network/requests/otp_request.dart';
import 'package:smile_shop/network/requests/otp_verify_request.dart';

class OtpBloc extends ChangeNotifier {
  /// State
  bool isLoading = false;
  bool isDisposed = false;

  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  var authToken = "";
  var endUserId = "";
  var pinCode = "";

  OtpBloc(){
    authToken = _smileShopModel.getLoginResponseFromDatabase()?.refreshToken ?? "";
    endUserId = _smileShopModel.getLoginResponseFromDatabase()?.data?.id.toString() ?? "";
  }

  ///verify otp
  Future onTapVerifyOtp(String requestId) {
    var otpVerifyRequest = OtpVerifyRequest(pinCode, requestId);
    _showLoading();
    return _smileShopModel
        .verifyOtp(otpVerifyRequest)
        .whenComplete(() => _hideLoading());
  }

  ///request otp
  Future requestOtp(String phone,String code) {
    var otpRequest = OtpRequest(phone, code);
    _showLoading();
    return _smileShopModel
        .requestOtp(otpRequest)
        .whenComplete(() => _hideLoading());
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
    isDisposed = true;
  }
}
