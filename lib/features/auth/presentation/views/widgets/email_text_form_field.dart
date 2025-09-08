import 'package:flutter/material.dart';

import '../../../../../core/utils/widgets/custom_text_field.dart';

class EmailTextFormField extends StatelessWidget {
  const EmailTextFormField({
    super.key,
    required this.emailController,
  });

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      prefixIcon: Icons.email_outlined,
      hintText: "البريد الالكتروني",
      controller: emailController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "ادخل البريد الالكتروني";
        }
        if (!RegExp(
          r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
        ).hasMatch(value)) {
          return "ادخل بريد الكتروني صحيح";
        }
        return null;
      },
    );
  }
}
