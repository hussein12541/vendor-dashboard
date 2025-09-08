

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/models/user_model.dart';



abstract class AuthRepo {

  Future<Either<Failure, bool>> login({required String email,required String password,});



}

