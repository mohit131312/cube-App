import 'package:cube_app/utils/app_color.dart';
import 'package:cube_app/utils/app_fontsize.dart';
import 'package:flutter/material.dart';

class AppTextFormfeildLogin extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final bool enabled;
  final bool readOnly;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;
  final bool obscureText;
  final void Function(String)? onFieldSubmitted;

  const AppTextFormfeildLogin(
      {super.key,
      required this.controller,
      required this.hintText,
      this.keyboardType = TextInputType.text,
      this.textInputAction = TextInputAction.done,
      this.validator,
      this.obscureText = false,
      this.enabled = true,
      this.readOnly = false,
      this.suffixIcon,
      this.prefixIcon,
      this.onChanged,
      this.focusNode,
      this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      validator: validator,
      readOnly: readOnly,
      onChanged: onChanged,
      obscureText: obscureText,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 14,
        ),
        filled: true,
        fillColor: AppColors.textfeildcolor,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: AppFontsize.textSizeSmall,
          fontWeight: FontWeight.w500,
          color: AppColors.secondaryText,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.searchfeildcolor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.searchfeildcolor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.searchfeildcolor,
            width: 1,
          ),
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
    );
  }
}
