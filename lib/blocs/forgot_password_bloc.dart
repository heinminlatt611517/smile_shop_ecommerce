import 'package:flutter/foundation.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import '../network/responses/login_response.dart';

class ForgotPasswordBloc extends ChangeNotifier {
  /// State
  bool isLoading = false;
  String phone = "";
  bool isDisposed = false;

  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  ///onTap next
  Future<LoginResponse> onTapNext() {
    _showLoading();
    return Future.value();
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
