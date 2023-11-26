import '../../domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  const NumberTriviaModel({required super.number, required super.text, super.isFromCache});

  factory NumberTriviaModel.fromJson(Map<String, dynamic> data) {
    return NumberTriviaModel(
        number:  (data['number'] as num).toInt(),
        text: data['text'],
        isFromCache: data['isFromCache'] ?? false,
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'number' : number,
      'text' : text,
      'isFromCache': isFromCache,
    };
  }
}
