import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/category/category_model.dart';
import '../models/store/store_model.dart';

abstract class AddProductRepo {
  Future<Either<Failure, List<CategoryModel>>> getCategoriesAndStores();
  Future<Either<Failure, (String, String)>> uploadImage({
    required String fileName,
    File? imageFile,
    Uint8List? webImageBytes,
    required String bucketName
  });
  Future<Either<Failure, bool>> addProduct(
     {
      required File? imageFile , 
       required Uint8List? pickedImageBytes,
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
      
     
     });
}