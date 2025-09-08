import 'package:flutter/material.dart';

void showProductsFilterDialog(
    BuildContext context, bool? currentFilter, ValueChanged<bool?> onFilterChanged) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Filter Products'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<bool?>(
            title: const Text('All'),
            value: null,
            groupValue: currentFilter,
            onChanged: (value) {
              onFilterChanged(value);
              Navigator.pop(context);
            },
          ),
          RadioListTile<bool?>(
            title: const Text('Visible Products'),
            value: true,
            groupValue: currentFilter,
            onChanged: (value) {
              onFilterChanged(value);
              Navigator.pop(context);
            },
          ),
          RadioListTile<bool?>(
            title: const Text('Hidden Products'),
            value: false,
            groupValue: currentFilter,
            onChanged: (value) {
              onFilterChanged(value);
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
