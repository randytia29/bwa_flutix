import 'package:bwaflutix/features/flutix_transaction/data/datasources/flutix_transaction_local_data_source.dart';
import 'package:bwaflutix/features/flutix_transaction/data/datasources/flutix_transaction_remote_data_source.dart';
import 'package:bwaflutix/features/flutix_transaction/data/repositories/flutix_transaction_repository_impl.dart';
import 'package:bwaflutix/features/flutix_transaction/domain/repositories/flutix_transaction_repository.dart';
import 'package:bwaflutix/features/flutix_transaction/domain/usecases/get_transactions.dart';
import 'package:bwaflutix/features/flutix_transaction/domain/usecases/save_transaction.dart';
import 'package:bwaflutix/features/flutix_transaction/presentation/bloc/flutix_transaction_bloc.dart';
import 'package:bwaflutix/features/flutix_transaction/presentation/bloc/order_transaction_bloc.dart';
import 'package:hive/hive.dart';

import 'features/ticket/data/datasources/ticket_local_data_source.dart';
import 'features/ticket/data/datasources/ticket_remote_data_source.dart';
import 'features/ticket/data/repositories/ticket_repository_impl.dart';
import 'features/ticket/domain/repositories/ticket_repository.dart';
import 'features/ticket/domain/usecases/get_tickets.dart';
import 'features/ticket/domain/usecases/save_ticket.dart';
import 'features/ticket/presentation/bloc/order_ticket_bloc.dart';
import 'features/ticket/presentation/bloc/ticket_bloc.dart';
import 'services/shared_pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'core/network/network_info.dart';
import 'features/credit/data/datasources/credit_local_data_source.dart';
import 'features/credit/data/datasources/credit_remote_data_source.dart';
import 'features/credit/data/repositories/credit_repository_impl.dart';
import 'features/credit/domain/repositories/credit_repository.dart';
import 'features/credit/domain/usecases/get_credits.dart';
import 'features/credit/presentation/bloc/credit_bloc.dart';
import 'features/movie/data/datasources/movie_local_data_source.dart';
import 'features/movie/data/datasources/movie_remote_data_source.dart';
import 'features/movie/data/repositories/movie_repository_impl.dart';
import 'features/movie/domain/repositories/movie_repository.dart';
import 'features/movie/domain/usecases/get_details.dart';
import 'features/movie/domain/usecases/get_movies.dart';
import 'features/movie/presentation/bloc/movie_bloc.dart';
import 'features/movie/presentation/bloc/movie_detail_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Shared Preference
  final sharedPreferences = await SharedPreferences.getInstance();

  //! Features
  // Bloc
  sl.registerFactory(() => MovieBloc(movies: sl()));
  sl.registerFactory(() => MovieDetailBloc(details: sl()));
  sl.registerFactory(() => CreditBloc(credits: sl()));
  sl.registerFactory(() => TicketBloc(tickets: sl(), pref: sl()));
  sl.registerFactory(() => OrderTicketBloc(ticket: sl()));
  sl.registerFactory(
      () => FlutixTransactionBloc(transactions: sl(), pref: sl()));
  sl.registerFactory(() => OrderTransactionBloc(transaction: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetMovies(sl()));
  sl.registerLazySingleton(() => GetDetails(sl()));
  sl.registerLazySingleton(() => GetCredits(sl()));
  sl.registerLazySingleton(() => GetTickets(sl()));
  sl.registerLazySingleton(() => SaveTicket(sl()));
  sl.registerLazySingleton(() => GetTransaction(sl()));
  sl.registerLazySingleton(() => SaveTransaction(sl()));

  // Repository
  sl.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<CreditRepository>(() => CreditRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<TicketRepository>(() => TicketRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<FlutixTransactionRepository>(() =>
      FlutixTransactionRepositoryImpl(
          remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  // Data sources
  sl.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(sharedPreferences: sharedPreferences));

  sl.registerLazySingleton<CreditRemoteDataSource>(
      () => CreditRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<CreditLocalDataSource>(
      () => CreditLocalDataSourceImpl(sharedPreferences: sharedPreferences));

  sl.registerLazySingleton<TicketRemoteDataSource>(
      () => TicketRemoteDataSourceImpl(firebaseFirestore: sl()));
  sl.registerLazySingleton<TicketLocalDataSource>(
      () => TicketLocalDataSourceImpl(sharedPreferences: sharedPreferences));

  sl.registerLazySingleton<FlutixTransactionRemoteDataSource>(
      () => FlutixTransactionRemoteDataSourceImpl(firebaseFirestore: sl()));
  sl.registerLazySingleton<FlutixTransactionLocalDataSource>(
      () => FlutixTransactionLocalDataSourceImpl(hive: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(
      () => SharedPref(sharedPreferences: sharedPreferences));

  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => Hive);
}
