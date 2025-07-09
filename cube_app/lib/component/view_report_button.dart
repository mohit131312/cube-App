import 'package:flutter/material.dart';
import 'package:cube_app/component/app_text.dart';
import 'package:cube_app/utils/app_color.dart';
import 'package:cube_app/utils/app_fontsize.dart';
import 'package:cube_app/utils/size_config.dart';

class ViewReportButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final String iconPath;
  final double height;
  final double width;
  final Color borderColor;
  final Color backgroundColor;
  final Color textColor;

  const ViewReportButton({
    super.key,
    required this.label,
    required this.onTap,
    required this.iconPath,
    this.height = 48,
    this.width = 80, // percentage of widthMultiplier
    this.borderColor = AppColors.buttoncolor,
    this.backgroundColor = Colors.white,
    this.textColor = AppColors.buttoncolor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: SizeConfig.widthMultiplier * width,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(width: 1, color: borderColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              height: 24,
              width: 24,
            ),
            const SizedBox(width: 10),
            AppText(
              text: label,
              fontSize: AppFontsize.textSizeSmallm,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ],
        ),
      ),
    );
  }
}
