import 'package:flutter/material.dart';

void showProductSortDialog(
    BuildContext context, String currentSort, ValueChanged<String> onSortChanged) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Sort Products'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<String>(
            title: const Text('Newest First'),
            value: 'date_desc',
            groupValue: currentSort,
            onChanged: (value) {
              onSortChanged(value!);
              Navigator.pop(context);
            },
          ),
          RadioListTile<String>(
            title: const Text('Oldest First'),
            value: 'date_asc',
            groupValue: currentSort,
            onChanged: (value) {
              onSortChanged(value!);
              Navigator.pop(context);
            },
          ),
          RadioListTile<String>(
            title: const Text('Price (High to Low)'),
            value: 'price_desc',
            groupValue: currentSort,
            onChanged: (value) {
              onSortChanged(value!);
              Navigator.pop(context);
            },
          ),
          RadioListTile<String>(
            title: const Text('Price (Low to High)'),
            value: 'price_asc',
            groupValue: currentSort,
            onChanged: (value) {
              onSortChanged(value!);
              Navigator.pop(context);
            },
          ),
          RadioListTile<String>(
            title: const Text('Most Bought'),
            value: 'bought_times',
            groupValue: currentSort,
            onChanged: (value) {
              onSortChanged(value!);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ],
    ),
  );
}
