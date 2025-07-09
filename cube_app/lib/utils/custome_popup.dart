import 'package:flutter/material.dart';
import 'package:cube_app/utils/app_color.dart';
import 'package:cube_app/utils/size_config.dart';

class CustomValidationPopup extends StatelessWidget {
  final String message;
  final String buttonText;
  final double? dialogWidth;
  final IconData icon;
  final Color iconColor;
  final TextStyle? messageStyle;
  final VoidCallback? onOk;

  const CustomValidationPopup({
    super.key,
    required this.message,
    this.buttonText = "OK",
    this.dialogWidth,
    this.icon = Icons.info,
    this.iconColor = const Color(0xFF1976D2),
    this.messageStyle,
    this.onOk,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize SizeConfig
    SizeConfig.init(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4 * SizeConfig.widthMultiplier),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        width: 100,
        padding: EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 15,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color.fromARGB(59, 202, 199, 199),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Icon(
                icon,
                size: 30,
                color: iconColor,
              ),
            ),
            SizedBox(height: 20),
            Text(
              message,
              textAlign: TextAlign.center,
              style: messageStyle ??
                  TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.buttoncolor,
                  ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (onOk != null) onOk!();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttoncolor,
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
