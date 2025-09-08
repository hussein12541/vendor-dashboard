import 'package:flutter/material.dart';

import '../styles/app_styles.dart';


class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onPressed, required this.text,  this.height=54,  this.backgroundColor });
  final VoidCallback onPressed;
  final String text;
  final Color? backgroundColor;
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor??Theme.of(context).colorScheme.secondary,
          shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(
              16,
            ),
          ),
        ),
        onPressed: onPressed,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            style:AppStyles.semiBold18(context).copyWith(color: Colors.white)
          ),
        ),
      ),
    );
  }
}