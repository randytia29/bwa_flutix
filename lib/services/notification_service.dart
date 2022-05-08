import 'dart:developer';

import '../main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static Future<void> notificationInitialize() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('flutix_logo');

    final initializationSettingsIOS = IOSInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) async {},
    );

    final initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (payload) async {
        if (payload != null) {
          log('Notification payload: $payload');
        }
      },
    );
  }

  static void timezoneInitialize() {
    tz.initializeTimeZones();
  }

  static NotificationDetails _setupNotificationDetails() {
    const notificationDetailsAndroid = AndroidNotificationDetails(
        'channel id', 'channel name',
        icon: 'flutix_logo',
        sound: RawResourceAndroidNotificationSound('kamen_rider_birth'),
        priority: Priority.high,
        importance: Importance.max,
        largeIcon: DrawableResourceAndroidBitmap('flutix_logo'));

    const notificationDetailsIOS = IOSNotificationDetails(
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
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          androidAllowWhileIdle: true,
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
