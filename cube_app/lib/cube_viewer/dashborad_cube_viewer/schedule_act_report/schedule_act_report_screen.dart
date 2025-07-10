import 'package:cube_app/component/app_datepicker_border.dart';
import 'package:cube_app/component/app_text.dart';
import 'package:cube_app/cube_viewer/dashborad_cube_viewer/schedule_act_report/schedule_act_report_controller.dart';

import 'package:cube_app/utils/app_color.dart';
import 'package:cube_app/utils/app_const_text.dart';
import 'package:cube_app/utils/app_fontsize.dart';
import 'package:cube_app/utils/check_internet.dart';
import 'package:cube_app/utils/custome_popup.dart';
import 'package:cube_app/utils/date_format.dart';
import 'package:cube_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScheduleActReportScreen extends StatelessWidget {
  final int projectId;
  final String projectName;
  final int buildingId;

  ScheduleActReportScreen({
    super.key,
    required this.projectId,
    required this.projectName,
    required this.buildingId,
  });
  ScheduleActReportController scheduleActReportController = Get.find();
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          toolbarHeight: SizeConfig.heightMultiplier * 10,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: AppConstText.scheduleactreport,
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: AppConstText.activityDate,
                      fontSize: AppFontsize.textSizeSmall,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textcolorgrey,
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
                        child: AppDatepickerBorder(
                          controller:
                              scheduleActReportController.dateController,
                          onDateSelected: (date) async {
                            await scheduleActReportController.updateDate(date);

                            if (await CheckInternet.checkInternet()) {
                              await scheduleActReportController
                                  .getcastingCubesAllByDate(
                                scheduleActReportController.dateController.text,
                                projectId,
                              );
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
              SizedBox(
                height: SizeConfig.heightMultiplier * 3,
              ),
              Obx(
                () => scheduleActReportController.isExpandedcasting.value
                    ? Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 5,
                          vertical: SizeConfig.heightMultiplier * 1,
                        ),
                        width: SizeConfig.widthMultiplier * 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          color: Color(0xFFFEFEFE),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 10,
                                spreadRadius: 0.5,
                                offset: Offset(0, 0)),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: AppText(
                                    text: AppConstText.castingofcubes,
                                    fontSize: AppFontsize.textSizeSmall,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryText,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    scheduleActReportController
                                        .isExpandedcasting
                                        .toggle();
                                  },
                                  icon: Icon(
                                    scheduleActReportController
                                            .isExpandedcasting.value
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    size: 28,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24),
                                ),
                              ),
                              child: scheduleActReportController
                                      .castingCubesSitesList.isEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Center(
                                        child: AppText(
                                          text: "No data available",
                                          fontSize: AppFontsize.textSizeSmall,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                  : ListView.separated(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: scheduleActReportController
                                          .castingCubesSitesList.length,
                                      itemBuilder: (context, index) {
                                        final cubessites =
                                            scheduleActReportController
                                                .castingCubesSitesList[index];

                                        return GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.only(
                                              right:
                                                  SizeConfig.widthMultiplier *
                                                      2,
                                            ),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  AppColors.buttoncolor,
                                                  Colors.white,
                                                ],
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                stops: [0.04, 0.04],
                                              ),
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.15),
                                                    blurRadius: 6,
                                                    spreadRadius: 0,
                                                    offset: Offset(0, 0)),
                                              ],
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left:
                                                    SizeConfig.widthMultiplier *
                                                        7,
                                                top: 15,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: SizeConfig
                                                            .widthMultiplier *
                                                        38,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        labelValue(
                                                            "Project Name",
                                                            cubessites
                                                                .projectName),
                                                        labelValue(
                                                            "Building Name",
                                                            cubessites
                                                                .buildingName),
                                                        labelValue(
                                                            "Element",
                                                            cubessites
                                                                .elementName),
                                                        labelValue(
                                                            "Cubic Meter",
                                                            cubessites
                                                                .cubicMeters
                                                                .toString()),
                                                        labelValue(
                                                            "No Of Cube",
                                                            cubessites
                                                                .requiredCubes
                                                                .toString()),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: SizeConfig
                                                            .widthMultiplier *
                                                        2,
                                                  ),
                                                  SizedBox(
                                                    width: SizeConfig
                                                            .widthMultiplier *
                                                        38,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        labelValue(
                                                            "Project Location",
                                                            cubessites
                                                                .projectLocation),
                                                        labelValue(
                                                            "Level",
                                                            cubessites
                                                                .levelOfConcreting
                                                                .toString()),
                                                        labelValue(
                                                            "Date Of Casting",
                                                            formatDate(cubessites
                                                                .proposedDateCasting)),
                                                        labelValue("Batch No",
                                                            cubessites.batchNo),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return SizedBox(
                                          height:
                                              SizeConfig.heightMultiplier * 3,
                                        );
                                      },
                                    ),
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 1,
                            ),
                          ],
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 5,
                          vertical: SizeConfig.heightMultiplier * 1,
                        ),
                        width: SizeConfig.widthMultiplier * 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          color: Color(0xFFFEFEFE),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 10,
                                spreadRadius: 0.5,
                                offset: Offset(0, 0)),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: AppText(
                                    text: AppConstText.castingofcubes,
                                    fontSize: AppFontsize.textSizeSmall,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryText,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    scheduleActReportController
                                        .isExpandedcasting
                                        .toggle();
                                  },
                                  icon: Icon(
                                    scheduleActReportController
                                            .isExpandedcasting.value
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    size: 28,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
              ),
              Obx(
                () => scheduleActReportController.isExpandedbringing.value
                    ? Container(
                        padding: EdgeInsets.only(
                          left: SizeConfig.widthMultiplier * 5,
                          right: SizeConfig.widthMultiplier * 5,
                          top: SizeConfig.heightMultiplier * 2,
                        ),
                        width: SizeConfig.widthMultiplier * 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          color: Color(0xFFFEFEFE),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 10,
                                spreadRadius: 0.5,
                                offset: Offset(0, 0)),
                          ],
                        ),
                        child: Column(
                          children: [
                            // SizedBox(
                            //   height: 20,
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: AppText(
                                    text: AppConstText.bringingofcubes,
                                    fontSize: AppFontsize.textSizeSmall,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryText,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    scheduleActReportController
                                        .isExpandedbringing
                                        .toggle();
                                  },
                                  icon: Icon(
                                    scheduleActReportController
                                            .isExpandedcasting.value
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    size: 28,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24),
                                ),
                              ),
                              child: scheduleActReportController
                                      .cubesFromSites.isEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Center(
                                        child: AppText(
                                          text: "No data available",
                                          fontSize: AppFontsize.textSizeSmall,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                  : ListView.separated(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: scheduleActReportController
                                          .cubesFromSites.length,
                                      itemBuilder: (context, index) {
                                        final cubefromsites =
                                            scheduleActReportController
                                                .cubesFromSites[index];

                                        return GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.only(
                                              right:
                                                  SizeConfig.widthMultiplier *
                                                      2,
                                            ),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  AppColors.buttoncolor,
                                                  Colors.white,
                                                ],
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                stops: [0.04, 0.04],
                                              ),
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.15),
                                                    blurRadius: 6,
                                                    spreadRadius: 0,
                                                    offset: Offset(0, 0)),
                                              ],
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left:
                                                    SizeConfig.widthMultiplier *
                                                        7,
                                                top: 15,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: SizeConfig
                                                            .widthMultiplier *
                                                        38,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        labelValue(
                                                            "Project Name",
                                                            cubefromsites
                                                                .projectName),
                                                        labelValue(
                                                            "Building Name",
                                                            cubefromsites
                                                                .buildingName),
                                                        labelValue(
                                                            "Element",
                                                            cubefromsites
                                                                .elementName),
                                                        labelValue(
                                                            "Cubic Meter",
                                                            cubefromsites
                                                                .cubicMeters
                                                                .toString()),
                                                        labelValue(
                                                            "No Of Cube",
                                                            cubefromsites
                                                                .requiredCubes
                                                                .toString()),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: SizeConfig
                                                            .widthMultiplier *
                                                        2,
                                                  ),
                                                  SizedBox(
                                                    width: SizeConfig
                                                            .widthMultiplier *
                                                        38,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        labelValue(
                                                            "Project Location",
                                                            cubefromsites
                                                                .projectLocation),
                                                        labelValue(
                                                            "Level",
                                                            cubefromsites
                                                                .levelOfConcreting
                                                                .toString()),
                                                        labelValue(
                                                            "Date Of Casting",
                                                            formatDate(cubefromsites
                                                                .proposedDateCasting)),
                                                        labelValue(
                                                            "Batch No",
                                                            cubefromsites
                                                                .batchNo),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return SizedBox(
                                          height:
                                              SizeConfig.heightMultiplier * 3,
                                        );
                                      },
                                    ),
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 2,
                            ),
                          ],
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.only(
                          left: SizeConfig.widthMultiplier * 5,
                          right: SizeConfig.widthMultiplier * 5,
                          top: SizeConfig.heightMultiplier * 2,
                        ),
                        width: SizeConfig.widthMultiplier * 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          color: Color(0xFFFEFEFE),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 10,
                                spreadRadius: 0.5,
                                offset: Offset(0, 0)),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: AppText(
                                    text: AppConstText.bringingofcubes,
                                    fontSize: AppFontsize.textSizeSmall,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryText,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    scheduleActReportController
                                        .isExpandedbringing
                                        .toggle();
                                  },
                                  icon: Icon(
                                    scheduleActReportController
                                            .isExpandedbringing.value
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    size: 28,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
              ),
              Obx(
                () => scheduleActReportController.isExpandedtestng.value
                    ? Container(
                        padding: EdgeInsets.only(
                          left: SizeConfig.widthMultiplier * 5,
                          right: SizeConfig.widthMultiplier * 5,
                          top: SizeConfig.heightMultiplier * 2,
                        ),
                        width: SizeConfig.widthMultiplier * 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          color: Color(0xFFFEFEFE),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 10,
                                spreadRadius: 0.5,
                                offset: Offset(0, 0)),
                          ],
                        ),
                        child: Column(
                          children: [
                            // SizedBox(
                            //   height: 20,
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: AppText(
                                    text: AppConstText.testingofcubes,
                                    fontSize: AppFontsize.textSizeSmall,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryText,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    scheduleActReportController.isExpandedtestng
                                        .toggle();
                                  },
                                  icon: Icon(
                                    scheduleActReportController
                                            .isExpandedcasting.value
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    size: 28,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24),
                                ),
                              ),
                              child: scheduleActReportController
                                      .cubeTestingSchedule.isEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0),
                                      child: Center(
                                        child: AppText(
                                          text: "No data available",
                                          fontSize: AppFontsize.textSizeSmall,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                  : ListView.separated(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: scheduleActReportController
                                          .cubeTestingSchedule.length,
                                      itemBuilder: (context, index) {
                                        final testsched =
                                            scheduleActReportController
                                                .cubeTestingSchedule[index];

                                        return GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.only(
                                              right:
                                                  SizeConfig.widthMultiplier *
                                                      2,
                                            ),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  AppColors.buttoncolor,
                                                  Colors.white,
                                                ],
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                stops: [0.04, 0.04],
                                              ),
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.15),
                                                    blurRadius: 6,
                                                    spreadRadius: 0,
                                                    offset: Offset(0, 0)),
                                              ],
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left:
                                                    SizeConfig.widthMultiplier *
                                                        7,
                                                top: 15,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: SizeConfig
                                                            .widthMultiplier *
                                                        38,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        labelValue("Batch No",
                                                            testsched.batchNo),
                                                        labelValue(
                                                            "No Of Cube",
                                                            testsched
                                                                .requiredCubes
                                                                .toString()),
                                                        labelValue(
                                                          "Date Of Testing",
                                                          formatDate(testsched
                                                              .testingDate),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: SizeConfig
                                                            .widthMultiplier *
                                                        2,
                                                  ),
                                                  SizedBox(
                                                    width: SizeConfig
                                                            .widthMultiplier *
                                                        38,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        labelValue(
                                                            "Grade Of Concrete",
                                                            testsched
                                                                .gradeName),
                                                        labelValue(
                                                            "Date Of Casting",
                                                            formatDate(testsched
                                                                .proposedDateCasting)),
                                                        labelValue(
                                                          "Age (Days)",
                                                          testsched.days
                                                              .toString(),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return SizedBox(
                                          height:
                                              SizeConfig.heightMultiplier * 3,
                                        );
                                      },
                                    ),
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 2,
                            ),
                          ],
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.only(
                          left: SizeConfig.widthMultiplier * 5,
                          right: SizeConfig.widthMultiplier * 5,
                          top: SizeConfig.heightMultiplier * 2,
                        ),
                        width: SizeConfig.widthMultiplier * 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          color: Color(0xFFFEFEFE),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 10,
                                spreadRadius: 0.5,
                                offset: Offset(0, 0)),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: AppText(
                                    text: AppConstText.testingofcubes,
                                    fontSize: AppFontsize.textSizeSmall,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryText,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    scheduleActReportController.isExpandedtestng
                                        .toggle();
                                  },
                                  icon: Icon(
                                    scheduleActReportController
                                            .isExpandedtestng.value
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    size: 28,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget labelValue(String label, String? value) {
    return Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: label,
            fontSize: AppFontsize.textSizeExtraSmall,
            fontWeight: FontWeight.w500,
            color: AppColors.textcolorgrey,
          ),
          AppText(
            text: value?.isNotEmpty == true ? value! : "-",
            fontSize: AppFontsize.textSizeSmalle,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryText,
          ),
        ],
      ),
    );
  }
}
