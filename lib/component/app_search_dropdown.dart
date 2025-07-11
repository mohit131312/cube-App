import 'package:cube_app/utils/app_color.dart';
import 'package:cube_app/utils/app_fontsize.dart';
import 'package:cube_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'package:google_fonts/google_fonts.dart';

class AppSearchDropdown extends StatelessWidget {
  final List<String> items;
  final String? selectedItem;
  final String hintText;

  final ValueChanged<String?> onChanged;
  final bool enabled;
  final FormFieldValidator<String?>? validator;
  final AutovalidateMode autovalidateMode; // <-- Add this
  final double? popupMaxHeight; // <-- add this

  const AppSearchDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.selectedItem,
    this.hintText = 'Select an option',
    this.enabled = true,
    this.validator,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.popupMaxHeight,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !enabled,
      child: SizedBox(
        height: 46,
        child: DropdownSearch<String>(
          autoValidateMode: autovalidateMode,
          popupProps: PopupProps.menu(
            fit: FlexFit.loose,

            menuProps: MenuProps(
              barrierDismissible: true,
              barrierColor: Colors.transparent,
              backgroundColor: Colors.white,
              borderRadius: BorderRadius.circular(16),
              elevation: 8,
            ),
            scrollbarProps: ScrollbarProps(
              thumbVisibility: true,
              thickness: 3, // Sleeker, modern feel
              radius: const Radius.circular(8), // Smooth rounded edges
              trackVisibility: true,
              interactive: true,
              mainAxisMargin: 2,
              crossAxisMargin: 2,
              fadeDuration: const Duration(milliseconds: 200),
              timeToFade: const Duration(milliseconds: 800),
              thumbColor: AppColors.buttoncolor,
              trackColor: const Color.fromARGB(26, 101, 99, 99),
              trackBorderColor: Colors.transparent,
            ),

            // constraints: BoxConstraints(
            //   maxHeight: (items.length * 80).toDouble().clamp(140, 300),
            // ), //
            constraints: BoxConstraints(
              maxHeight: popupMaxHeight ??
                  // (items.length * 80).toDouble().clamp(140, 300),
                  SizeConfig.heightMultiplier * 32,
            ),
            searchDelay: Duration.zero,
            showSearchBox: true,
            itemBuilder: (context, item, isSelected) {
              return Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20, top: 5, bottom: 10),
                  child: Text(
                    item,
                    style: GoogleFonts.inter(
                      fontSize: AppFontsize.textSizeSmall,
                      fontWeight: FontWeight.w400,
                      color: AppColors
                          .primaryText, // Disable styling if applicable                ),
                    ),
                  ));
            },
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white, // ✅ Ensure background remains white
                hintText: 'Search...',
                hintStyle: GoogleFonts.inter(
                  fontSize: AppFontsize.textSizeSmall,
                  fontWeight: FontWeight.w400,
                  color: AppColors.searchfeild,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      BorderSide(color: AppColors.searchfeildcolor, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      BorderSide(color: AppColors.searchfeildcolor, width: 1),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 126, 16, 9),
                    width: 1,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 126, 16, 9),
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
          validator: validator,
          items: items,
          selectedItem: selectedItem,
          dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle: GoogleFonts.inter(
              fontSize: AppFontsize.textSizeSmall,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryText,
            ),
            dropdownSearchDecoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.inter(
                fontSize: AppFontsize.textSizeSmall,
                fontWeight: FontWeight.w400,
                color: AppColors.searchfeild,
              ),
              isDense: true, // ✅ Reduces vertical space

              filled: true,
              fillColor: Colors.white, // ✅ Ensure background remains white
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    BorderSide(color: AppColors.searchfeildcolor, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    BorderSide(color: AppColors.searchfeildcolor, width: 1),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: const Color.fromARGB(255, 126, 16, 9),
                  width: 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: const Color.fromARGB(255, 126, 16, 9),
                  width: 1,
                ),
              ),
            ),
          ),
          dropdownButtonProps: DropdownButtonProps(
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.searchfeild,
              size: 27,
            ),
          ),
          onChanged: enabled ? onChanged : null,
        ),
      ),
    );
  }
}
