import '../../../data/models/product/product_model.dart';

List<ProductModel> filterAndSortProducts(
    List<ProductModel> products,
    String searchQuery, {
      String? categoryId,
      String? storeId,
      bool? isShowFilter,
      String sortBy = 'date_desc',
    }) {
  // Start with all products
  List<ProductModel> filteredProducts = List.from(products);

  // Filter by category
  if (categoryId != null && categoryId.isNotEmpty) {
    filteredProducts =
        filteredProducts.where((p) => p.categoryId == categoryId).toList();
  }

  // Filter by store
  if (storeId != null && storeId.isNotEmpty) {
    filteredProducts =
        filteredProducts.where((p) => p.storeId == storeId).toList();
  }

  // Filter by isShow
  if (isShowFilter != null) {
    filteredProducts =
        filteredProducts.where((p) => p.isShow == isShowFilter).toList();
  }

  // Filter by search query (Arabic / English)
  if (searchQuery.isNotEmpty) {
    final query = searchQuery.toLowerCase();
    filteredProducts = filteredProducts.where((p) {
      final nameAr = p.arabicName.toLowerCase();
      final nameEn = p.englishName.toLowerCase();
      return nameAr.contains(query) || nameEn.contains(query);
    }).toList();
  }

  // Sorting
  switch (sortBy) {
    case 'date_asc':
      filteredProducts.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      break;
    case 'date_desc':
      filteredProducts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      break;
    case 'price_asc':
      filteredProducts.sort((a, b) => a.price.compareTo(b.price));
      break;
    case 'price_desc':
      filteredProducts.sort((a, b) => b.price.compareTo(a.price));
      break;
    case 'bought_times':
      filteredProducts.sort((a, b) => b.boughtTimes.compareTo(a.boughtTimes));
      break;
  }

  return filteredProducts;
}
