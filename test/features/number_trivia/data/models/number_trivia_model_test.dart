import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_app/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';

main() {
  const tNumberTriviaModel = NumberTriviaModel(number: 1, text: "Test text");

  test(
    'should be a subclass of number trivia entity',
    () async {
      // assert
      expect(tNumberTriviaModel, isA<NumberTrivia>());
    },
  );

  group("from Json", () {
    test(
      'should return valid model when Json number is an integer',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture("trivia.json"));
        // act
        final result = NumberTriviaModel.fromJson(jsonMap);
        // assert
        expect(result, tNumberTriviaModel);
      },
    );

    test(
      'should return valid model when Json number is double',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture("trivia_double.json"));
        // act
        final result = NumberTriviaModel.fromJson(jsonMap);
        // assert
        expect(result, tNumberTriviaModel);
      },
    );
  });

  group("to Json", () {
    test(
      'should return valid Json data',
      () async {
      // act
        final result = tNumberTriviaModel.toJson();
      // assert
        expect(result, isA<Map<String, dynamic>>());
      },
    );

    test(
      'should return valid Json data with values',
          () async {
        // act
        final result = tNumberTriviaModel.toJson();
        // assert
        expect(result, {'number': 1, 'text': "Test text", 'isFromCache': false});
      },
    );
  });
}
