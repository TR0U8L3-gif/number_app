part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();
}
class NumberTriviaEmpty extends NumberTriviaState {
  @override
  List<Object> get props => [];
}
class NumberTriviaLoading extends NumberTriviaState{
  @override
  List<Object> get props => [];
}
class NumberTriviaLoaded extends NumberTriviaState{
  final NumberTrivia numberTrivia;

  const NumberTriviaLoaded({required this.numberTrivia});
  @override
  List<Object> get props => [numberTrivia];
}
class NumberTriviaError extends NumberTriviaState {
  final String message;

  const NumberTriviaError({required this.message});

  @override
  List<Object?> get props => [message];


}
