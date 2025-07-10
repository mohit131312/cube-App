import 'package:cube_app/component/app_text.dart';
import 'package:cube_app/cube_lab_operator/dashboard_lab_operator/dashboard_lab_operator_screen.dart';
import 'package:cube_app/cube_lab_operator/select_project_opt_controller.dart';
import 'package:cube_app/utils/app_color.dart';
import 'package:cube_app/utils/app_const_text.dart';
import 'package:cube_app/utils/app_fontsize.dart';
import 'package:cube_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectProjectOptScreen extends StatelessWidget {
  SelectProjectOptScreen({super.key});

  final SelectProjectOptController selectProjectOptController = Get.find();

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
                text: "Cube Lab Operator",
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
            children: [
              SizedBox(
                height: SizeConfig.heightMultiplier * 5,
              ),
              Obx(
                () {
                  if (selectProjectOptController.assignProject.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 50),
                        child: AppText(
                          text: 'No assigned projects found.',
                          fontSize: AppFontsize.textSizeSmall,
                          color: AppColors.secondaryText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: selectProjectOptController.assignProject.length,
                    itemBuilder: (context, index) {
                      final selectedProject =
                          selectProjectOptController.assignProject[index];

                      return GestureDetector(
                        onTap: () {
                          final projectId = selectedProject.projectId;
                          final projectName = selectedProject.projectName;

                          print('Selected Project ID: $projectId');
                          print('Selected Project Name: $projectName');

                          Get.to(() => DashboardLabOperatorScreen(
                                projectId: projectId!,
                                projectName: projectName!,
                              ));
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: SizeConfig.widthMultiplier * 5.5,
                          ),
                          padding: EdgeInsets.only(
                            right: SizeConfig.widthMultiplier * 2,
                          ),
                          alignment: Alignment.center,
                          height: SizeConfig.heightMultiplier * 9.5,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                index % 2 == 0
                                    ? AppColors.buttoncolor
                                    : AppColors.cardgreyColor,
                                Colors.white,
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              stops: [0.04, 0.04],
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  // blurRadius: 6,
                                  // spreadRadius: 0,
                                  blurRadius: 3,
                                  spreadRadius: 0.2,
                                  offset: Offset(0, 0)),
                            ],
                          ),
                          child: ListTile(
                            title: Padding(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.widthMultiplier * 4),
                              child: AppText(
                                text: selectProjectOptController
                                    .assignProject[index].projectName!,
                                fontSize: AppFontsize.textSizeSmallm,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryText,
                              ),
                            ),
                            subtitle: Padding(
                              padding: EdgeInsets.only(
                                left: SizeConfig.widthMultiplier * 4,
                                top: 2,
                              ),
                              child: AppText(
                                text: selectProjectOptController
                                    .assignProject[index].buildingName!,
                                fontSize: AppFontsize.textSizeSmall,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryText,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: SizeConfig.heightMultiplier * 2.3,
                      );
                    },
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
