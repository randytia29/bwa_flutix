import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc/blocs.dart';
import 'services/services.dart';
import 'shared/shared.dart';
import 'ui/pages/pages.dart';
import 'injection_container.dart' as di;

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> backgroundHandler(RemoteMessage message) async {
  RemoteNotification? notification = message.notification;

  if (notification != null) {
    print(notification.title);
    print(notification.body);

    await NotificationService.showNotificationNow(
        notification.hashCode, notification.title, notification.body);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: accentColor1));

  await NotificationService.notificationInitialize();
  NotificationService.timezoneInitialize();

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  await dotenv.load();

  await di.init();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => UserBloc()),
      BlocProvider(create: (_) => ThemeBloc()),
      BlocProvider(create: (_) => TicketBloc()),
      BlocProvider(
        create: (_) => AuthenticationBloc()..add(CheckIsAuthenticated()),
      ),
      // BlocProvider(
      //   create: (_) => MovieDetailBloc(),
      // )
    ],
    child: BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, themeState) => ScreenUtilInit(
        designSize: samsungJ6,
        builder: () => MaterialApp(
          theme: themeState.themeData,
          debugShowCheckedModeBanner: false,
          home: SplashPage(),
        ),
      ),
    ),
  ));
}
