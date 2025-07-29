import 'package:cube_app/utils/app_color.dart';
import 'package:cube_app/utils/app_fontsize.dart';
import 'package:cube_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppSearchDropdownDisable extends StatelessWidget {
  final List<String> items;
  final String? selectedItem;
  final String hintText;
  final ValueChanged<String?> onChanged;
  final bool enabled;
  final FormFieldValidator<String?>? validator;
  final AutovalidateMode autovalidateMode;
  final double? popupMaxHeight;
  final Set<String>? disabledItems;

  const AppSearchDropdownDisable({
    super.key,
    required this.items,
    required this.onChanged,
    this.selectedItem,
    this.hintText = 'Select an option',
    this.enabled = true,
    this.validator,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.popupMaxHeight,
    this.disabledItems,
  });

  @override
  Widget build(BuildContext context) {
    final isDropdownEnabled = enabled && items.isNotEmpty;

    return DropdownButtonFormField<String>(
      value: (selectedItem != null &&
              items.where((e) => e == selectedItem).length == 1)
          ? selectedItem
          : null,
      autovalidateMode: autovalidateMode,
      validator: validator,
      hint: Text(
        hintText,
        style: TextStyle(
          fontSize: AppFontsize.textSizeSmall,
          fontWeight: FontWeight.w400,
          color: AppColors.searchfeild,
        ),
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.searchfeildcolor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.searchfeildcolor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color.fromARGB(255, 126, 16, 9)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color.fromARGB(255, 126, 16, 9)),
        ),
      ),
      style: GoogleFonts.inter(
        fontSize: AppFontsize.textSizeSmall,
        fontWeight: FontWeight.w400,
        color: AppColors.primaryText,
      ),
      icon: Icon(Icons.keyboard_arrow_down, color: AppColors.searchfeild),
      onChanged: isDropdownEnabled
          ? (value) {
              if (value == null) return;
              final isDisabled = disabledItems?.contains(value) ?? false;
              if (!isDisabled) onChanged(value);
            }
          : null,
      items: items.isEmpty
          ? [
              DropdownMenuItem<String>(
                value: null,
                enabled: false,
                child: Text(
                  'No date available',
                  style: GoogleFonts.inter(
                    fontSize: AppFontsize.textSizeSmall,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ),
            ]
          : items.map((item) {
              final isDisabled = disabledItems?.contains(item) ?? false;
              return DropdownMenuItem<String>(
                value: item,
                enabled: !isDisabled,
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                  color: isDisabled ? Colors.grey.shade200 : null,
                  child: Text(
                    item,
                    style: GoogleFonts.inter(
                      fontSize: AppFontsize.textSizeSmall,
                      fontWeight: FontWeight.w400,
                      color: isDisabled ? Colors.grey : AppColors.primaryText,
                    ),
                  ),
                ),
              );
            }).toList(),
      dropdownColor: Colors.white,
      menuMaxHeight: popupMaxHeight ?? SizeConfig.heightMultiplier * 32,
    );
  }
}
