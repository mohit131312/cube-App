import 'package:cube_app/component/cube_test_result_prefill.dart';
import 'package:cube_app/cube_engineer/dashboard_card/view_test_result/card_details/view_Report_screen/view_report_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cube_app/component/app_text.dart';
import 'package:cube_app/cube_engineer/dashboard_card/view_test_result/card_details/card_details_controller.dart';
import 'package:cube_app/utils/app_color.dart';
import 'package:cube_app/utils/app_fontsize.dart';
import 'package:cube_app/utils/size_config.dart';

class ViewReportScreen extends StatelessWidget {
  final String projectName;

  ViewReportScreen({
    super.key,
    required this.projectName,
  });

  final ViewReportController viewReportController =
      Get.put(ViewReportController());
  final CardDetailsController cardDetailsController = Get.find();

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
          title: AppText(
            text: "View and Approve Test Result",
            fontSize: AppFontsize.textSizeMedium,
            fontWeight: FontWeight.w500,
            color: AppColors.primary,
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.heightMultiplier * 3),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cardDetailsController.viewDetailstestResult.length,
                  separatorBuilder: (_, __) => SizedBox(height: 24),
                  itemBuilder: (context, index) {
                    return CubeTestResultPrefill(
                      title: "${index + 1}",
                      lengthController:
                          viewReportController.lengthControllers[index],
                      lengthFocusNode:
                          viewReportController.lengthFocusNodes[index],
                      widthController:
                          viewReportController.widthControllers[index],
                      widthFocusNode:
                          viewReportController.widthFocusNodes[index],
                      heightController:
                          viewReportController.heightControllers[index],
                      heightFocusNode:
                          viewReportController.heightFocusNodes[index],
                      weightController:
                          viewReportController.weightControllers[index],
                      weightFocusNode:
                          viewReportController.weightFocusNodes[index],
                      loadController:
                          viewReportController.loadControllers[index],
                      loadFocusNode: viewReportController.loadFocusNodes[index],
                      csAreaController:
                          viewReportController.csAreaControllers[index],
                      csAreaFocusNode:
                          viewReportController.csAreaFocusNodes[index],
                      densityController:
                          viewReportController.densityControllers[index],
                      densityFocusNodes:
                          viewReportController.densityFocusNodes[index],
                      strengthControllers:
                          viewReportController.strengthControllers[index],
                      strengthFocusNodes:
                          viewReportController.strengthFocusNodes[index],
                    );
                  },
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
