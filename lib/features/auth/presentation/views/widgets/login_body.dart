import 'package:flutter/material.dart';
import 'package:store_dash_board/features/auth/presentation/views/widgets/password_text_form_field.dart';
import '../../../../../core/utils/widgets/custom_button.dart';
import 'email_text_form_field.dart';
class LoginBody extends StatelessWidget {
  const LoginBody({
    super.key,
    required this.emailController,
    required this.passwordController, required this.loginOnPressed,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
final void Function() loginOnPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16),
      child: Column(
        children: [

          EmailTextFormField(emailController: emailController),
          const SizedBox(height: 16),
          PasswordTextFormField(passwordController: passwordController),
          const SizedBox(height: 25),
          CustomButton(onPressed: loginOnPressed, text: "تسجيل الدخول"),
          const SizedBox(height: 20),

        ],
      ),
    );
  }
}


