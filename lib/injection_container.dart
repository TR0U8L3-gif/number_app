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

final GetIt locator = GetIt.instance;

void setupServiceLocator() async {
  /// Features - Number Trivia
  //Bloc
  locator.registerFactory(() => NumberTriviaBloc(
        getConcreteNumberTrivia: locator(),
        getRandomNumberTrivia: locator(),
        inputConverter: locator(),
      ));

  //Use case
  locator.registerLazySingleton(() => GetConcreteNumberTrivia(locator()));
  locator.registerLazySingleton(() => GetRandomNumberTrivia(locator()));

  //Repository
  locator.registerLazySingleton<NumberTriviaRepository>(() => NumberTriviaRepositoryImpl(
        remoteDataSource: locator(),
        localDataSource: locator(),
        networkInfo: locator(),
      ));

  //Data sources
  locator.registerLazySingleton<NumberTriviaRemoteDataSource>(() => NumberTriviaRemoteDataSourceImpl(dio: locator()));
  locator.registerSingletonAsync<NumberTriviaLocalDataSource>(
      () async => NumberTriviaLocalDataSourceImpl(sharedPreferences: await locator.getAsync<SharedPreferences>()));

  /// Core

  //network
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(internetConnectionChecker: locator()));
  //utils
  locator.registerLazySingleton(() => InputConverter());

  /// External

  //Dio
  locator.registerLazySingleton(() => Dio());

  //Shared preferences
  locator.registerLazySingletonAsync<SharedPreferences>(() => SharedPreferences.getInstance());

  //Internet connection checker
  locator.registerSingleton(InternetConnectionChecker());
}
