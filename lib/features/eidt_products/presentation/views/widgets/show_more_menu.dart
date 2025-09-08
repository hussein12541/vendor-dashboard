import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manger/product_cubit/product_cubit.dart';

void showMoreMenuProducts(BuildContext context) {
  showMenu(
    context: context,
    position: const RelativeRect.fromLTRB(100, 100, 0, 0),
    items: [
      PopupMenuItem(
        value: 'refresh',
        child: const Text('Refresh Orders'),
        onTap: () {
          context.read<ProductCubit>().getProducts();
        },
      ),
    ],
  );
}