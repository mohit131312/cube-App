import 'package:cube_app/component/app_text.dart';
import 'package:cube_app/utils/app_color.dart';
import 'package:cube_app/utils/app_fontsize.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final String confirmText;
  final String cancelText;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
    this.onCancel,
    this.confirmText = 'Yes',
    this.cancelText = 'Cancel',
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: Colors.white,
      title: AppText(
        text: title,
        fontSize: AppFontsize.textSizeMediumm,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      content: AppText(
        text: message,
        fontSize: AppFontsize.textSizeSmall,
        fontWeight: FontWeight.w500,
        color: AppColors.searchfeild,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onCancel, // Let parent handle the close
              child: Container(
                alignment: Alignment.center,
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: AppText(
                  text: cancelText,
                  fontSize: AppFontsize.textSizeSmallm,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: onConfirm, // Let parent handle the close
              child: Container(
                alignment: Alignment.center,
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  color: AppColors.buttoncolor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: AppText(
                  text: confirmText,
                  fontSize: AppFontsize.textSizeSmallm,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
