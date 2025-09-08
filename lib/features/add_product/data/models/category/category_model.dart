class CategoryModel {
  final String id;
  final String arabicName;
  final String? imageUrl;
  final DateTime createdAt;
  final String? deleteImageUrl;
  final bool isShow;
  final String englishName;

  CategoryModel({
    required this.id,
    required this.arabicName,
    this.imageUrl,
    required this.createdAt,
    this.deleteImageUrl,
    required this.isShow,
    required this.englishName,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? '',
      arabicName: json['arabic_name'] ?? '',
      imageUrl: json['image_url'],
      createdAt: DateTime.parse(json['created_at']),
      deleteImageUrl: json['delete_image_url'],
      isShow: json['is_show'] ?? false,
      englishName: json['english_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'arabic_name': arabicName,
      'image_url': imageUrl,
      'created_at': createdAt.toIso8601String(),
      'delete_image_url': deleteImageUrl,
      'is_show': isShow,
      'english_name': englishName,
    };
  }
}
