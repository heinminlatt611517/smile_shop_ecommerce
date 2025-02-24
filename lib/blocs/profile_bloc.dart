import 'package:flutter/widgets.dart';
import 'package:smile_shop/data/vos/user_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/network/responses/success_network_response.dart';
import 'package:smile_shop/persistence/noti_status.dart';

import '../data/model/smile_shop_model.dart';
import '../data/model/smile_shop_model_impl.dart';
import '../widgets/common_dialog.dart';
import '../widgets/session_expired_dialog_view.dart';

class ProfileBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  ///states
  UserVO? userProfile;
  bool isLoading = false;
  bool isDisposed = false;
  bool isNewNotiExist = false;
  var authToken = "";

  ProfileBloc(BuildContext context) {
    authToken = _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";
    getProfile(context);
    listenNotification();
  }

  void listenNotification() async {
    NotiStatus notiStatus = NotiStatus();
    isNewNotiExist = await notiStatus.getNotificationStatus();
    notiStatus.notificationStatusStream.listen(
      (event) async {
        isNewNotiExist = await notiStatus.getNotificationStatus();
        _notifySafely();
      },
    );
  }

  void getProfile(BuildContext context) {
    _showLoading();
    _smileShopModel
        .userProfile(authToken, kAcceptLanguageEn)
        .then((response) {
          userProfile = response;
          _notifySafely();
        })
        .whenComplete(() => _hideLoading())
        .catchError((error) {
          if (error.toString().toLowerCase() == 'unauthenticated') {
            showCommonDialog(
              context: context,
              dialogWidget: SessionExpiredDialogView(),
            );
          }
        });
  }

  Future<SuccessNetworkResponse> deleteAccount() {
    _showLoading();
    return _smileShopModel.deleteAccount(authToken).whenComplete(() => _hideLoading());
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
