import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_app/core/error/failures.dart';
import 'package:number_app/core/use_cases/use_case.dart';
import 'package:number_app/core/util/input_converter.dart';
import 'package:number_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_app/features/number_trivia/domain/use_cases/get_concrete_number_trivia.dart';
import 'package:number_app/features/number_trivia/domain/use_cases/get_random_number_trivia.dart';
import 'package:number_app/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class GetConcreteNumberTriviaMock extends Mock implements GetConcreteNumberTrivia {}

class GetRandomNumberTriviaMock extends Mock implements GetRandomNumberTrivia {}

class InputConverterMock extends Mock implements InputConverter {}

main() {
  late NumberTriviaBloc bloc;
  late GetConcreteNumberTriviaMock getConcreteNumberTriviaMock;
  late GetRandomNumberTriviaMock getRandomNumberTriviaMock;
  late InputConverterMock inputConverterMock;

  setUp(() {
    getConcreteNumberTriviaMock = GetConcreteNumberTriviaMock();
    getRandomNumberTriviaMock = GetRandomNumberTriviaMock();
    inputConverterMock = InputConverterMock();
    bloc = NumberTriviaBloc(
        getConcreteNumberTrivia: getConcreteNumberTriviaMock,
        getRandomNumberTrivia: getRandomNumberTriviaMock,
        inputConverter: inputConverterMock);
  });

  test("initial state should be empty", () {
    expect(bloc.state, NumberTriviaEmpty());
  });

  group("GetTriviaForConcreteNumber", () {

    const String tNumberString = "1";
    const int tNumberParsed = 1;
    const NumberTrivia tNumberTrivia = NumberTrivia(number: 1, text: "test trivia");

    setUp(() {
      registerFallbackValue(const Params(number: tNumberParsed));
    });

    void setUpInputConverterSuccess() => when(() => inputConverterMock.stringToUnsignedInt(any())).thenReturn(const Right(tNumberParsed));

    test(
      'should call InputConverter to validate and convert the string to an unsigned integer',
      () async {
        // arrange
        setUpInputConverterSuccess();
        when(() => getConcreteNumberTriviaMock(any())).thenAnswer((invocation) async => const Right(tNumberTrivia));
        // act
        bloc.add(GetTriviaForConcreteNumber(numberString: tNumberString));
        await untilCalled(() => inputConverterMock.stringToUnsignedInt(any()));
        // assert
        verify(() => inputConverterMock.stringToUnsignedInt(tNumberString));
      },
    );

    test(
      'should emit [Error] when the input is invalid',
      () async {
        // arrange
        when(() => inputConverterMock.stringToUnsignedInt(any())).thenReturn(Left(InvalidInputFailure()));
        // assert stream
        final expected = [const NumberTriviaError(message: INVALID_INPUT_FAILURE_MESSAGE)];
        expectLater(bloc.stream, emitsInOrder(expected));
        // act
        bloc.add(GetTriviaForConcreteNumber(numberString: tNumberString));
      },
    );

    test(
      'should get data for concrete use case',
      () async {
        // arrange
        setUpInputConverterSuccess();
        when(() => getConcreteNumberTriviaMock(any()))
            .thenAnswer((invocation) async => const Right(tNumberTrivia));
        // act
        bloc.add(GetTriviaForConcreteNumber(numberString: tNumberString));
        await untilCalled(() => getConcreteNumberTriviaMock(any()));
        // assert
        verify(() => getConcreteNumberTriviaMock(const Params(number: tNumberParsed)));
      },
    );

    test(
      'should emit [Loading Loaded] when the data is gotten successfully',
      () async {
        // arrange
        setUpInputConverterSuccess();
        when(() => getConcreteNumberTriviaMock(any()))
            .thenAnswer((invocation) async => const Right(tNumberTrivia));
        // assert
        final expected = [NumberTriviaLoading(), const NumberTriviaLoaded(numberTrivia: tNumberTrivia)];
        expectLater(bloc.stream, emitsInOrder(expected));
        // act
        bloc.add(GetTriviaForConcreteNumber(numberString: tNumberString));
      },
    );

    test(
      'should emit [Loading Error] when getting data fails',
          () async {
        // arrange
        setUpInputConverterSuccess();
        when(() => getConcreteNumberTriviaMock(any()))
            .thenAnswer((invocation) async => Left(ServerFailure()));
        // assert
        final expected = [NumberTriviaLoading(), const NumberTriviaError(message: SERVER_FAILURE_MESSAGE)];
        expectLater(bloc.stream, emitsInOrder(expected));
        // act
        bloc.add(GetTriviaForConcreteNumber(numberString: tNumberString));
      },
    );

    test(
      'should emit [Loading Error] with proper message for the error when getting data fails',
          () async {
        // arrange
        setUpInputConverterSuccess();
        when(() => getConcreteNumberTriviaMock(any()))
            .thenAnswer((invocation) async => Left(CacheFailure()));
        // assert
        final expected = [NumberTriviaLoading(), const NumberTriviaError(message: CACHE_FAILURE_MESSAGE)];
        expectLater(bloc.stream, emitsInOrder(expected));
        // act
        bloc.add(GetTriviaForConcreteNumber(numberString: tNumberString));
      },
    );
  });

  group("GetTriviaForRandomNumber", () {
    const NumberTrivia tNumberTrivia = NumberTrivia(number: 1, text: "test trivia");

    setUp(() {
      registerFallbackValue(NoParams());
    });

    test(
      'should get data for concrete use case',
          () async {
        // arrange
        when(() => getRandomNumberTriviaMock(any()))
            .thenAnswer((invocation) async => const Right(tNumberTrivia));
        // act
        bloc.add(const GetTriviaForRandomNumber());
        await untilCalled(() => getRandomNumberTriviaMock(any()));
        // assert
        verify(() => getRandomNumberTriviaMock(NoParams()));
      },
    );

    test(
      'should emit [Loading Loaded] when the data is gotten successfully',
          () async {
        // arrange
        when(() => getRandomNumberTriviaMock(any()))
            .thenAnswer((invocation) async => const Right(tNumberTrivia));
        // assert
        final expected = [NumberTriviaLoading(), const NumberTriviaLoaded(numberTrivia: tNumberTrivia)];
        expectLater(bloc.stream, emitsInOrder(expected));
        // act
        bloc.add(const GetTriviaForRandomNumber());
      },
    );

    test(
      'should emit [Loading Error] when getting data fails',
          () async {
        // arrange
        when(() => getRandomNumberTriviaMock(any()))
            .thenAnswer((invocation) async => Left(ServerFailure()));
        // assert
        final expected = [NumberTriviaLoading(), const NumberTriviaError(message: SERVER_FAILURE_MESSAGE)];
        expectLater(bloc.stream, emitsInOrder(expected));
        // act
        bloc.add(const GetTriviaForRandomNumber());
      },
    );

    test(
      'should emit [Loading Error] with proper message for the error when getting data fails',
          () async {
        // arrange
        when(() => getRandomNumberTriviaMock(any()))
            .thenAnswer((invocation) async => Left(CacheFailure()));
        // assert
        final expected = [NumberTriviaLoading(), const NumberTriviaError(message: CACHE_FAILURE_MESSAGE)];
        expectLater(bloc.stream, emitsInOrder(expected));
        // act
        bloc.add(const GetTriviaForRandomNumber());
      },
    );
  });
}
