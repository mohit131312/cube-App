import 'package:cube_app/component/app_text.dart';
import 'package:cube_app/cube_engineer/cube_casting_request/cube_casting_request_controller.dart';
import 'package:cube_app/cube_engineer/cube_casting_request/cube_casting_request_screen.dart';
import 'package:cube_app/cube_engineer/view_test_result/view_test_result_controller.dart';
import 'package:cube_app/cube_engineer/view_test_result/view_test_result_screen.dart';
import 'package:cube_app/cube_engineer/dashboard_home/dashboard_home_controller.dart';
import 'package:cube_app/utils/app_color.dart';
import 'package:cube_app/utils/app_const_text.dart';
import 'package:cube_app/utils/app_fontsize.dart';
import 'package:cube_app/utils/check_internet.dart';
import 'package:cube_app/utils/custome_popup.dart';
import 'package:cube_app/utils/loader_screen.dart';
import 'package:cube_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardHomeScreen extends StatelessWidget {
  final int projectId;
  final String projectName;
  final int buildingId;

  DashboardHomeScreen({
    super.key,
    required this.projectId,
    required this.projectName,
    required this.buildingId,
  });
  final DashboardHomeController dashboardHomeController =
      Get.put(DashboardHomeController());
  final ViewTestResultController viewTestResultController =
      Get.put(ViewTestResultController());
  final CubeCastingRequestController cubeCastingRequestController =
      Get.put(CubeCastingRequestController());
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
                text: AppConstText.cubeEngineer,
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
                itemCount: dashboardHomeController.selectGridData.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.92,
                ),
                itemBuilder: (context, index) {
                  final item = dashboardHomeController.selectGridData[index];
                  return GestureDetector(
                    onTap: () async {
                      if (index == 0) {
                        if (await CheckInternet.checkInternet()) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  CustomLoadingPopup());
                          await cubeCastingRequestController.resetAllData();
                          bool success = await cubeCastingRequestController
                              .getconcertingLevel(projectId, buildingId);
                          await cubeCastingRequestController.getElement();
                          await cubeCastingRequestController.getConcreteGrade();
                          Get.back();

                          if (success) {
                            Get.to(() => CubeCastingRequestScreen(
                                  projectId: projectId,
                                  projectName: projectName,
                                  buildingId: buildingId,
                                ));
                          }
                          print('Selected Project ID: $projectId');
                          print('Selected Project Name: $projectName');
                          print('Selected Building ID: $buildingId');
                        } else {
                          await showDialog(
                            context: Get.context!,
                            builder: (BuildContext context) {
                              return CustomValidationPopup(
                                  icon: Icons.info,
                                  iconColor: AppColors.buttoncolor,
                                  message:
                                      "Please check your internet connection.");
                            },
                          );
                        }
                      } else {
                        if (await CheckInternet.checkInternet()) {
                          viewTestResultController.resetData();
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  CustomLoadingPopup());
                          bool success = await viewTestResultController
                              .getviewTestResult('', buildingId);
                          Get.back();
                          if (success) {
                            Get.to(() => ViewTestResultScreen(
                                  projectId: projectId,
                                  projectName: projectName,
                                  buildingId: buildingId,
                                ));
                          }
                        } else {
                          await showDialog(
                            context: Get.context!,
                            builder: (BuildContext context) {
                              return CustomValidationPopup(
                                  icon: Icons.info,
                                  iconColor: AppColors.buttoncolor,
                                  message:
                                      "Please check your internet connection.");
                            },
                          );
                        }
                      }
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
                              blurRadius: 3,
                              spreadRadius: 0.1,
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
