import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/category/category_model.dart';
import '../../../data/models/store/store_model.dart';
import '../../manger/add_product_cubit/cubit/add_product_cubit.dart';

class FormFieldsSection extends StatelessWidget {
  final TextEditingController arabicNameController;
  final TextEditingController englishNameController;
  final TextEditingController arabicDescController;
  final TextEditingController englishDescController;
  final TextEditingController priceController;
  final TextEditingController oldPriceController;
  final TextEditingController weightController;
  final TextEditingController quantityController;
  final CategoryModel? selectedCategory;
  final bool isShow;
  final bool isUploading;
  final ValueChanged<CategoryModel?> onCategoryChanged;
  final ValueChanged<bool> onShowChanged;
  final VoidCallback onSave;

  const FormFieldsSection({
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
    required this.isShow,
    required this.isUploading,
    required this.onCategoryChanged,
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
                      labelText: "اسم المنتج بالعربي",
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
                        return "من فضلك أدخل اسم المنتج بالعربي";
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
                      labelText: "اسم المنتج بالإنجليزية",
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
                        return "من فضلك أدخل اسم المنتج بالإنجليزية";
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
                      labelText: "الوصف بالعربي",
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
                        return "من فضلك أدخل الوصف بالعربي";
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
                      labelText: "الوصف بالإنجليزية",
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
                      labelText: "السعر (جنيه)",
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
                        return "من فضلك أدخل السعر";
                      }
                      if (double.tryParse(value) == null) {
                        return "قيمة غير صالحة";
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
                        return "من فضلك أدخل الوزن";
                      }
                      if (int.tryParse(value) == null) {
                        return "قيمة غير صالحة";
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
                        return "من فضلك أدخل الكمية";
                      }
                      if (int.tryParse(value) == null) {
                        return "قيمة غير صالحة";
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
                        items: context.read<AddProductCubit>().categoriesItems.map(
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
                    const SizedBox(width: 20),
                  ],
                ),
                const SizedBox(height: 20),
                SwitchListTile(
                  title: const Text(
                    "إظهار المنتج",
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
