import 'package:flutter/material.dart';
import 'package:store_dash_board/core/utils/styles/app_styles.dart';
import 'package:store_dash_board/features/add_product/presentation/views/add_product_screen.dart';

import '../../../eidt_products/presentation/views/products.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'إدارة المنتجات',
          style: AppStyles.semiBold24(context).copyWith(
            color: Theme.of(context).textTheme.titleLarge!.color,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 600, // Suitable width for web
            maxHeight: 500,
          ),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'اختر إجراء',
                    style: AppStyles.semiBold24(context).copyWith(
                      fontSize: 28,
                      color: Theme.of(context).primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: _OptionCard(
                          title: 'إضافة منتج',
                          icon: Icons.add_circle_outline,
                          onTap: () {
                            // TODO: Navigate to Add Product screen
                             Navigator.push(context, MaterialPageRoute(builder: (context) => AddProductScreen()));
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _OptionCard(
                          title: 'تعديل المنتجات',
                          icon: Icons.edit_outlined,
                          onTap: () {
                            // TODO: Navigate to Edit Products screen
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsView()));
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OptionCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _OptionCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  _OptionCardState createState() => _OptionCardState();
}

class _OptionCardState extends State<_OptionCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: _isHovered
                ? [
              BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ]
                : [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 48,
                color: _isHovered
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).iconTheme.color,
              ),
              const SizedBox(height: 8),
              Text(
                widget.title,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: _isHovered
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).textTheme.titleLarge!.color,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}