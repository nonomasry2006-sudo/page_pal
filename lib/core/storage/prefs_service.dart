import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  PrefsService._();

  // -------- ONBOARDING --------
  static const String _onboardingKey = 'onboarding_seen';

  static Future<void> setOnboardingSeen(bool seen) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, seen);
  }

  static Future<bool> hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }

  static Future<void> clearOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_onboardingKey);
  }

  // -------- NOTIFICATIONS --------
  static const String _pushNotifKey = 'push_notifications';
  static const String _dailyReminderKey = 'daily_reminder';

  static Future<void> setPushNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_pushNotifKey, value);
  }

  static Future<bool> getPushNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_pushNotifKey) ?? true; // default ON
  }

  static Future<void> setDailyReminder(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_dailyReminderKey, value);
  }

  static Future<bool> getDailyReminder() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_dailyReminderKey) ?? false; // default OFF
  }
}