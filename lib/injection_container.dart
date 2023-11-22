import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'core/util/input_converter.dart';
import 'features/number_trivia/data/data_sources/local/number_trivia_local_data_source.dart';
import 'features/number_trivia/data/data_sources/local/number_trivia_local_data_source_impl.dart';
import 'features/number_trivia/data/data_sources/remote/number_trivia_remote_data_source.dart';
import 'features/number_trivia/data/data_sources/remote/number_trivia_remote_data_source_impl.dart';
import 'features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'features/number_trivia/domain/use_cases/get_concrete_number_trivia.dart';
import 'features/number_trivia/domain/use_cases/get_random_number_trivia.dart';
import 'features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

final GetIt getIt = GetIt.instance;

void init() {
/// Features - Number Trivia

  //Bloc
  getIt.registerFactory(() =>
      NumberTriviaBloc(
        getConcreteNumberTrivia: getIt(),
        getRandomNumberTrivia: getIt(),
        inputConverter: getIt(),
      ));

  //Use case
  getIt.registerLazySingleton(() => GetConcreteNumberTrivia(getIt()));
  getIt.registerLazySingleton(() => GetRandomNumberTrivia(getIt()));

  //Repository
  getIt.registerLazySingleton<NumberTriviaRepository>(() =>
      NumberTriviaRepositoryImpl(
        remoteDataSource: getIt(),
        localDataSource: getIt(),
        networkInfo: getIt(),
      ));

  //Data sources
  getIt.registerLazySingleton<NumberTriviaRemoteDataSource>(() => NumberTriviaRemoteDataSourceImpl(dio: getIt()));
  getIt.registerLazySingleton<NumberTriviaLocalDataSource>(() => NumberTriviaLocalDataSourceImpl(sharedPreferences: getIt()));

/// Core

  //network
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(internetConnectionChecker: getIt()));
  //utils
  getIt.registerLazySingleton(() => InputConverter());

/// External

  //Dio
  getIt.registerLazySingleton(() => Dio());

  //Shared preferences
  getIt.registerLazySingletonAsync<SharedPreferences>(() => SharedPreferences.getInstance());

  //Internet connection checker
  getIt.registerSingleton(InternetConnectionChecker());
}
