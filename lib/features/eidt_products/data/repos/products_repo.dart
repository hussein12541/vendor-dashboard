import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../add_product/data/models/category/category_model.dart';
import '../../../add_product/data/models/store/store_model.dart';
import '../models/product/product_model.dart';

abstract class ProductsRepo{
  Future<Either<Failure,List<ProductModel>>> getProducts();
  Future<Either<Failure,bool>> deleteProduct(String id,String deleteImageUrl);
  Future<Either<Failure,bool>> updateVisibility(String id,bool isShow);
  Future<Either<Failure,bool>> updateProduct({
    File? imageFile,
    Uint8List? pickedImageBytes,
    required String product_id,
    required String store_id,
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
  Future<Either<Failure, List<CategoryModel>>> getCategoriesAndStores();
}