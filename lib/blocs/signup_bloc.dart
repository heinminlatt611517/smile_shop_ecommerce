import 'package:flutter/foundation.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/network/requests/otp_request.dart';
import 'package:smile_shop/network/responses/otp_response.dart';

class SignupBloc extends ChangeNotifier {
  /// State
  bool isLoading = false;
  String phoneNumber = "";
  String code = "";
  bool isDisposed = false;

  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  ///sign up
  Future<OtpResponse> onTapSignUp() {
    var otpRequest = OtpRequest(phoneNumber, code);
    _showLoading();
    return _smileShopModel
        .requestOtp(otpRequest)
        .whenComplete(() => _hideLoading());
  }

  void onPhoneNumberChanged(String phoneNumber) {
    this.phoneNumber = phoneNumber;
    notifyListeners();
  }

  void onReferralCodeChanged(String code) {
    this.code = code;
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
