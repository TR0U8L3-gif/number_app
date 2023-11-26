import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/error/exceptions.dart';
import '../../models/number_trivia_model.dart';
import 'number_trivia_local_data_source.dart';

// ignore: constant_identifier_names
const String CASHED_NUMBER_TRIVIA = 'CASHED_NUMBER_TRIVIA';

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource{
  final SharedPreferences sharedPreferences;
  NumberTriviaLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> cacheNumberTrivia(NumberTriviaModel trivia) async {
    NumberTriviaModel triviaToCache = NumberTriviaModel(number: trivia.number, text: trivia.text, isFromCache: true);
    return sharedPreferences.setString(CASHED_NUMBER_TRIVIA, json.encode(triviaToCache.toJson()));
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    String? jsonString = sharedPreferences.getString(CASHED_NUMBER_TRIVIA);
    if(jsonString == null){
      throw CacheException();
    }
    return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
  }
}
