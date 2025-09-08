class StoreModel {
  final String id;
  final String email;
  final String password;
  final String arabicName;
  final String arabic_description;
  final String english_description;
  final String imageUrl;
  final DateTime createdAt;
  final bool isShow;
  final String? deleteImageUrl;
  final String englishName;

  StoreModel({
    required this.id,
    required this.password,
    required this.email,
    required this.arabicName,
    required this.arabic_description,
    required this.english_description,
    required this.imageUrl,
    required this.createdAt,
    required this.isShow,
    this.deleteImageUrl,
    required this.englishName,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      arabicName: json['arabic_name'] as String,
      arabic_description: json['arabic_description'] as String,
      english_description: json['english_description'] as String,
      imageUrl: json['image_url'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      isShow: json['is_show'] as bool,
      deleteImageUrl: json['delete_image_url'] as String?,
      englishName: json['english_name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'password': password,
      'email': email,
      'arabic_name': arabicName,
      'arabic_description': arabic_description,
      'english_description': english_description,
      'image_url': imageUrl,
      'created_at': createdAt.toIso8601String(),
      'is_show': isShow,
      'delete_image_url': deleteImageUrl,
      'english_name': englishName,
    };
  }
}
