import 'package:flutter/material.dart';
import 'package:cube_app/utils/app_color.dart';
import 'package:cube_app/utils/app_fontsize.dart';
import 'package:cube_app/utils/size_config.dart';
import 'package:cube_app/component/app_text.dart';

class AppBottomButton extends StatelessWidget {
  final String leftText;
  final String rightText;
  final VoidCallback onLeftTap;
  final VoidCallback onRightTap;

  const AppBottomButton({
    super.key,
    required this.leftText,
    required this.rightText,
    required this.onLeftTap,
    required this.onRightTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onLeftTap,
          child: Container(
            width: SizeConfig.widthMultiplier * 26,
            height: SizeConfig.heightMultiplier * 5.5,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: AppText(
                text: leftText,
                fontSize: AppFontsize.textSizeSmallm,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: onRightTap,
          child: Container(
            width: SizeConfig.widthMultiplier * 56,
            height: SizeConfig.heightMultiplier * 5.5,
            decoration: BoxDecoration(
              color: AppColors.buttoncolor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: AppText(
                text: rightText,
                fontSize: AppFontsize.textSizeSmallm,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
