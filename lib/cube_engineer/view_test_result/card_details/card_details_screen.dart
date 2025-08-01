import 'package:cube_app/component/app_text.dart';
import 'package:cube_app/component/view_report_button.dart';
import 'package:cube_app/cube_engineer/view_test_result/card_details/card_details_controller.dart';
import 'package:cube_app/cube_engineer/view_test_result/card_details/view_Report_screen/view_report_screen.dart';
import 'package:cube_app/cube_engineer/view_test_result/view_test_result_controller.dart';
import 'package:cube_app/cube_engineer/view_test_result/view_test_result_model.dart';

import 'package:cube_app/utils/app_color.dart';
import 'package:cube_app/utils/app_const_text.dart';
import 'package:cube_app/utils/app_fontsize.dart';
import 'package:cube_app/utils/date_format.dart';
import 'package:cube_app/utils/size_config.dart';
import 'package:cube_app/utils/text_null_isempty.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardDetailsScreen extends StatelessWidget {
  final String projectName;
  final CardResult cardResult;
  CardDetailsScreen(
      {super.key, required this.projectName, required this.cardResult});

  ViewTestResultController viewTestResultController = Get.find();
  CardDetailsController cardDetailsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          elevation: 0,
          backgroundColor: AppColors.buttoncolor,
          foregroundColor: AppColors.buttoncolor,
          toolbarHeight: SizeConfig.heightMultiplier * 8,
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
        body: Obx(() {
          if (cardDetailsController.viewDetailstestResult.isEmpty) {
            return Center(
              child: AppText(
                text: 'No Data Found',
                fontSize: AppFontsize.textSizeMedium,
                fontWeight: FontWeight.w600,
                color: AppColors.textcolorgrey,
              ),
            );
          }
          return Stack(
            children: [
              Container(
                width: SizeConfig.widthMultiplier * 100,
                height: SizeConfig.heightMultiplier * 100,
                decoration: BoxDecoration(
                  color: AppColors.buttoncolor,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 1,
                  color: Colors.white,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: SizeConfig.heightMultiplier * 2),
                      AppText(
                        text: AppConstText.projectName,
                        fontSize: AppFontsize.textSizeSmall,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primary,
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 0.3),
                      AppText(
                        text: projectName,
                        fontSize: AppFontsize.textSizeSmall,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1.6),
                      AppText(
                        text: AppConstText.dateOfCasting,
                        fontSize: AppFontsize.textSizeSmall,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primary,
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 0.3),
                      AppText(
                        text: formatDate(cardResult.proposedDateCasting),
                        fontSize: AppFontsize.textSizeSmall,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                top: SizeConfig.heightMultiplier * 18,
                child: Container(
                    padding: EdgeInsets.only(
                        top: SizeConfig.heightMultiplier * 2,
                        bottom: SizeConfig.heightMultiplier * 0.5,
                        left: SizeConfig.widthMultiplier * 6,
                        right: SizeConfig.widthMultiplier * 4),
                    width: SizeConfig.widthMultiplier * 100,
                    //    height: SizeConfig.heightMultiplier * 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 47,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: SizeConfig.heightMultiplier * 2),
                              AppText(
                                text: "Batch No",
                                fontSize: AppFontsize.textSizeSmalle,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textcolorgrey,
                              ),
                              SizedBox(
                                  height: SizeConfig.heightMultiplier * 0.3),
                              AppText(
                                text: formatOrNA(cardResult.batchNo),
                                fontSize: AppFontsize.textSizeSmalle,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryText,
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier * 3),
                              AppText(
                                text: "Date of Testing",
                                fontSize: AppFontsize.textSizeSmalle,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textcolorgrey,
                              ),
                              SizedBox(
                                  height: SizeConfig.heightMultiplier * 0.3),
                              AppText(
                                text: formatDate(cardResult.testingDate),
                                fontSize: AppFontsize.textSizeSmalle,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryText,
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier * 3),
                              AppText(
                                text: "Lab Address",
                                fontSize: AppFontsize.textSizeSmalle,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textcolorgrey,
                              ),
                              SizedBox(
                                  height: SizeConfig.heightMultiplier * 0.3),
                              AppText(
                                text: formatOrNA(cardResult.labAddress),
                                fontSize: AppFontsize.textSizeSmalle,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryText,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 5,
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 35,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: SizeConfig.heightMultiplier * 2),
                              AppText(
                                text: "Age(Days)",
                                fontSize: AppFontsize.textSizeSmalle,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textcolorgrey,
                              ),
                              SizedBox(
                                  height: SizeConfig.heightMultiplier * 0.3),
                              AppText(
                                text: formatOrNA(cardResult.age.toString()),
                                fontSize: AppFontsize.textSizeSmalle,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryText,
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier * 3),
                              AppText(
                                text: "Scheduled Dated",
                                fontSize: AppFontsize.textSizeSmalle,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textcolorgrey,
                              ),
                              SizedBox(
                                  height: SizeConfig.heightMultiplier * 0.3),
                              AppText(
                                text: formatDate(cardResult.scheduleDate),
                                fontSize: AppFontsize.textSizeSmalle,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryText,
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier * 3),
                              AppText(
                                text: "Status",
                                fontSize: AppFontsize.textSizeSmalle,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textcolorgrey,
                              ),
                              SizedBox(
                                  height: SizeConfig.heightMultiplier * 0.3),
                              AppText(
                                text: _getStatusLabel(
                                  cardResult.status!,
                                ),
                                fontSize: AppFontsize.textSizeSmalle,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryText,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          );
        }),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
            vertical: SizeConfig.heightMultiplier * 1,
            horizontal: SizeConfig.widthMultiplier * 4,
          ),
          child: ViewReportButton(
            label: "View Report",
            iconPath: "assets/icons/document.png",
            onTap: () {
              Get.to(() => ViewReportScreen(projectName: projectName));
            },
          ),
        ),
      ),
    );
  }

  String _getStatusLabel(int status) {
    switch (status) {
      case 5:
        return 'Pending';
      case 6:
        return 'Approved';
      case 7:
        return 'Denied';
      default:
        return 'Unknown';
    }
  }
}
