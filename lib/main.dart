import 'package:bwaflutix/bloc/blocs.dart';
import 'package:bwaflutix/services/services.dart';
import 'package:bwaflutix/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(StreamProvider.value(
    value: AuthServices.userStream,
    child: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PageBloc()),
        BlocProvider(create: (_) => UserFlutixBloc()),
        BlocProvider(create: (_) => ThemeBloc()),
        BlocProvider(create: (_) => MovieBloc()..add(FetchMovies())),
        BlocProvider(create: (_) => TicketBloc())
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (_, themeState) => MaterialApp(
          theme: themeState.themeData,
          debugShowCheckedModeBanner: false,
          home: Wrapper(),
        ),
      ),
    ),
  ));
}
