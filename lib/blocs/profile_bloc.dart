import 'package:flutter/widgets.dart';
import 'package:smile_shop/data/vos/user_vo.dart';
import 'package:smile_shop/network/api_constants.dart';

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
  var authToken = "";
  ProfileBloc(BuildContext context){
     authToken = _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";
     getProfile(context);
  }

  void getProfile(BuildContext context){
    _showLoading();
    _smileShopModel.userProfile(authToken, kAcceptLanguageEn).then((response){
      userProfile = response;
      _notifySafely();
    }).whenComplete(()=> _hideLoading()).catchError((error){
      if (error.toString().toLowerCase() == 'unauthenticated') {
        showCommonDialog(
          context: context,
          dialogWidget: SessionExpiredDialogView(),
        );
      }
    });
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