import 'package:dartz/dartz.dart';

import '../error/failures.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInt(String str) {
    int? number = int.tryParse(str);
    if(number == null || number < 0){
      return Left(InvalidInputFailure());
    }
    return Right(number);
  }
}

class InvalidInputFailure extends Failure {}
