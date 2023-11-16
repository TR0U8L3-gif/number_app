import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_app/core/error/exceptions.dart';
import 'package:number_app/features/number_trivia/data/data_sources/local/number_trivia_local_data_source_impl.dart';
import 'package:number_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

main() {
  late MockSharedPreferences mockSharedPreferences;
  late NumberTriviaLocalDataSourceImpl dataSource;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = NumberTriviaLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getLastNumberTrivia', () {
    final tNumberTriviaModel = NumberTriviaModel.fromJson(json.decode(fixture("trivia_cached.json")));
    test(
      'should return NumberTrivia from SharedPreferences if there is one in the cache',
      () async {
        // arrange
        when(() => mockSharedPreferences.getString(any())).thenReturn(fixture("trivia_cached.json"));
        // act
        final result = await dataSource.getLastNumberTrivia();
        // assert
        verify(() => mockSharedPreferences.getString(CASHED_NUMBER_TRIVIA));
        expect(result, equals(tNumberTriviaModel));
      },
    );
    
    test(
      'should throw a CachedException from SharedPreferences if there is not any cached value',
      () async {
        // arrange
        when(() => mockSharedPreferences.getString(any())).thenReturn(null);
        // act
        final call =  dataSource.getLastNumberTrivia;
        // assert
        expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
      },
    );
  });
  
  group('cacheNumberTrivia', () { 
    const tNumberTriviaModel = NumberTriviaModel(number: 1, text: "test trivia");
    test(
      'should call SharedPreferences to cache the data',
      () async {
        //arrange
        when(()=> mockSharedPreferences.setString(any(), any())).thenAnswer((invocation) async => true);
        // act
        await dataSource.cacheNumberTrivia(tNumberTriviaModel);
        // assert
        String jsonString = json.encode(tNumberTriviaModel.toJson());
        verify(() => mockSharedPreferences.setString(CASHED_NUMBER_TRIVIA, jsonString));
      },
    );
  });

}