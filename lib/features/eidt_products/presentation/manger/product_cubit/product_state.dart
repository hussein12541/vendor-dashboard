
part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class GetProductsLoading extends ProductState {}
final class GetProductsSuccess extends ProductState {
  final List<ProductModel>products;
  GetProductsSuccess(this.products);
}
final class GetProductsError extends ProductState {
  final String errorMessage;
  GetProductsError(this.errorMessage);
}


final class GetCategoriesLoading extends ProductState {}
final class GetCategoriesSuccess extends ProductState {

}
final class GetCategoriesError extends ProductState {
  final String message;
  GetCategoriesError({required this.message});
}final class UpdateProductLoading extends ProductState {}
final class UpdateProductSuccess extends ProductState {

}
final class UpdateProductError extends ProductState {
  final String message;
  UpdateProductError({required this.message});
}