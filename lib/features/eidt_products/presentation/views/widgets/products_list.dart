import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../data/models/product/product_model.dart';
import '../../manger/product_cubit/product_cubit.dart';
import '../edit_product_screen.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [SliverList.separated(
        itemCount: products.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final product = products[index];
          // ... نفس الكود اللي عندك فوق
      // جوه itemBuilder
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: [
                // صورة المنتج
                Expanded(
                  flex: 1,
                  child: Text(
                    (index+1).toString(),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    product.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(Icons.image,size: 50,),
                  ),
                ),
                const SizedBox(width: 12),

                // الاسم
                Expanded(
                  flex: 3,
                  child: Text(
                    product.arabicName.isNotEmpty
                        ? product.arabicName
                        : product.englishName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

                // السعر + السعر القديم
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "\$${product.price.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      if (product.oldPrice > 0 && product.oldPrice > product.price)
                        Text(
                          "\$${product.oldPrice.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.red,
                          ),
                        ),
                    ],
                  ),
                ),

                // الكمية
                Expanded(
                  flex: 2,
                  child: Text('${product.quantity} pcs'),
                ),

                // مرات الشراء
                Expanded(
                  flex: 2,
                  child: Text('Sold: ${product.boughtTimes}'),
                ),

                // الحالة (isShow)
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: product.isShow ? Colors.green.shade50 : Colors.red.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: product.isShow ? Colors.green : Colors.red,
                          radius: 4,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          product.isShow ? 'Active' : 'Hidden',
                          style: TextStyle(
                            color: product.isShow ? Colors.green : Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 👇 هنا خانة الأكشنز
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.center,
                    child: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'edit') {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditProductScreen(product: product),));
                        } else if (value == 'delete') {
                          context.read<ProductCubit>().deleteProduct(product.id,product.deleteImageUrl);
                        } else if (value == 'reviews') {
                          // TODO: اعرض الريفيوهات

                        }else if (value == 'show') {
                          context.read<ProductCubit>().updateVisibility(product.id,product.isShow);

                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit, size: 18, color: Colors.blue),
                              SizedBox(width: 8),
                              Text('Edit'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, size: 18, color: Colors.red),
                              SizedBox(width: 8),
                              Text('Delete'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'reviews',
                          child: Row(
                            children: [
                              Icon(Icons.reviews, size: 18, color: Colors.orange),
                              SizedBox(width: 8),
                              Text('Reviews'),
                            ],
                          ),
                        ),  PopupMenuItem(
                          value: 'show',
                          child: Row(
                            children: [
                              Icon(product.isShow?Icons.visibility_off:Icons.remove_red_eye, size: 18, color: Colors.green),
                              const SizedBox(width: 8),
                              Text(product.isShow?'Hide':'Show',style: const TextStyle(color: Colors.green),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );

        },
      )],
    );
  }
}
