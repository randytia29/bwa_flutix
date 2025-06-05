import 'dart:developer';

import '../main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static Future<void> notificationInitialize(
      void Function(NotificationResponse)?
          onDidReceiveBackgroundNotificationResponse) async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('flutix_logo');

    final initializationSettingsIOS = DarwinInitializationSettings();

    final initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) {
      if (notificationResponse.payload != null) {
        log(notificationResponse.payload ?? '');
      }
      log('test local');
    },
        onDidReceiveBackgroundNotificationResponse:
            onDidReceiveBackgroundNotificationResponse);
  }

  static void timezoneInitialize() {
    tz.initializeTimeZones();
  }

  static NotificationDetails _setupNotificationDetails() {
    const notificationDetailsAndroid = AndroidNotificationDetails(
      'channel id',
      'channel name',
      icon: 'flutix_logo',
      sound: RawResourceAndroidNotificationSound('kamen_rider_birth'),
      priority: Priority.high,
      importance: Importance.max,
      largeIcon: DrawableResourceAndroidBitmap('flutix_logo'),
    );

    const notificationDetailsIOS = DarwinNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);

    return const NotificationDetails(
        android: notificationDetailsAndroid, iOS: notificationDetailsIOS);
  }

  static Future<void> setScheduleMovie(
      int id, String title, String body, DateTime time,
      {String payload = ''}) async {
    try {
      tz.TZDateTime scheduleNotificationDateTime =
          tz.TZDateTime.from(time, tz.local)
              .subtract(const Duration(minutes: 30));

      await flutterLocalNotificationsPlugin.zonedSchedule(id, title, body,
          scheduleNotificationDateTime, _setupNotificationDetails(),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          payload: payload);
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> showNotificationNow(int id, String? title, String? body,
      {String payload = ''}) async {
    await flutterLocalNotificationsPlugin
        .show(id, title, body, _setupNotificationDetails(), payload: payload);
  }
}
