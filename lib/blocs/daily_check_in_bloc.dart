import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
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
      checkInVO = checkInResponse;
      _notifySafely();
    });
  }

  void onTapCheckIn(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime? lastCheckInDate = await getLastCheckInDate();
    if (lastCheckInDate != null && _isSameDay(currentDate, lastCheckInDate)) {
      showSnackBar(context,'You have already checked in today!',Colors.red);
      return;
    }
    else{
      var checkInRequest = CheckInRequest(1);
      _showLoading();

      _smileShopModel
          .postUserCheckIn(authToken, kAcceptLanguageEn, checkInRequest)
          .then((response) {
        setLastCheckInDate(currentDate);
        getDailyCheckIn();
      }).whenComplete(() => _hideLoading());
    }
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
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

  Future<DateTime?> getLastCheckInDate() async {
    final storage = GetStorage();
    String? lastCheckInString = storage.read('last_check_in_date');

    if (lastCheckInString != null) {
      return DateTime.parse(lastCheckInString);
    }
    return null;
  }

  Future<void> setLastCheckInDate(DateTime date) async {
    final storage = GetStorage();
    await storage.write('last_check_in_date', date.toIso8601String());
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
