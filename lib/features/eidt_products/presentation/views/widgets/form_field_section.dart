import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../add_product/data/models/category/category_model.dart';
import '../../../../add_product/data/models/store/store_model.dart';
import '../../manger/product_cubit/product_cubit.dart';

class EditFormFieldsSection extends StatelessWidget {
  final TextEditingController arabicNameController;
  final TextEditingController englishNameController;
  final TextEditingController arabicDescController;
  final TextEditingController englishDescController;
  final TextEditingController priceController;
  final TextEditingController oldPriceController;
  final TextEditingController weightController;
  final TextEditingController quantityController;
  final CategoryModel? selectedCategory;
  final StoreModel? selectedStore;
  final bool isShow;
  final bool isUploading;
  final ValueChanged<CategoryModel?> onCategoryChanged;
  final ValueChanged<StoreModel?> onStoreChanged;
  final ValueChanged<bool> onShowChanged;
  final VoidCallback onSave;

  const EditFormFieldsSection({
    super.key,
    required this.arabicNameController,
    required this.englishNameController,
    required this.arabicDescController,
    required this.englishDescController,
    required this.priceController,
    required this.oldPriceController,
    required this.weightController,
    required this.quantityController,
    required this.selectedCategory,
    required this.selectedStore,
    required this.isShow,
    required this.isUploading,
    required this.onCategoryChanged,
    required this.onStoreChanged,
    required this.onShowChanged,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    bool isRTL = Directionality.of(context) == TextDirection.rtl;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: arabicNameController,
                    decoration: InputDecoration(
                      labelText: "اسم المنتج (بالعربية)",
                      prefixIcon: const Icon(Icons.text_fields),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                    ),
                    textDirection: TextDirection.rtl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "من فضلك أدخل الاسم بالعربية";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    controller: englishNameController,
                    decoration: InputDecoration(
                      labelText: "اسم المنتج (بالإنجليزية)",
                      prefixIcon: const Icon(Icons.text_fields),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "من فضلك أدخل الاسم بالإنجليزية";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: arabicDescController,
                    decoration: InputDecoration(
                      labelText: "الوصف (بالعربية)",
                      prefixIcon: const Icon(Icons.description),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                    ),
                    textDirection: TextDirection.rtl,
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "من فضلك أدخل الوصف بالعربية";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    controller: englishDescController,
                    decoration: InputDecoration(
                      labelText: "الوصف (بالإنجليزية)",
                      prefixIcon: const Icon(Icons.description),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                    ),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "من فضلك أدخل الوصف بالإنجليزية";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: priceController,
                    decoration: InputDecoration(
                      labelText: "السعر (جنيه مصري)",
                      prefixIcon: const Icon(Icons.attach_money),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "أدخل السعر";
                      }
                      if (double.tryParse(value) == null) {
                        return "قيمة غير صحيحة";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    controller: oldPriceController,
                    decoration: InputDecoration(
                      labelText: "السعر القديم (اختياري)",
                      prefixIcon: const Icon(Icons.money_off),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: weightController,
                    decoration: InputDecoration(
                      labelText: "الوزن (كجم)",
                      prefixIcon: const Icon(Icons.scale),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "أدخل الوزن";
                      }
                      if (int.tryParse(value) == null) {
                        return "قيمة غير صحيحة";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    controller: quantityController,
                    decoration: InputDecoration(
                      labelText: "الكمية المتاحة",
                      prefixIcon: const Icon(Icons.inventory),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "أدخل الكمية";
                      }
                      if (int.tryParse(value) == null) {
                        return "قيمة غير صحيحة";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<CategoryModel>(
                        value: selectedCategory,
                        decoration: InputDecoration(
                          labelText: "التصنيف",
                          prefixIcon: const Icon(Icons.category),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 12,
                          ),
                        ),
                        items: context.read<ProductCubit>().categoriesItems.map(
                              (category) {
                            return DropdownMenuItem<CategoryModel>(
                              value: category,
                              child: Text(
                                isRTL ? category.arabicName : category.englishName,
                                style: const TextStyle(fontSize: 16),
                              ),
                            );
                          },
                        ).toList(),
                        onChanged: onCategoryChanged,
                        validator: (value) {
                          if (value == null) {
                            return "اختر التصنيف";
                          }
                          return null;
                        },
                      ),
                    ),

                  ],
                ),
                const SizedBox(height: 20),
                SwitchListTile(
                  title: const Text(
                    "عرض المنتج",
                    style: TextStyle(fontSize: 16),
                  ),
                  value: isShow,
                  onChanged: onShowChanged,
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: isUploading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.save, size: 24),
                    SizedBox(width: 12),
                    Text(
                      "حفظ المنتج",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
