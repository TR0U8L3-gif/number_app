part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  final String numberString;
  GetTriviaForConcreteNumber({required this.numberString}) : assert(numberString.isNotEmpty);

  int get number => int.parse(numberString);
  @override
  List<Object?> get props => [numberString];
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {

  const GetTriviaForRandomNumber();
  @override
  List<Object?> get props => [];

}