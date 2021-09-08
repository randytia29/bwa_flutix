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
  //! Features
  // Bloc
  sl.registerFactory(() => MovieBloc(movies: sl()));
  sl.registerFactory(() => MovieDetailBloc(details: sl()));
  sl.registerFactory(() => CreditBloc(credits: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetMovies(sl()));
  sl.registerLazySingleton(() => GetDetails(sl()));
  sl.registerLazySingleton(() => GetCredits(sl()));

  // Repository
  sl.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<CreditRepository>(() => CreditRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  // Data sources
  sl.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<CreditRemoteDataSource>(
      () => CreditRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<CreditLocalDataSource>(
      () => CreditLocalDataSourceImpl(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
