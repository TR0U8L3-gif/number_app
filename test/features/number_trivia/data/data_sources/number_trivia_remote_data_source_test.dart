import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_app/core/error/exceptions.dart';
import 'package:number_app/features/number_trivia/data/data_sources/remote/number_trivia_remote_data_source_impl.dart';
import 'package:number_app/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockDio extends Mock implements Dio {}

main() {
  late MockDio mockDio;
  late NumberTriviaRemoteDataSourceImpl dataSource;

  setUp(() {
    mockDio = MockDio();
    dataSource = NumberTriviaRemoteDataSourceImpl(dio: mockDio);
  });

  void setUpMockDioRequestSuccess() {
    when(() => mockDio.get(any()))
        .thenAnswer((invocation) async => Response(requestOptions: RequestOptions(), data: fixture('trivia.json'), statusCode: 200));
  }

  void setUpMockDioRequestError() {
    when(() => mockDio.get(any()))
        .thenAnswer((invocation) async => Response(requestOptions: RequestOptions(), data: fixture('trivia.json'), statusCode: 404));
  }

  group("getConcreteNumberTrivia", () {
    const int tNumber = 1;
    const String path = "http://numbersapi.com/$tNumber?json";
    final NumberTriviaModel tNumberTriviaModel = NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
    test(
      'should perform GET request on a URL with number being the endpoint with json format',
      () async {
        // arrange
        setUpMockDioRequestSuccess();
        // act
        dataSource.getConcreteNumberTrivia(tNumber);
        // assert
        verify(() => mockDio.get(path));
      },
    );
    
    test(
      'should return NumberTriviaModel when the response code is 200 (OK)',
      () async {
        // arrange
        setUpMockDioRequestSuccess();
        // act
        final result = await dataSource.getConcreteNumberTrivia(tNumber);
        // assert
        verify(() => mockDio.get(path));
        expect(result, equals(tNumberTriviaModel));
      },
    );
    
    test(
      'should throw ServerException when the response code is 404 (Not Found)',
      () async {
        // arrange
        setUpMockDioRequestError();
        // act
        final call =  dataSource.getConcreteNumberTrivia;
        // assert
        expect(() => call(tNumber), throwsA(const TypeMatcher<ServerException>()));
        
      },
    );
  });

  group("getRandomNumberTrivia", () {
    const String path = "http://numbersapi.com/random?json";
    final NumberTriviaModel tNumberTriviaModel = NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
    test(
      'should perform GET request on a URL with number being the endpoint with json format',
          () async {
        // arrange
        setUpMockDioRequestSuccess();
        // act
        dataSource.getRandomNumberTrivia();
        // assert
        verify(() => mockDio.get(path));
      },
    );

    test(
      'should return NumberTriviaModel when the response code is 200 (OK)',
          () async {
        // arrange
        setUpMockDioRequestSuccess();
        // act
        final result = await dataSource.getRandomNumberTrivia();
        // assert
        verify(() => mockDio.get(path));
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'should throw ServerException when the response code is 404 (Not Found)',
          () async {
        // arrange
        setUpMockDioRequestError();
        // act
        final call =  dataSource.getRandomNumberTrivia;
        // assert
        expect(() => call(), throwsA(const TypeMatcher<ServerException>()));

      },
    );
  });

}