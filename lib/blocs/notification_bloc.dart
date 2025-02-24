import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/notification_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/persistence/noti_status.dart';

class NotificationBloc extends ChangeNotifier {
  List<NotificationVO>? notificationList;
  bool isDisposed = false;
  var authToken = "";
  String currentLanguage = kAcceptLanguageEn;

  final SmileShopModel _model = SmileShopModelImpl();

  NotificationBloc() {
    NotiStatus().setNotificationStatus(false);
    getNotiList();
  }

  void getNotiList() async {
    ///get data from database
    authToken = _model.getLoginResponseFromDatabase()?.accessToken ?? "";

    var prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('language_code');
    if (languageCode == null) {
      currentLanguage = kAcceptLanguageEn;
    } else if (languageCode == "my") {
      currentLanguage = kAcceptLanguageMM;
    } else if (languageCode == "zh") {
      currentLanguage = kAcceptLanguageCh;
    } else {
      currentLanguage = kAcceptLanguageEn;
    }

    // Get Noti From Api
    await _model.getNotificationList(authToken, currentLanguage).then(
      (value) {
        notificationList = value;
        safeNotifyListeners();
      },
    );
  }

  void safeNotifyListeners() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}
