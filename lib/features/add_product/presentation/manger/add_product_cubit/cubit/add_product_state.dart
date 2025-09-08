part of 'add_product_cubit.dart';

@immutable
sealed class AddProductState {}

final class AddProductInitial extends AddProductState {}
final class GetCategoriesLoading extends AddProductState {}
final class GetCategoriesSuccess extends AddProductState {

}
final class GetCategoriesError extends AddProductState {
  final String message;
  GetCategoriesError({required this.message});
}

final class AddProductLoading extends AddProductState {}
final class AddProductSuccess extends AddProductState {
}
final class AddProductError extends AddProductState {
  final String message;
  AddProductError( {required this.message});
}
