part of 'services.dart';

class NotificationService {
  static Future<void> notificationInitialize() async {
    final initializationSettingsAndroid =
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
          print('Notification payload: $payload');
        }
      },
    );
  }

  static void timezoneInitialize() {
    tz.initializeTimeZones();
  }

  static NotificationDetails _setupNotificationDetails() {
    final notificationDetailsAndroid = AndroidNotificationDetails(
        'movie_notif', 'movie_notif', 'Channel for Movie Notification',
        icon: 'flutix_logo',
        largeIcon: DrawableResourceAndroidBitmap('flutix_logo'));

    final notificationDetailsIOS = IOSNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);

    return NotificationDetails(
        android: notificationDetailsAndroid, iOS: notificationDetailsIOS);
  }

  static Future<void> setScheduleMovie(int id, String title, String body,
      {String payload = ''}) async {
    final scheduleNotificationDateTime =
        tz.TZDateTime.now(tz.local).add(Duration(seconds: 10));

    await flutterLocalNotificationsPlugin.zonedSchedule(id, title, body,
        scheduleNotificationDateTime, _setupNotificationDetails(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        payload: payload);
  }

  static Future<void> setTicketBought(int id, String title, String body,
      {String payload = ''}) async {
    await flutterLocalNotificationsPlugin
        .show(id, title, body, _setupNotificationDetails(), payload: payload);
  }
}
