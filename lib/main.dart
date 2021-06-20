import 'package:bwaflutix/bloc/blocs.dart';
import 'package:bwaflutix/services/services.dart';
import 'package:bwaflutix/shared/shared.dart';
import 'package:bwaflutix/ui/pages/pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: accentColor1));

  runApp(StreamProvider.value(
    value: AuthServices.userStream,
    initialData: null,
    child: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PageBloc()),
        BlocProvider(create: (_) => UserBloc()),
        BlocProvider(create: (_) => ThemeBloc()),
        BlocProvider(create: (_) => MovieBloc()..add(FetchMovies())),
        BlocProvider(create: (_) => TicketBloc())
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (_, themeState) => ScreenUtilInit(
          designSize: samsungJ6,
          builder: () => MaterialApp(
            theme: themeState.themeData,
            debugShowCheckedModeBanner: false,
            home: Wrapper(),
          ),
        ),
      ),
    ),
  ));
}
