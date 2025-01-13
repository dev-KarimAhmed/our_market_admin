import 'package:flutter/material.dart';
import 'package:our_market_admin/core/app_colors.dart';

class CustomField extends StatelessWidget {
  const CustomField({
    super.key,
    this.controller,
    required this.labelText,
    this.isPassword = false, this.onPressed,
  });
  final String labelText;
  final TextEditingController? controller;
  final bool isPassword;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
        return null;
      },
      obscureText: isPassword,
      cursorColor: AppColors.kBordersideColor,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword
            ? IconButton(
                onPressed: onPressed,
                icon:  const Icon(Icons.remove_red_eye_outlined))
            : null,
        labelText: labelText,
        labelStyle: const TextStyle(color: AppColors.kBlackColor),
        border: OutlineInputBorder(
          borderSide:
              const BorderSide(color: AppColors.kBordersideColor, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: AppColors.kBordersideColor, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: AppColors.kBordersideColor, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
