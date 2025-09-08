import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/api_services.dart';
import '../../../../core/utils/local_storage_helper.dart';
import '../../../../core/utils/models/user_model.dart';
import 'auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final SupabaseClient client = Supabase.instance.client;
  final ApiServices _api = ApiServices();

  @override
  Future<Either<Failure, bool>> login({
    required String email,
    required String password,
  }) async {
    try {
      // تسجيل الدخول
      final response = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = response.user;
      if (response.user == null || response.session == null) {
        return left(
          ServerFailure(
            'فشل إنشاء الحساب، قد يكون البريد الإلكتروني مستخدم بالفعل.',
          ),
        );
      }

      // جلب بيانات المستخدم من جدول users عن طريق API
      final userId = user?.id;
      final userResponse = await _api.getData(path: 'stores?id=eq.$userId');

      if (userResponse.data == null || userResponse.data.isEmpty) {
        return left(
          ServerFailure('لم يتم العثور على بيانات المستخدم في قاعدة البيانات.'),
        );
      }


      await LocalStorageHelper.saveUserName(userResponse.data[0]['arabic_name']);


      return right(true);
    } on AuthException catch (e) {
      log(e.toString());
      return left(ServerFailure(e.message));
    } on PostgrestException catch (e) {
      log(e.toString());

      return left(ServerFailure(e.message ?? 'خطأ في قاعدة البيانات'));
    } on DioException catch (e) {
      log(e.toString());

      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      log(e.toString());

      return left(ServerFailure('حدث خطأ غير متوقع: $e'));
    }
  }


}
