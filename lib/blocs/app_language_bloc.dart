import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguageBloc extends ChangeNotifier {

  AppLanguageBloc(Locale locale) : _appLocale = locale;

  Locale _appLocale;
  Locale get appLocal => _appLocale;
  var box = GetStorage();

  Future<void> changeLanguage(String locale) async {
    var prefs = await SharedPreferences.getInstance();
    _appLocale = Locale(locale);
    await prefs.setString('language_code', locale);
    notifyListeners();
  }
}