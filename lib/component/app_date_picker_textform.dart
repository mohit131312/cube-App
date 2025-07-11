import 'package:cube_app/component/app_text.dart';
import 'package:cube_app/utils/app_color.dart';
import 'package:cube_app/utils/app_fontsize.dart';
import 'package:cube_app/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDatePickerTextform extends StatelessWidget {
  final TextEditingController controller;
  final Function(DateTime) onDateSelected;
  final String? Function(String?)? validator;
  final String hintText;
  final bool readOnly;

  const AppDatePickerTextform({
    super.key,
    required this.controller,
    required this.onDateSelected,
    this.validator,
    this.hintText = "Select Date",
    this.readOnly = true,
  });

  void _showDatePicker(BuildContext context) {
    DateTime today = DateTime.now();
    DateTime selectedDate = today;

    showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: StatefulBuilder(builder: (context, setState) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: AppText(
                      text: 'Select Date',
                      fontSize: AppFontsize.textSizeMedium,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryText,
                    ),
                  ),
                  Container(
                    width: SizeConfig.widthMultiplier * 100,
                    height: SizeConfig.heightMultiplier * 0.1,
                    color: AppColors.secondaryText,
                  ),
                  SizedBox(
                    height: 150,
                    child: CupertinoTheme(
                      data: CupertinoThemeData(
                        textTheme: CupertinoTextThemeData(
                          dateTimePickerTextStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.buttoncolor,
                          ),
                        ),
                      ),
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: today,
                        onDateTimeChanged: (DateTime newDate) {
                          selectedDate = newDate;
                        },
                        itemExtent: 40.0,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: AppText(
                          text: 'Cancel',
                          fontSize: AppFontsize.textSizeSmallm,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryText,
                        ),
                      ),
                      const SizedBox(width: 50),
                      GestureDetector(
                        onTap: () {
                          onDateSelected(selectedDate);
                          Navigator.pop(context);
                        },
                        child: AppText(
                          text: 'Done',
                          fontSize: AppFontsize.textSizeSmallm,
                          fontWeight: FontWeight.w600,
                          color: AppColors.buttoncolor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: TextFormField(
        controller: controller,
        onTap: () => _showDatePicker(context),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: GoogleFonts.inter(
          fontSize: AppFontsize.textSizeSmall,
          fontWeight: FontWeight.w400,
          color: AppColors.primaryText,
        ),
        readOnly: readOnly,
        validator: validator,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: AppFontsize.textSizeSmall,
            fontWeight: FontWeight.w400,
            color: AppColors.searchfeild,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 13, horizontal: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: AppColors.primary,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: AppColors.primary,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 126, 16, 9),
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 126, 16, 9),
              width: 1,
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(11),
            child: GestureDetector(
              onTap: () => _showDatePicker(context),
              child: Image.asset(
                'assets/icons/calendar.png',
                height: 10,
                width: 10,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
