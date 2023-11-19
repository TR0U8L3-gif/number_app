import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_app/core/util/input_converter.dart';

main() {
  late InputConverter inputConverter;
  
  setUp(() {
    inputConverter = InputConverter();
  });
  
  group("stringToUnsignedInt", () { 
    test(
      'should return an integer when string represent unsigned integer',
      () async {
        // arrange
        const String str = "123";
        // act
        final result = inputConverter.stringToUnsignedInt(str);
        // assert
        expect(result, const Right(123));
      },
    );

    test(
      'should return Failure when string is not an int',
      () async {
        // arrange
        const String str = "-a123";
        // act
        final result = inputConverter.stringToUnsignedInt(str);
        // assert
        expect(result,  Left(InvalidInputFailure()));
      },
    );

    test(
      'should return Failure when string is a negative int',
          () async {
        // arrange
        const String str = "-123";
        // act
        final result = inputConverter.stringToUnsignedInt(str);
        // assert
        expect(result,  Left(InvalidInputFailure()));
      },
    );
  });
}
