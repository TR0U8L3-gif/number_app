import 'package:equatable/equatable.dart';

class NumberTrivia extends Equatable {
  final int number;
  final String text;
  final bool isFromCache;
  const NumberTrivia({
    required this.number,
    required this.text,
    this.isFromCache = false,
  });
  @override
  List<Object?> get props => [number, text];
}
