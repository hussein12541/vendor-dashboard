import 'package:flutter/material.dart';

import '../../../../../core/utils/widgets/custom_text_field.dart';

class PasswordTextFormField extends StatelessWidget {
  const PasswordTextFormField({
    super.key,
    required this.passwordController,
  });

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      prefixIcon: Icons.lock_outline_rounded,
      hintText: "كلمة المرور",
      controller: passwordController,
      isPassword: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "ادخل كلمة المرور";
        }
        if (value.length < 6) {
          return "كلمة المرور يجب ان تكون على الاقل 6 حروف";

        }
        return null;
      },
    );
  }
}
