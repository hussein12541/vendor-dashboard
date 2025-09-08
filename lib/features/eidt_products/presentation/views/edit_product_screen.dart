import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:store_dash_board/features/eidt_products/presentation/views/widgets/form_field_section.dart' show EditFormFieldsSection;
import 'package:uuid/uuid.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../../../core/utils/functions/show_message.dart';
import '../../../add_product/data/models/category/category_model.dart';
import '../../../add_product/data/models/store/store_model.dart';
import '../../../add_product/presentation/views/widgets/form_fields_section.dart';
import '../../../add_product/presentation/views/widgets/image_section.dart';
import '../../data/models/product/product_model.dart';
import '../manger/product_cubit/product_cubit.dart';

class EditProductScreen extends StatefulWidget {
  final ProductModel product;
  const EditProductScreen({super.key, required this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _arabicNameController = TextEditingController();
  final TextEditingController _englishNameController = TextEditingController();
  final TextEditingController _arabicDescController = TextEditingController();
  final TextEditingController _englishDescController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _oldPriceController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  CategoryModel? _selectedCategory;
  StoreModel? _selectedStore;
  bool _isShow = true;
  bool _isUploading = false;
  String? _previewImageUrl;
  Uint8List? _localImageBytes;

  @override
  void initState() {
    super.initState();
    _imageUrlController.addListener(_updatePreview);
    context.read<ProductCubit>().getCategories();

    // تعبئة الكنترولرز بالبيانات القديمة
    _arabicNameController.text = widget.product.arabicName;
    _englishNameController.text = widget.product.englishName;
    _arabicDescController.text = widget.product.arabicDescription;
    _englishDescController.text = widget.product.englishDescription;
    _priceController.text = widget.product.price.toString();
    _oldPriceController.text = widget.product.oldPrice.toString();
    _weightController.text = widget.product.weight.toString();
    _quantityController.text = widget.product.quantity.toString();
    _imageUrlController.text = widget.product.imageUrl ?? '';
    _isShow = widget.product.isShow;
    _previewImageUrl = widget.product.imageUrl;
  }

  void _updatePreview() {
    setState(() {
      _previewImageUrl =
      _imageUrlController.text.isNotEmpty ? _imageUrlController.text : null;
      if (_previewImageUrl != null) {
        _localImageBytes = null; // Clear local image when URL is entered
      }
    });
  }

  Future<File?> _convertBytesToFile(Uint8List bytes, String fileName) async {
    if (kIsWeb) {
      return null;
    } else {
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/$fileName');
      await file.writeAsBytes(bytes);
      return file;
    }
  }

  Future<void> _updateProduct({
    required File? imageFile,
    required Uint8List? pickedImageBytes,
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
  }) async {
    if (_formKey.currentState!.validate()) {
      await context.read<ProductCubit>().updateProduct(
        product_id: widget.product.id,
        imageFile: imageFile,
        pickedImageBytes: pickedImageBytes,
        arabic_description: arabic_description,
        store_id: store_id,
        arabic_name: arabic_name,
        category_id: category_id,
        delete_image_url: delete_image_url,
        english_description: english_description,
        english_name: english_name,
        image_url: image_url,
        is_show: is_show,
        old_price: old_price,
        price: price,
        quantity: quantity,
        weight: weight,
      );
       context.read<ProductCubit>().getProducts();
      Navigator.pop(context);
      ShowMessage.showToast( "تم تحديث المنتج بنجاح",backgroundColor: Colors.green);
    }
  }

  @override
  void dispose() {
    _imageUrlController.removeListener(_updatePreview);
    _arabicNameController.dispose();
    _englishNameController.dispose();
    _arabicDescController.dispose();
    _englishDescController.dispose();
    _priceController.dispose();
    _oldPriceController.dispose();
    _weightController.dispose();
    _quantityController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLargeScreen = size.width > 1000;

    return WillPopScope(
      onWillPop: () async {
        /// هنا تقدر تنفذ اللي انت عاوزه قبل ما يرجع
        /// مثال: تعمل refresh للمنتجات أو تنفذ cubit
        context.read<ProductCubit>().getProducts();

        /// لازم ترجع true عشان يسمح بالرجوع
        return true;
      },
      child: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {

          if (state is GetCategoriesSuccess) {
            // لما يجيب الكاتيجوري يختار اللي ليه نفس ID
            final categories = context.read<ProductCubit>().categoriesItems;
            final matchedCat = categories.firstWhere(
                  (cat) => cat.id == widget.product.categoryId,
              orElse: () => categories.first,
            );
            setState(() {
              _selectedCategory = matchedCat;
            });
          }


        },
        builder: (context, state) {
          return (state is GetCategoriesSuccess || state is UpdateProductSuccess)
              ? Scaffold(

            body: Center(
              child: Container(
                color: Colors.grey.shade50,
                padding: EdgeInsets.symmetric(
                  horizontal: size.width > 1200 ? size.width * 0.1 : 32,
                  vertical: 24,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1400),
                    child: Form(
                      key: _formKey,
                      child: isLargeScreen
                          ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: EditFormFieldsSection(
                              arabicNameController:
                              _arabicNameController,
                              englishNameController:
                              _englishNameController,
                              arabicDescController:
                              _arabicDescController,
                              englishDescController:
                              _englishDescController,
                              priceController: _priceController,
                              oldPriceController: _oldPriceController,
                              weightController: _weightController,
                              quantityController: _quantityController,
                              selectedCategory: _selectedCategory,
                              selectedStore: _selectedStore,
                              isShow: _isShow,
                              isUploading: _isUploading,
                              onCategoryChanged: (newValue) {
                                setState(() {
                                  _selectedCategory = newValue as CategoryModel?;
                                });
                              },
                              onStoreChanged: (newValue) {
                                setState(() {
                                  _selectedStore = newValue as StoreModel?;
                                });
                              },
                              onShowChanged: (value) {
                                setState(() {
                                  _isShow = value;
                                });
                              },
                              onSave: () async {
                                File? imageFile;
                                if (_localImageBytes != null) {
                                  imageFile = await _convertBytesToFile(
                                    _localImageBytes!,
                                    Uuid().v4() + '.png',
                                  );
                                }

                                final bool isSameImage =
                                    (_imageUrlController.text == widget.product.imageUrl) &&
                                        _localImageBytes == null;

                                _updateProduct(
                                  imageFile: isSameImage ? null : imageFile,
                                  pickedImageBytes: isSameImage ? null : _localImageBytes,
                                  store_id: _selectedStore!.id,
                                  category_id: _selectedCategory!.id,
                                  price: double.tryParse(_priceController.text) ?? 0.0,
                                  quantity: int.tryParse(_quantityController.text) ?? 0,
                                  image_url: _imageUrlController.text.isNotEmpty
                                      ? _imageUrlController.text
                                      : null,
                                  english_name: _englishNameController.text,
                                  english_description: _englishDescController.text,
                                  arabic_description: _arabicDescController.text,
                                  arabic_name: _arabicNameController.text,
                                  old_price: double.tryParse(_oldPriceController.text) ?? 0.0,
                                  delete_image_url: widget.product.deleteImageUrl,
                                  is_show: _isShow,
                                  weight: double.tryParse(_weightController.text) ?? 0.0,
                                );
                              },

                            ),
                          ),
                          const SizedBox(width: 40),
                          Expanded(
                            child: ImageSection(
                              imageUrlController: _imageUrlController,
                              previewImageUrl: _previewImageUrl,
                              localImageBytes: _localImageBytes,
                              onImagePicked: (bytes) {
                                setState(() {
                                  _localImageBytes = bytes;
                                  _previewImageUrl = null;
                                  _imageUrlController.clear();
                                });
                              },
                            ),
                          ),
                        ],
                      )
                          : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            ImageSection(
                              imageUrlController: _imageUrlController,
                              previewImageUrl: _previewImageUrl,
                              localImageBytes: _localImageBytes,
                              onImagePicked: (bytes) {
                                setState(() {
                                  _localImageBytes = bytes;
                                  _previewImageUrl = null;
                                  _imageUrlController.clear();
                                });
                              },
                            ),
                            const SizedBox(height: 32),
                            FormFieldsSection(
                              arabicNameController:
                              _arabicNameController,
                              englishNameController:
                              _englishNameController,
                              arabicDescController:
                              _arabicDescController,
                              englishDescController:
                              _englishDescController,
                              priceController: _priceController,
                              oldPriceController: _oldPriceController,
                              weightController: _weightController,
                              quantityController: _quantityController,
                              selectedCategory: _selectedCategory,
                              isShow: _isShow,
                              isUploading: _isUploading,
                              onCategoryChanged: (newValue) {
                                setState(() {
                                  _selectedCategory = newValue;
                                });
                              },

                              onShowChanged: (value) {
                                setState(() {
                                  _isShow = value;
                                });
                              },
                              onSave: () async {
                                File? imageFile;
                                if (_localImageBytes != null) {
                                  imageFile = await _convertBytesToFile(
                                    _localImageBytes!,
                                    Uuid().v4() + '.png',
                                  );
                                }

                                final bool isSameImage =
                                    (_imageUrlController.text == widget.product.imageUrl) &&
                                        _localImageBytes == null;

                                _updateProduct(
                                  imageFile: isSameImage ? null : imageFile,
                                  pickedImageBytes: isSameImage ? null : _localImageBytes,
                                  store_id: _selectedStore!.id,
                                  category_id: _selectedCategory!.id,
                                  price: double.tryParse(_priceController.text) ?? 0.0,
                                  quantity: int.tryParse(_quantityController.text) ?? 0,
                                  image_url: _imageUrlController.text.isNotEmpty
                                      ? _imageUrlController.text
                                      : null,
                                  english_name: _englishNameController.text,
                                  english_description: _englishDescController.text,
                                  arabic_description: _arabicDescController.text,
                                  arabic_name: _arabicNameController.text,
                                  old_price: double.tryParse(_oldPriceController.text) ?? 0.0,
                                  delete_image_url: widget.product.deleteImageUrl,
                                  is_show: _isShow,
                                  weight: double.tryParse(_weightController.text) ?? 0.0,
                                );
                              },

                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
