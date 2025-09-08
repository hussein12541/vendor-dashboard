import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:store_dash_board/features/auth/presentation/views/widgets/login_body.dart';
import '../../../../core/utils/functions/show_message.dart';
import '../../../../core/utils/styles/app_styles.dart';
import '../../../../core/utils/widgets/loading_widget.dart';
import '../../../home/presentation/views/home_view.dart';
import '../../data/repos/auth_repo_impl.dart';
import '../manger/login_cubit/login_cubit.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(AuthRepoImpl()),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            // Uncomment and adjust navigation as needed
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeView()),
            );
          } else if (state is LoginError) {
            ShowMessage.showToast(state.errorMessage);
          }
        },
        builder: (context, state) {
          final isLoading = state is LoginLoading;

          return ModalProgressHUD(
            inAsyncCall: isLoading,
            dismissible: !isLoading,
            opacity: 0.5,
            color: Colors.black54,
            progressIndicator: loadingWidget(context),
            child: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 500, // Limit card width for web
                    maxHeight: 600,
                  ),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0), // Increased padding for web
                      child: SingleChildScrollView(
                        child: Form(
                          key: key,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Optional: Add a logo or header
                              Padding(
                                padding: const EdgeInsets.only(bottom: 24.0),
                                child: Text(
                                  'مرحبًا بك',
                                  style: AppStyles.semiBold24(context).copyWith(
                                    fontSize: 28,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                              LoginBody(
                                emailController: emailController,
                                passwordController: passwordController,
                                loginOnPressed: () async {
                                  if (key.currentState!.validate()) {
                                    await context.read<LoginCubit>().loginUser(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}