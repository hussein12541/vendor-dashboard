import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.textInputType,
    this.isPassword = false,
    required this.controller,
    this.validator,
    this.onChange,  this.maxLines =1, this.prefixIcon,  this.readOnly = false, this.onSubmit,
  });

  final String hintText;
  final bool readOnly;

  final IconData? prefixIcon;
  final TextInputType? textInputType;
  final bool isPassword;
  final TextEditingController controller;
  final int maxLines;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChange;
  final ValueChanged<String>? onSubmit;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isShow = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return TextFormField(
      readOnly: widget.readOnly,

      maxLines: widget.maxLines,
      onChanged: widget.onChange,
      onFieldSubmitted: widget.onSubmit,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.isPassword ? isShow : false,
      keyboardType: widget.textInputType,
      style: TextStyle(color: widget.readOnly
        ? Colors.grey.shade500 :
      theme.textTheme.bodyLarge?.color),
      decoration: InputDecoration(
        prefixIcon:(widget.prefixIcon!=null)?Icon(widget.prefixIcon,color: Theme.of(context).colorScheme.secondary,):null,
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            isShow ? Icons.visibility : Icons.visibility_off,
            color: theme.iconTheme.color,
          ),
          onPressed: () {
            setState(() {
              isShow = !isShow;
            });
          },
        )
            : null,
        hintText: widget.hintText,
        hintStyle: TextStyle(color: theme.hintColor),
        filled: true,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
