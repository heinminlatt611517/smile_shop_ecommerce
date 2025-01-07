import 'package:flutter/material.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/checkIn_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/network/requests/checkIn_request.dart';

class DailyCheckInBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  CheckInVO? checkInVO;
  bool isLoading = false;
  bool isDisposed = false;
  var selectedColorName = "";
  var authToken = "";

  DailyCheckInBloc() {
    ///get data from database
    authToken =
        _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";


    ///get user daily checkin
    getDailyCheckIn();
  }

  void getDailyCheckIn() {
    _smileShopModel
        .getUserCheckIn(authToken, kAcceptLanguageEn)
        .then((checkInResponse) {
          debugPrint("CheckInCount>>>>>>${checkInResponse.totalCheckInPoint}");
      checkInVO = checkInResponse;
      _notifySafely();
    });
  }

  void onTapCheckIn(BuildContext context) {
    var checkInRequest = CheckInRequest(1);
    _showLoading();
    _smileShopModel
        .postUserCheckIn(authToken, kAcceptLanguageEn, checkInRequest)
        .then((response) {
        getDailyCheckIn();
    }).whenComplete(()=>_hideLoading());
  }

  void showSnackBar(
      BuildContext context, String description, Color snackBarColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(description),
        backgroundColor: snackBarColor,
        duration: const Duration(seconds: 2),
      ),
    );
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
}
