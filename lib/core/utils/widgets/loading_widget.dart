import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget loadingWidget(BuildContext context) {
  return LoadingAnimationWidget.inkDrop(
    color:Theme.of(context).colorScheme.secondary,
    size: 50,
  );
}