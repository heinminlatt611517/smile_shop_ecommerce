import 'package:hive_flutter/adapters.dart';
import 'package:smile_shop/data/vos/user_vo.dart';
import 'package:smile_shop/persistence/hive_constants.dart';

import '../utils/strings.dart';

class UserDataDao {
  ///Must be singleton
  static final UserDataDao _singleton = UserDataDao._internal();

  factory UserDataDao() {
    return _singleton;
  }

  UserDataDao._internal();

  /**------------------------- CRUD OPERATIONS --------------------------**/

  ///save  user data to hive
  Future<void> saveUserData(UserVO? userVO) async {
    await getUserDataBox().put(kUserData, userVO!);
  }

  ///get  user data from hive
  UserVO? getUserData() {
    return getUserDataBox().get(kUserData);
  }

  ///clear user data from hive
  void clearUserData() {
    getUserDataBox().clear();
  }

  /**--------------------------- GET BOX ------------------------------**/
  ///get user data box
  Box<UserVO> getUserDataBox() {
    return Hive.box<UserVO>(kBoxUser);
  }
}
