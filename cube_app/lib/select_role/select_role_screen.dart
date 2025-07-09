import 'package:cube_app/component/app_text.dart';
import 'package:cube_app/cube_engineer/dashboard_card/dashboard_card_controller.dart';
import 'package:cube_app/cube_engineer/dashboard_card/dashboard_card_screen.dart';
import 'package:cube_app/cube_viewer/cube_Viewer_Screen.dart';
import 'package:cube_app/lab_operator/lab_operator_screen.dart';
import 'package:cube_app/login/login_screen.dart';
import 'package:cube_app/remote_service.dart';
import 'package:cube_app/select_role/select_role_controller.dart';
import 'package:cube_app/utils/app_color.dart';
import 'package:cube_app/utils/app_const_text.dart';
import 'package:cube_app/utils/app_fontsize.dart';
import 'package:cube_app/utils/custom_loader.dart';
import 'package:cube_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectRoleScreen extends StatelessWidget {
  SelectRoleScreen({super.key});
  final SelectRoleController selectRoleController =
      Get.put(SelectRoleController());
  final DashboardCardController dashboardCardController =
      Get.put(DashboardCardController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        backgroundColor: AppColors.primary,
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
            text: AppConstText.selectrole,
            fontSize: AppFontsize.textSizeMediumm,
            fontWeight: FontWeight.w400,
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
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: GestureDetector(
                  onTap: () async {
                    await RemoteServices.logout();

                    Get.offAll(() => LoginScreen());
                  },
                  child: Icon(
                    Icons.logout,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: SizeConfig.heightMultiplier * 5,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: selectRoleController.selectRoles.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      if (index == 0) {
                        Get.to(() => CubeViewerScreen());
                      } else if (index == 1) {
                        showLoaderDialog();
                        bool success =
                            await dashboardCardController.getassignProject();
                        Get.back();

                        if (success) {
                          Get.to(() => DashboardCardScreen());
                        }
                      } else if (index == 2) {
                        Get.to(() => LabOperatorScreen());
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 5.5,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 2,
                      ),
                      alignment: Alignment.center,
                      height: SizeConfig.heightMultiplier * 9,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              //    blurRadius: 10,
                              blurRadius: 3,
                              spreadRadius: 0.2,
                              // spreadRadius: 0.5,
                              offset: Offset(0, 0)),
                        ],
                      ),
                      child: ListTile(
                        leading: Image.asset(
                          'assets/icons/person_icon.png',
                          height: SizeConfig.imageSizeMultiplier * 7,
                          width: SizeConfig.imageSizeMultiplier * 7,
                        ),
                        title: AppText(
                          text: selectRoleController.selectRoles[index],
                          fontSize: AppFontsize.textSizeSmallm,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: SizeConfig.heightMultiplier * 2.5,
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
