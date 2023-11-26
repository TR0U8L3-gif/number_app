import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_case.dart';
import '../../../../core/util/input_converter.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/use_cases/get_concrete_number_trivia.dart';
import '../../domain/use_cases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';

part 'number_trivia_state.dart';

//ignore: constant_identifier_names
const String SERVER_FAILURE_MESSAGE = 'Server Failure';
//ignore: constant_identifier_names
const String CACHE_FAILURE_MESSAGE = 'Cache Failure - failed to retrieve number trivia from cache.\n\nOne of the reasons may be the lack of previously saved trivia on the device.\n\nConnect to the Internet and search for number trivia to save it.';
//ignore: constant_identifier_names
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Input - number must be a positive integer or zero';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter,
  }) : super(NumberTriviaEmpty()) {
    on<GetTriviaForConcreteNumber>(_onConcreteNumber);
    on<GetTriviaForRandomNumber>(_onRandomNumber);
  }

  _onConcreteNumber(
    GetTriviaForConcreteNumber event,
    Emitter<NumberTriviaState> emit,
  ) async {
    final inputEither =  inputConverter.stringToUnsignedInt(event.numberString);
    await inputEither.fold((failure) {
      emit(const NumberTriviaError(message: INVALID_INPUT_FAILURE_MESSAGE));
    }, (number) async {
      emit(NumberTriviaLoading());
      final failureOrTrivia = await getConcreteNumberTrivia(Params(number: number));
      _eitherLoadedOrErrorState(failureOrTrivia, emit);
    });
  }

  _onRandomNumber(
    GetTriviaForRandomNumber event,
    Emitter<NumberTriviaState> emit,
  ) async {
    emit(NumberTriviaLoading());
    final failureOrTrivia = await getRandomNumberTrivia(NoParams());
    _eitherLoadedOrErrorState(failureOrTrivia, emit);
  }

  void _eitherLoadedOrErrorState(Either<Failure, NumberTrivia> failureOrTrivia, Emitter<NumberTriviaState> emit) {
    failureOrTrivia.fold(
          (failure) => emit(NumberTriviaError(message: _mapFailureToMessage(failure))),
          (numberTrivia) => emit(NumberTriviaLoaded(numberTrivia: numberTrivia)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return "Unexpected error";
    }
  }
}
