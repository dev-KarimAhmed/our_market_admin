import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_market_admin/core/components/custom_circle_indicator.dart';
import 'package:our_market_admin/core/components/custom_elevated_button.dart';
import 'package:our_market_admin/core/components/custom_text_field.dart';
import 'package:our_market_admin/core/functions/build_custom_app_bar.dart';
import 'package:our_market_admin/core/functions/navigate_without_back.dart';
import 'package:our_market_admin/core/functions/show_msg.dart';
import 'package:our_market_admin/features/add_admin/cubit/cubit/add_admin_cubit.dart';
import 'package:our_market_admin/features/auth/view/login_view.dart';

class AddAdminView extends StatefulWidget {
  const AddAdminView({super.key});

  @override
  State<AddAdminView> createState() => _AddAdminViewState();
}

class _AddAdminViewState extends State<AddAdminView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, "Add Admin"),
      body: BlocProvider(
        create: (context) => AddAdminCubit(),
        child: BlocConsumer<AddAdminCubit, AddAdminState>(
          listener: (context, state) {
            if (state is AddAdminSuccess) {
              // navigateWithoutBack(context, const LoginView());
              print("Admin added successfully");
            }
            if (state is AddAdminError) {
              showMsg(context, state.message);
            }
          },
          builder: (context, state) {
            AddAdminCubit _cubit = AddAdminCubit();
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: state is AddAdminLoading
                  ? const CustomCircleProgIndicator()
                  : Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        CustomField(
                          labelText: "Email",
                          controller: _emailController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomField(
                          labelText: "Password",
                          isPassword: true,
                          controller: _passwordController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomElevatedButton(
                          child: const Text("Add"),
                          onPressed: () {
                            _cubit.createAnAccount({
                              "email": _emailController.text,
                              "password": _passwordController.text,
                            });
                          },
                        ),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}
