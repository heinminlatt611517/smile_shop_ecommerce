import 'package:flutter/foundation.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/network/responses/otp_response.dart';
import '../network/requests/otp_request.dart';

class ForgotPasswordBloc extends ChangeNotifier {
  /// State
  bool isLoading = false;
  String phone = "";
  bool isDisposed = false;

  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  ///onTap next
  Future<OtpResponse> onTapNext() {
    _showLoading();
    var otpRequest = OtpRequest(phone, "");
    return _smileShopModel
        .forgotPasswordRequestOtp(otpRequest)
        .whenComplete(() => _hideLoading());
  }

  void onPhoneNumberChanged(String phone) {
    this.phone = phone;
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
