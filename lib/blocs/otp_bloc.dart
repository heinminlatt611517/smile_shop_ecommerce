import 'package:flutter/foundation.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/network/requests/otp_request.dart';

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

  ///sign in
  Future onTapVerifyOtp() {
    _showLoading();
    return _smileShopModel
        .verifyOtp(endUserId,pinCode,"1234",authToken)
        .whenComplete(() => _hideLoading());
  }

  ///sign in
  Future requestOtp() {
    var otpRequest = OtpRequest("", "");
    _showLoading();
    return _smileShopModel
        .requestOtp(otpRequest)
        .whenComplete(() => _hideLoading());
  }

  void onPinCodeChange(String newPinCode){
    pinCode = newPinCode;
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
