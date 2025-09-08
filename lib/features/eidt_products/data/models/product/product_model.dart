class ProductModel {
  final String id;
  final String storeId;
  final String categoryId;
  final String arabicName;
  final String arabicDescription;
  final double price;
  final int quantity;
  final String imageUrl;
  final DateTime createdAt;
  final String englishName;
  final String englishDescription;
  final double oldPrice;
  final int boughtTimes;
  final String deleteImageUrl;
  final bool isShow;
  final double weight;

  ProductModel({
    required this.id,
    required this.storeId,
    required this.categoryId,
    required this.arabicName,
    required this.arabicDescription,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    required this.createdAt,
    required this.englishName,
    required this.englishDescription,
    required this.oldPrice,
    required this.boughtTimes,
    required this.deleteImageUrl,
    required this.isShow,
    required this.weight,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      storeId: json['store_id'] ?? '',
      categoryId: json['category_id'] ?? '',
      arabicName: json['arabic_name'] ?? '',
      arabicDescription: json['arabic_description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 0,
      imageUrl: json['image_url'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      englishName: json['english_name'] ?? '',
      englishDescription: json['english_description'] ?? '',
      oldPrice: (json['old_price'] ?? 0).toDouble(),
      boughtTimes: json['bought_times'] ?? 0,
      deleteImageUrl: json['delete_image_url'] ?? '',
      isShow: json['is_show'] ?? false,
      weight: (json['weight'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'store_id': storeId,
      'category_id': categoryId,
      'arabic_name': arabicName,
      'arabic_description': arabicDescription,
      'price': price,
      'quantity': quantity,
      'image_url': imageUrl,
      'created_at': createdAt.toIso8601String(),
      'english_name': englishName,
      'english_description': englishDescription,
      'old_price': oldPrice,
      'bought_times': boughtTimes,
      'delete_image_url': deleteImageUrl,
      'is_show': isShow,
      'weight': weight,
    };
  }
}
