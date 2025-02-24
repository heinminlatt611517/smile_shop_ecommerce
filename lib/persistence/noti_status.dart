import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class NotiStatus {
  static final NotiStatus _instance = NotiStatus._internal();
  factory NotiStatus() => _instance;
  NotiStatus._internal();

  final StreamController<bool> _notificationStreamController = StreamController.broadcast();

  Stream<bool> get notificationStatusStream => _notificationStreamController.stream;

  Future<void> setNotificationStatus(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('newNoti', status);
    _notificationStreamController.add(status);  // Notify listeners
  }

  Future<bool> getNotificationStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('newNoti') ?? false; // Default to false
  }
}