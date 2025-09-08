import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide MultipartFile;
import 'package:uuid/uuid.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/api_services.dart';
import '../models/category/category_model.dart';
import '../models/store/store_model.dart';
import 'add_product_repo.dart';

class AddProductRepoImpl implements AddProductRepo {
  ApiServices _api = ApiServices();
  @override
  Future<Either<Failure, List<CategoryModel>>> getCategoriesAndStores() async {
    try {
      // جلب الفئات
      Response categoriesResponse = await _api.getData(path: 'categories');
      List<CategoryModel> categories = [];
      for (var item in categoriesResponse.data) {
        categories.add(CategoryModel.fromJson(item));
      }



      return Right(categories);
    } on Exception catch (e) {
      log(e.toString());
      return Left(ServerFailure(e.toString()));
    }
  }


  @override
  @override
  Future<Either<Failure, bool>> addProduct({
    File? imageFile,
    Uint8List? pickedImageBytes,
    required String category_id,
    required double price,
    required int quantity,
    required String? image_url,
    required String english_name,
    required String english_description,
    required String arabic_description,
    required String arabic_name,
    required double old_price,
    required String? delete_image_url,
    required bool is_show,
    required double weight,
  }) async {
    try {
      String finalImageUrl = image_url ?? '';
      String finalDeleteImageUrl = delete_image_url ?? '';

      if (imageFile != null || pickedImageBytes != null) {
        final uploadResult = await uploadImage(
          fileName: const Uuid().v4()+".png",
          bucketName: 'products_image',
          imageFile: imageFile,
          webImageBytes: pickedImageBytes,
        );

        if (uploadResult.isLeft()) {
          return Left(uploadResult.fold((l) {
            log(l.errMessage);
            return l;
          }, (r) => ServerFailure('فشل رفع الصورة')));
        }



        final (uploadedUrl, deletePath) = uploadResult.getOrElse(() => ('', ''));
        finalImageUrl = uploadedUrl;
        finalDeleteImageUrl = deletePath;
      }

      await _api.postData(
        path: 'products',
        data: {
          'category_id': category_id,
          'price': price,
          'quantity': quantity,
          'image_url': finalImageUrl,
          'english_name': english_name,
          'english_description': english_description,
          'arabic_description': arabic_description,
          'arabic_name': arabic_name,
          'old_price': old_price,
          'delete_image_url': finalDeleteImageUrl,
          'is_show': is_show,
          'weight': weight,
          'store_id': Supabase.instance.client.auth.currentUser!.id,
        },
      );

      return Right(true);
    } catch (e) {
      log("addProduct: $e");
      return Left(ServerFailure(e.toString()));
    }
  }


  @override
  final SupabaseClient supabase = Supabase.instance.client;





  Future<Either<Failure, (String, String)>> uploadImage({
    required String fileName,
    File? imageFile,
    Uint8List? webImageBytes,
    required String bucketName
  }) async {
    try {
      final uniqueName = fileName;

      if (kIsWeb) {
        const String storageBaseUrl =
            'https://hegfuluilgqgbcvtnymv.supabase.co/storage/v1/object';
        const String apiKey =
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhlZ2Z1bHVpbGdxZ2JjdnRueW12Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTM5NjY4MTAsImV4cCI6MjA2OTU0MjgxMH0.1_zZ2sKOW0FKobr9V8FwAfq2kaqF6CdiQS42PU71HfM';
        final String uploadUrl = "$storageBaseUrl/$bucketName/$fileName";
        final dio = Dio();
        Response response = await dio.post(
          data: FormData.fromMap({
            "file": MultipartFile.fromBytes(webImageBytes!, filename: fileName),
          }),
          uploadUrl,
          options: Options(
            headers: {
              "apikey": apiKey,
              "authorization": apiKey,
              "Content-Type": 'multipart/form-data',
            },
          ),
        );
        log(response.data["Key"]);

        return Right((uploadUrl, uniqueName));
      } else {
        // موبايل/ديسكتوب
        await supabase.storage.from('products_image').upload(uniqueName, imageFile!);

        final publicUrl =
        supabase.storage.from('products_image').getPublicUrl(uniqueName);

        return Right((publicUrl, uniqueName));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }


  // Future<void> deleteImage(String path) async {
  //   await supabase.storage.from('products_image').remove([path]);
  // }
  
}
