import 'package:cube_app/component/app_text.dart';
import 'package:cube_app/cube_lab_operator/dashboard_lab_operator/enter_test_result/enter_test_result_screen.dart';

import 'package:cube_app/cube_lab_operator/dashboard_lab_operator/dashboard_lab_operator_controller.dart';
import 'package:cube_app/utils/app_color.dart';
import 'package:cube_app/utils/app_const_text.dart';
import 'package:cube_app/utils/app_fontsize.dart';
import 'package:cube_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardLabOperatorScreen extends StatelessWidget {
  final int projectId;
  final String projectName;

  DashboardLabOperatorScreen({
    super.key,
    required this.projectId,
    required this.projectName,
  });
  final DashboardLabOperatorController dashboardLabOperatorController =
      Get.put(DashboardLabOperatorController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          scrolledUnderElevation: 0.0,
          elevation: 0,
          backgroundColor: AppColors.buttoncolor,
          foregroundColor: AppColors.buttoncolor,
          toolbarHeight: SizeConfig.heightMultiplier * 10,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: AppConstText.dashboard,
                fontSize: AppFontsize.textSizeMedium,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 0.7,
              ),
              AppText(
                text: AppConstText.labopertaor,
                fontSize: AppFontsize.textSizeSmall,
                fontWeight: FontWeight.w400,
                color: AppColors.primary,
              ),
            ],
          ),
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 5, top: 12, bottom: 12),
              child: Image.asset(
                'assets/icons/forward_Arrow.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: SizeConfig.heightMultiplier * 5,
              ),
              GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dashboardLabOperatorController.selectGridData.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.92,
                ),
                itemBuilder: (context, index) {
                  final item =
                      dashboardLabOperatorController.selectGridData[index];
                  return GestureDetector(
                    onTap: () {
                      // if (index == 0) {
                      Get.to(() => EnterTestResultScreen());
                      // } else {
                      //   Get.to(() => ViewTestResultScreen());
                      // }
                    },
                    child: Container(
                      height: SizeConfig.heightMultiplier * 20,
                      width: SizeConfig.widthMultiplier * 40,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.cardgreyColor,
                          width: 1.2,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 6,
                              spreadRadius: 1,
                              offset: Offset(0, 0)),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            item['img']!,
                            height: 56,
                            width: 56,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: SizeConfig.heightMultiplier * 2),
                          AppText(
                            text: item['text']!,
                            fontSize: AppFontsize.textSizeSmall,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryText,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
