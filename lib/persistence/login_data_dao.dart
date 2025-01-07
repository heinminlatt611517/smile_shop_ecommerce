import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:smile_shop/data/vos/login_data_vo.dart';
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
  Future<void> saveLoginData(LoginDataVO loginData) async {
    debugPrint("EndUserId::::${loginData.data?.id}");
    await getLoginDataBox().put(kLoginData, loginData);
  }

  ///get login user data from hive
  LoginDataVO? getLoginData() {
    return getLoginDataBox().get(kLoginData);
  }

  ///clear login user data from hive
  void clearLoginData() {
    getLoginDataBox().clear();
  }

  /**--------------------------- GET BOX ------------------------------**/
  ///get login user data box
  Box<LoginDataVO> getLoginDataBox() {
    return Hive.box<LoginDataVO>(kBoxLoginResponse);
  }
}
