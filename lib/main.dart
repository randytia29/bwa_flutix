import 'dart:developer';
import 'dart:io';

import 'package:bwaflutix/features/flutix_transaction/domain/entities/flutix_transaction.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'bloc/authentication_bloc.dart';
import 'bloc/theme_bloc.dart';
import 'bloc/user_bloc.dart';
import 'services/notification_service.dart';
import 'shared/shared_value.dart';
import 'shared/theme.dart';
import 'ui/pages/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'injection_container.dart' as di;

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> backgroundHandler(RemoteMessage message) async {
  RemoteNotification? notification = message.notification;

  if (notification != null) {
    log(notification.title ?? '');
    log(notification.body ?? '');

    await NotificationService.showNotificationNow(
        notification.hashCode, notification.title, notification.body);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(FlutixTransactionAdapter());

  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: accentColor1));

  await NotificationService.notificationInitialize();
  NotificationService.timezoneInitialize();

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  await dotenv.load();

  await di.init();

  HttpOverrides.global = MyHttpOverrides();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => UserBloc()),
      BlocProvider(create: (_) => ThemeBloc()),
      BlocProvider(
        create: (_) => AuthenticationBloc()..add(CheckIsAuthenticated()),
      ),
    ],
    child: BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, themeState) => ScreenUtilInit(
        designSize: samsungJ6,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_) => MaterialApp(
          useInheritedMediaQuery: true,
          theme: themeState.themeData,
          debugShowCheckedModeBanner: false,
          home: const SplashPage(),
        ),
      ),
    ),
  ));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
