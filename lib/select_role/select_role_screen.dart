import 'package:cube_app/component/app_text.dart';
import 'package:cube_app/component/shimmer_cards.dart';
import 'package:cube_app/cube_engineer/select_project_eng_controller.dart';
import 'package:cube_app/cube_engineer/select_project_eng.dart';
import 'package:cube_app/cube_viewer/select_project_controller_view.dart';
import 'package:cube_app/cube_viewer/select_project_view_screen.dart';
import 'package:cube_app/cube_lab_operator/select_project_opt_controller.dart';
import 'package:cube_app/cube_lab_operator/select_project_opt_screen.dart';
import 'package:cube_app/login/login_screen.dart';
import 'package:cube_app/remote_service.dart';
import 'package:cube_app/select_role/profile_screen.dart';
import 'package:cube_app/select_role/select_role_controller.dart';
import 'package:cube_app/utils/app_color.dart';
import 'package:cube_app/utils/app_const_text.dart';
import 'package:cube_app/utils/app_fontsize.dart';
import 'package:cube_app/utils/check_internet.dart';
import 'package:cube_app/utils/custome_popup.dart';
import 'package:cube_app/utils/loader_screen.dart';
import 'package:cube_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectRoleScreen extends StatelessWidget {
  SelectRoleScreen({super.key});
  final SelectRoleController selectRoleController =
      Get.put(SelectRoleController());
  final SelectProjectEngController selectProjectEngController =
      Get.put(SelectProjectEngController());
  final SelectProjectControllerView selectProjectControllerView =
      Get.put(SelectProjectControllerView());
  final SelectProjectOptController selectProjectOptController =
      Get.put(SelectProjectOptController());
  Future<bool> showConfirmationDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (
        BuildContext context,
      ) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: Colors.white,
          title: AppText(
            text: 'Are You Sure?',
            fontSize: AppFontsize.textSizeMediumm,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          content: AppText(
              text: 'Are you sure you want to Logout',
              fontSize: AppFontsize.textSizeSmall,
              fontWeight: FontWeight.w500,
              color: AppColors.searchfeild),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: AppText(
                        text: 'Cancel',
                        fontSize: AppFontsize.textSizeSmallm,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context).pop(true);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        color: AppColors.buttoncolor,
                        borderRadius: BorderRadius.circular(12)),
                    child: AppText(
                        text: 'Yes',
                        fontSize: AppFontsize.textSizeSmallm,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                )
              ],
            )
          ],
        );
      },
    );
    return result ?? false;
  }

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
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () async {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          centerTitle: true,
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
          // actions: [
          //   Padding(
          //     padding: EdgeInsets.only(right: 10),
          //     child: GestureDetector(
          //         onTap: () async {
          //           bool res = await showConfirmationDialog(context);
          //           if (res) {
          //             await RemoteServices.logout();

          //             Get.offAll(() => LoginScreen());
          //           }
          //         },
          //         child: Icon(
          //           Icons.logout,
          //           color: Colors.white,
          //         )),
          //   ),
          // ],
        ),
        drawer: Drawer(
          width: SizeConfig.widthMultiplier * 60,
          backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColors.buttoncolor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/images/app_icon.png"),
                      radius: 30,
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 2),
                    Obx(
                      () => AppText(
                        text:
                            '${selectRoleController.userProfile['first_name']} ${selectRoleController.userProfile['last_name']}',
                        fontSize: AppFontsize.textSizeMedium,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 0.5),
                    Obx(
                      () => AppText(
                        text: '${selectRoleController.userProfile['email']} ',
                        fontSize: AppFontsize.textSizeSmall,
                        fontWeight: FontWeight.w400,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 36,
              ),
              ListTile(
                leading:
                    Icon(Icons.person, size: 32, color: AppColors.primaryText),
                title: AppText(
                  text: 'Profile',
                  fontSize: AppFontsize.textSizeMediumm,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryText,
                ),
                onTap: () {
                  Get.to(() => ProfileScreen());
                },
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                leading:
                    Icon(Icons.logout, size: 32, color: AppColors.primaryText),
                title: AppText(
                  text: 'Logout',
                  fontSize: AppFontsize.textSizeMediumm,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryText,
                ),
                onTap: () async {
                  //Navigator.pop(context);
                  bool res = await showConfirmationDialog(context);
                  if (res) {
                    await RemoteServices.logout();
                    Get.offAll(() => LoginScreen());
                  }
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: SizeConfig.heightMultiplier * 5,
              ),
              Obx(
                () {
                  if (selectRoleController.isLoading.value) {
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 3, // shimmer item count
                      itemBuilder: (_, __) => shimmerCard(),
                      separatorBuilder: (_, __) => SizedBox(
                        height: SizeConfig.heightMultiplier * 2.5,
                      ),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: selectRoleController.selectRoles.length,
                    itemBuilder: (context, index) {
                      var role = selectRoleController.selectRoles[index];
                      var roleId = role.roleId;
                      return GestureDetector(
                        onTap: () async {
                                  if ([12, 20, 44].contains(roleId)) {

                            if (await CheckInternet.checkInternet()) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CustomLoadingPopup());
                              bool success = await selectProjectOptController
                                  .getassignProject(roleId);
                              Get.back();

                              if (success) {
                                Get.to(() => SelectProjectOptScreen());
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
                            // Get.to(() => LabOperatorScreen());
                          } else if ([13, 21, 45].contains(roleId)) {

                            if (await CheckInternet.checkInternet()) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CustomLoadingPopup());
                              bool success = await selectProjectEngController
                                  .getassignProject(roleId);
                              Get.back();

                              if (success) {
                                Get.to(() => SelectProjectEng());
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
                          }  else if ([14, 22, 46].contains(roleId)) {
                            if (await CheckInternet.checkInternet()) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CustomLoadingPopup());
                              bool success = await selectProjectControllerView
                                  .getassignProject(roleId);
                              Get.back();

                              if (success) {
                                //  Get.to(() => CubeViewerScreen());
                                Get.to(() => SelectProjectViewScreen());
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
                                  blurRadius: 2,
                                  spreadRadius: 0.1,
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
                              text: selectRoleController
                                      .selectRoles[index].roleName?.roleName ??
                                  "",
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
