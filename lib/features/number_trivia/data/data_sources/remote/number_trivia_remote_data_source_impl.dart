import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../core/error/exceptions.dart';
import '../../models/number_trivia_model.dart';
import 'number_trivia_remote_data_source.dart';

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource{

  final Dio dio;
  NumberTriviaRemoteDataSourceImpl({required this.dio});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    final String path = "http://numbersapi.com/$number?json";
    Response response = await dio.get(path);

    if(response.statusCode == 200){
      return NumberTriviaModel.fromJson(json.decode(response.data));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    const String path = "http://numbersapi.com/random?json";
    Response response = await dio.get(path);

    if(response.statusCode == 200){
      return NumberTriviaModel.fromJson(json.decode(response.data));
    } else {
      throw ServerException();
    }
  }

}
