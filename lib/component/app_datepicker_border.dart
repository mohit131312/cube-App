import 'package:cube_app/component/app_text.dart';
import 'package:cube_app/utils/app_color.dart';
import 'package:cube_app/utils/app_fontsize.dart';
import 'package:cube_app/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDatepickerBorder extends StatelessWidget {
  final TextEditingController controller;
  final Function(DateTime) onDateSelected;
  final String? Function(String?)? validator;
  final String hintText;
  final bool readOnly;

  const AppDatepickerBorder({
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
                    height: 120,
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
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
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
                      SizedBox(width: SizeConfig.widthMultiplier * 10),
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
                      SizedBox(width: SizeConfig.widthMultiplier * 10),
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
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: AppFontsize.textSizeSmall,
            fontWeight: FontWeight.w400,
            color: AppColors.searchfeild,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
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
        readOnly: readOnly,
        validator: validator,
      ),
    );
  }
}
