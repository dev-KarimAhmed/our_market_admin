import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_market_admin/core/app_colors.dart';
import 'package:our_market_admin/core/components/custom_circle_indicator.dart';
import 'package:our_market_admin/core/components/custom_elevated_button.dart';
import 'package:our_market_admin/core/components/custom_text_field.dart';
import 'package:our_market_admin/core/functions/build_custom_app_bar.dart';
import 'package:our_market_admin/core/functions/navigate_without_back.dart';
import 'package:our_market_admin/core/functions/show_msg.dart';
import 'package:our_market_admin/features/home/views/home_view.dart';

import '../cubit/cubit/login_cubit.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            navigateWithoutBack(context, HomeView());
          }
          if (state is LoginError) {
            showMsg(context, state.msgError);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: buildCustomAppBar(context, "Login As An Admin",
                isBackButton: false),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: state is LoginLoading
                  ? const CustomCircleProgIndicator()
                  : Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomField(
                            labelText: "Email",
                            controller: emailController,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomField(
                            labelText: "Password",
                            controller: passwordController,
                            isPassword: true,
                            onPressed: () {},
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomElevatedButton(
                            child: const Text("Login"),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<LoginCubit>().login({
                                  "email": emailController.text,
                                  "password": passwordController.text
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
