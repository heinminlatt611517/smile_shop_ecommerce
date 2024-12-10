import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:smile_shop/network/responses/login_response.dart';
import 'package:smile_shop/persistence/hive_constants.dart';

import '../utils/strings.dart';

class LoginDataDao {
  ///Must be singleton
  static final LoginDataDao _singleton = LoginDataDao._internal();

  factory LoginDataDao() {
    return _singleton;
  }

  LoginDataDao._internal();

  /**------------------------- CRUD OPERATIONS --------------------------**/

  ///save login user data to hive
  void saveLoginData(LoginResponse loginData) async {
    debugPrint("Token::${loginData.refreshToken}");
    getLoginDataBox().clear();
    await getLoginDataBox().put(kLoginData, loginData);
  }

  ///get login user data from hive
  LoginResponse? getLoginData() {
    return getLoginDataBox().get(kLoginData);
  }

  ///clear login user data from hive
  void clearUserData() {
    getLoginDataBox().clear();
  }

  /**--------------------------- GET BOX ------------------------------**/
  ///get login user data box
  Box<LoginResponse> getLoginDataBox() {
    return Hive.box<LoginResponse>(kBoxLoginResponse);
  }
}
