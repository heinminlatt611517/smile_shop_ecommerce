import 'package:flutter/foundation.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/network/requests/set_password_request.dart';
import 'package:smile_shop/network/responses/set_password_response.dart';

import '../network/firebase_api.dart';

class PasswordBloc extends ChangeNotifier {
  /// State
  bool isLoading = false;
  bool isDisposed = false;

  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  var authToken = "";
  var endUserId = "";
  var password = "";
  var confirmPassword = "";
  final FirebaseApi _api = FirebaseApi();

  PasswordBloc() {
    authToken =
        _smileShopModel.getLoginResponseFromDatabase()?.refreshToken ?? "";
    endUserId =
        _smileShopModel.getLoginResponseFromDatabase()?.data?.id.toString() ??
            "";
  }

  ///on tap confirm
  Future<SetPasswordResponse> onTapConfirm(String requestId, String phone) {
    var setPasswordRequest =
        SetPasswordRequest(requestId, password, confirmPassword, phone);
    _showLoading();
    return _smileShopModel
        .setPassword(setPasswordRequest)
        .whenComplete(() => _hideLoading());
  }

  void crateFirebaseChatUser(
      {required int id}) async {
    await _api.createChats(id.toString());
  }

  void onPasswordChanged(String newPassword) {
    password = newPassword;
    _notifySafely();
  }

  void onConfirmPasswordChanged(String newConfirmPassword) {
    confirmPassword = newConfirmPassword;
    _notifySafely();
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
