import 'package:cube_app/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showLoaderDialog() {
  Get.dialog(
    Center(
      child: Container(
        width: 100,
        height: 100,
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5),
            )
          ],
        ),
        child: const CircularProgressIndicator(
          color: AppColors.buttoncolor,
          strokeWidth: 5,
        ),
      ),
    ),
    barrierDismissible: false,
  );
}
