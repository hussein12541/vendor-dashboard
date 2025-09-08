import 'package:flutter/material.dart';

class ProductHeader extends StatelessWidget {
  const ProductHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.09),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      child: const Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'No.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded( flex :2,child: SizedBox(width: 140,)),


          Expanded(
            flex: 2,
            child: Text(
              'item',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
           Expanded( flex :8,child: SizedBox(width: 140,)),

          Expanded(
            flex:4,
            child: Text(
              'Price',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded( flex :2,child: SizedBox(width: 140,)),

          Expanded(
            flex: 4,
            child: Text(
              'Stock',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded( flex :2,child: SizedBox()),

          Expanded(
            flex: 4,
            child: Text(
              'Sold',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded( flex :3,child: SizedBox()),

          Expanded(
            flex: 4,
            child: Text(
              'Status',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded( flex :1,child: SizedBox()),

          Expanded(
            flex: 4,
            child: Text(
              'Actions',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded( flex :2,child: SizedBox()),

        ],
      ),
    );
  }
}
