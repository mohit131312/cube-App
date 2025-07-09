import 'package:cube_app/component/app_datepicker.dart';
import 'package:cube_app/component/app_text.dart';
import 'package:cube_app/cube_engineer/dashboard_card/view_test_result/card_details/card_details_screen.dart';
import 'package:cube_app/cube_engineer/dashboard_card/view_test_result/view_test_result_controller.dart';

import 'package:cube_app/utils/app_color.dart';
import 'package:cube_app/utils/app_const_text.dart';
import 'package:cube_app/utils/app_fontsize.dart';
import 'package:cube_app/utils/custom_loader.dart';
import 'package:cube_app/utils/date_format.dart';
import 'package:cube_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'card_details/card_details_controller.dart';

class ViewTestResultScreen extends StatelessWidget {
  final int projectId;
  final String projectName;
  final int buildingId;

  ViewTestResultScreen({
    super.key,
    required this.projectId,
    required this.projectName,
    required this.buildingId,
  });
  ViewTestResultController viewTestResultController = Get.find();
  CardDetailsController cardDetailsController =
      Get.put(CardDetailsController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          elevation: 0,
          backgroundColor: AppColors.buttoncolor,
          foregroundColor: AppColors.buttoncolor,
          toolbarHeight: SizeConfig.heightMultiplier * 10,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: AppConstText.viewTestResult,
                fontSize: AppFontsize.textSizeMedium,
                fontWeight: FontWeight.w500,
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
        body: Stack(
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
                    SizedBox(height: SizeConfig.heightMultiplier * 3),
                    AppText(
                      text: AppConstText.dateOfCasting,
                      fontSize: AppFontsize.textSizeSmall,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primary,
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 1),
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.primary,
                            width: 1,
                          ),
                        ),
                        child: AppDatepicker(
                          controller: viewTestResultController.dateController,
                          onDateSelected: (date) async {
                            await viewTestResultController.updateDate(date);
                            showLoaderDialog();
                            await viewTestResultController.getviewTestResult(
                                viewTestResultController.dateController.text,
                                buildingId);
                            Get.back();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a date';
                            }
                            return null;
                          },
                        )),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              top: SizeConfig.heightMultiplier * 17,
              child: Container(
                padding: EdgeInsets.only(
                    top: SizeConfig.heightMultiplier * 2,
                    bottom: SizeConfig.heightMultiplier * 0.5),
                width: SizeConfig.widthMultiplier * 100,
                height: SizeConfig.heightMultiplier * 64,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Obx(
                  () {
                    if (viewTestResultController.viewtestResult.isEmpty) {
                      return Center(
                        child: AppText(
                          text: 'No View Test Result Available',
                          fontSize: AppFontsize.textSizeMedium,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textcolorgrey,
                        ),
                      );
                    }
                    return ListView.separated(
                      itemCount: viewTestResultController.viewtestResult.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            showLoaderDialog();
                            bool success = await cardDetailsController
                                .getviewTestDetailsResult(
                                    viewTestResultController
                                        .viewtestResult[index].id!);
                            Get.back();
                            if (success) {
                              Get.to(() => CardDetailsScreen(
                                    projectName: projectName,
                                    cardResult: viewTestResultController
                                        .viewtestResult[index],
                                  ));
                            }
                          },
                          child: Container(
                              // height: SizeConfig.heightMultiplier * 20,
                              margin: EdgeInsets.symmetric(
                                horizontal: SizeConfig.widthMultiplier * 5.5,
                              ),
                              padding: EdgeInsets.only(
                                right: SizeConfig.widthMultiplier * 2,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    _getStatusColor(
                                      viewTestResultController
                                          .viewtestResult[index].status!,
                                    ),
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
                                      blurRadius: 6,
                                      spreadRadius: 0,
                                      offset: Offset(0, 0)),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: SizeConfig.widthMultiplier * 7,
                                  top: 10,
                                  bottom: 10,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: SizeConfig.widthMultiplier * 48,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppText(
                                            text: "Project Name",
                                            fontSize:
                                                AppFontsize.textSizeExtraSmall,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.textcolorgrey,
                                          ),
                                          AppText(
                                            text: projectName,
                                            fontSize:
                                                AppFontsize.textSizeSmalle,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.primaryText,
                                          ),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 1,
                                          ),
                                          AppText(
                                            text: 'Batch No',
                                            fontSize:
                                                AppFontsize.textSizeExtraSmall,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.textcolorgrey,
                                          ),
                                          AppText(
                                            text: viewTestResultController
                                                    .viewtestResult[index]
                                                    .batchNo ??
                                                "",
                                            fontSize:
                                                AppFontsize.textSizeSmalle,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.primaryText,
                                          ),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 1,
                                          ),
                                          AppText(
                                            text: 'Status',
                                            fontSize:
                                                AppFontsize.textSizeExtraSmall,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.textcolorgrey,
                                          ),
                                          AppText(
                                            text: _getStatusLabel(
                                              viewTestResultController
                                                  .viewtestResult[index]
                                                  .status!,
                                            ),
                                            fontSize:
                                                AppFontsize.textSizeSmalle,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.primaryText,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: SizeConfig.widthMultiplier * 4,
                                    ),
                                    SizedBox(
                                      width: SizeConfig.widthMultiplier * 27,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppText(
                                            text: 'Date of Casting',
                                            fontSize:
                                                AppFontsize.textSizeExtraSmall,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.textcolorgrey,
                                          ),
                                          AppText(
                                            text: formatDate(
                                                viewTestResultController
                                                    .viewtestResult[index]
                                                    .proposedDateCasting),
                                            fontSize:
                                                AppFontsize.textSizeSmalle,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.primaryText,
                                          ),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 1,
                                          ),
                                          AppText(
                                            text: 'Date of Testing',
                                            fontSize:
                                                AppFontsize.textSizeExtraSmall,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.textcolorgrey,
                                          ),
                                          AppText(
                                            text: formatDate(
                                                viewTestResultController
                                                    .viewtestResult[index]
                                                    .testingDate),
                                            fontSize:
                                                AppFontsize.textSizeSmalle,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.primaryText,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(int status) {
    switch (status) {
      case 6:
        return AppColors.greenColor; // Approved
      case 7:
        return const Color.fromARGB(255, 176, 46, 37); // Denied
      case 5:
      default:
        return AppColors.cardgreyColor; // Pending or unknown
    }
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
