import 'package:cube_app/utils/app_color.dart';
import 'package:cube_app/utils/app_fontsize.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';

class AppTextFormfeild extends StatelessWidget {
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
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onFieldSubmitted;
  final Color fillColor;
  const AppTextFormfeild({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.validator,
    this.enabled = true,
    this.readOnly = false,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.focusNode,
    this.inputFormatters, // 👈 Initialize inputFormatters

    this.onFieldSubmitted,
    this.fillColor = Colors.white, // 👈 Set default color
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !enabled,
      child: TextFormField(
        controller: controller,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        validator: validator,
        readOnly: readOnly,
        onChanged: onChanged,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        style: GoogleFonts.inter(
          fontSize: AppFontsize.textSizeSmall,
          fontWeight: FontWeight.w400,
          color: AppColors.primaryText,
        ),
        inputFormatters: inputFormatters, // 👈 Apply formatters

        autovalidateMode:
            AutovalidateMode.onUserInteraction, // 👈 Add this line

        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.inter(
            fontSize: AppFontsize.textSizeSmall,
            fontWeight: FontWeight.w400,
            color: AppColors.searchfeild,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 13, horizontal: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.searchfeildcolor, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.searchfeildcolor, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: const Color.fromARGB(255, 126, 16, 9),
              width: 1,
            ),
          ),
          filled: true,
          fillColor: fillColor, // 👈 Use the parameter here
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: const Color.fromARGB(255, 126, 16, 9),
              width: 1,
            ),
          ),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }
}
