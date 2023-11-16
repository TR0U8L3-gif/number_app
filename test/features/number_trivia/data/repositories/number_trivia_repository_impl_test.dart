import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_app/core/error/exceptions.dart';
import 'package:number_app/core/error/failures.dart';
import 'package:number_app/core/network/network_info.dart';
import 'package:number_app/features/number_trivia/data/data_sources/local/number_trivia_local_data_source.dart';
import 'package:number_app/features/number_trivia/data/data_sources/remote/number_trivia_remote_data_source.dart';
import 'package:number_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_app/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:number_app/features/number_trivia/domain/entities/number_trivia.dart';

class MockRemoteDataSource extends Mock implements NumberTriviaRemoteDataSource {}
class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}
class MockNetworkInfo extends Mock implements NetworkInfo {}

main() {
  late NumberTriviaRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body){
    group("device is online", () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((invocation) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Function body){
    group("device is offline", () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((invocation) async => false);
      });
      body();
    });
  }

  group("getConcreteNumberTrivia", () {
    const int tNumber = 1;
    const NumberTriviaModel tNumberTriviaModel = NumberTriviaModel(number: tNumber, text: 'test trivia');
    const NumberTrivia tNumberTrivia = tNumberTriviaModel;
    test('should check if the device is online', () async {
      //arrange
      when(() => mockRemoteDataSource.getConcreteNumberTrivia(tNumber))
          .thenAnswer((_) async => tNumberTriviaModel);
      when(() => mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel))
          .thenAnswer((_) async => Future.value(true));
      when(() => mockNetworkInfo.isConnected)
          .thenAnswer((_) async => true);
      // act
      repository.getConcreteNumberTrivia(tNumber);
      // assert
      verify(() => mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(() => mockRemoteDataSource.getConcreteNumberTrivia(tNumber))
              .thenAnswer((invocation) async => tNumberTriviaModel);
          when(() => mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel))
              .thenAnswer((invocation) async => Future.value(true));
          // act
          await repository.getConcreteNumberTrivia(tNumber);
          // assert
          verify(() => mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
          verify(() => mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
        },
      );

      test(
        'should return remote data when the call to remote data source is success',
        () async {
          // arrange
          when(() => mockRemoteDataSource.getConcreteNumberTrivia(tNumber))
              .thenAnswer((invocation) async => tNumberTriviaModel);
          when(() => mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel))
              .thenAnswer((invocation) => Future.value(true));
          // act
          final result = await repository.getConcreteNumberTrivia(tNumber);
          // assert
          verify(() => mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
          expect(result, equals(const Right(tNumberTrivia)));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(() => mockRemoteDataSource.getConcreteNumberTrivia(tNumber))
              .thenThrow(ServerException());
          when(() => mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel))
              .thenAnswer((invocation) => Future.value(false));
          // act
          final result = await repository.getConcreteNumberTrivia(tNumber);
          // assert
          verify(() => mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
          expect(result, equals( Left(ServerFailure())));
        },
      );
    });

    runTestsOffline( () {
      test(
        'should return last locally cashed data when the cashed data is present',
        () async {
          // arrange
          when(() => mockLocalDataSource.getLastNumberTrivia()).thenAnswer((invocation) async => tNumberTriviaModel);
          // act
          final result = await repository.getConcreteNumberTrivia(tNumber);
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(() => mockLocalDataSource.getLastNumberTrivia());
          expect(result, const Right(tNumberTrivia));
        },
      );
      
      test(
        'should return cache failure when no cashed data is present',
        () async {
          // arrange
          when(() => mockLocalDataSource.getLastNumberTrivia()).thenThrow(CacheException());
          // act
          final result = await repository.getConcreteNumberTrivia(tNumber);
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(() => mockLocalDataSource.getLastNumberTrivia());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });

  group("getRandomNumberTrivia", () {
    const NumberTriviaModel tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'test trivia');
    const NumberTrivia tNumberTrivia = tNumberTriviaModel;
    
    test(
      'should check if the device is online',
      () async {
        // arrange
        when(() => mockNetworkInfo.isConnected)
            .thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        when(() => mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel)).thenAnswer((invocation) async => Future.value(true));
        // act
        repository.getRandomNumberTrivia();
        // assert
        verify(() => mockNetworkInfo.isConnected);
      },
    );
    
    runTestsOnline(() {
      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(()=> mockRemoteDataSource.getRandomNumberTrivia()).thenAnswer((invocation) async => tNumberTriviaModel);
          when(()=> mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel)).thenAnswer((invocation) => Future.value(true));
          // act
          await repository.getRandomNumberTrivia();
          // assert
          verify(() => mockRemoteDataSource.getRandomNumberTrivia());
          verify(() => mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));

        },
      );

      test(
        'should return remote data when the call to remote data source is success',
        () async {
          // arrange
          when(()=> mockRemoteDataSource.getRandomNumberTrivia()).thenAnswer((invocation) async => tNumberTriviaModel);
          when(()=> mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel)).thenAnswer((invocation) => Future.value(true));
          // act
          final result = await repository.getRandomNumberTrivia();
          // assert
          verify(() => mockRemoteDataSource.getRandomNumberTrivia());
          expect(result, const Right(tNumberTrivia));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(() => mockRemoteDataSource.getRandomNumberTrivia())
              .thenThrow(ServerException());
          // act
          final result = await repository.getRandomNumberTrivia();
          // assert
          verify(() => mockRemoteDataSource.getRandomNumberTrivia());
          expect(result, equals( Left(ServerFailure())));
        },
      );
    });

    runTestsOffline((){
      test(
        'should return last locally cashed data when the cashed data is present',
            () async {
          // arrange
          when(() => mockLocalDataSource.getLastNumberTrivia()).thenAnswer((invocation) async => tNumberTriviaModel);
          // act
          final result = await repository.getRandomNumberTrivia();
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(() => mockLocalDataSource.getLastNumberTrivia());
          expect(result, const Right(tNumberTrivia));
        },
      );

      test(
        'should return cache failure when no cashed data is present',
            () async {
          // arrange
          when(() => mockLocalDataSource.getLastNumberTrivia()).thenThrow(CacheException());
          // act
          final result = await repository.getRandomNumberTrivia();
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(() => mockLocalDataSource.getLastNumberTrivia());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });
}
