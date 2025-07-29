import 'package:cube_app/component/app_text.dart';
import 'package:cube_app/select_role/select_role_controller.dart';
import 'package:cube_app/utils/app_color.dart';
import 'package:cube_app/utils/app_fontsize.dart';
import 'package:cube_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final SelectRoleController selectRoleController = Get.find();

  @override
  Widget build(BuildContext context) {
    final profile = selectRoleController.userProfile;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, size: 32, color: Colors.white),
            onPressed: () {
              Get.back();
            },
          ),
          centerTitle: true,
          backgroundColor: AppColors.buttoncolor,
          elevation: 0,
          toolbarHeight: SizeConfig.heightMultiplier * 10,
          title: AppText(
            text: "Profile Details",
            fontSize: AppFontsize.textSizeMediumm,
            fontWeight: FontWeight.w400,
            color: AppColors.primary,
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            CircleAvatar(
              backgroundImage: AssetImage("assets/images/app_icon.png"),
              radius: 40,
              backgroundColor: Colors.white,
            ),
            SizedBox(height: 1 * SizeConfig.heightMultiplier),
            AppText(
              text: '${profile["first_name"]} ${profile["last_name"]}',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Container(
                width: 100 * SizeConfig.widthMultiplier,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft:
                        Radius.circular(5 * SizeConfig.imageSizeMultiplier),
                    topRight:
                        Radius.circular(5 * SizeConfig.imageSizeMultiplier),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, -2),
                    )
                  ],
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Padding(
                  padding: EdgeInsets.all(6 * SizeConfig.widthMultiplier),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 1 * SizeConfig.heightMultiplier),

                      /// Email
                      AppText(
                        text: "Email ID :",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryText,
                      ),

                      SizedBox(height: 0.6 * SizeConfig.heightMultiplier),
                      AppText(
                        text: profile["email"],
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.buttoncolor,
                      ),

                      SizedBox(height: 3 * SizeConfig.heightMultiplier),

                      AppText(
                        text: "Mobile No :",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryText,
                      ),

                      SizedBox(height: 0.6 * SizeConfig.heightMultiplier),
                      AppText(
                        text: profile["mobile_number"],
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.buttoncolor,
                      ),
                      SizedBox(height: 3 * SizeConfig.heightMultiplier),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget profileItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "$label:  ",
              style: TextStyle(
                color: Colors.black,
                fontSize: AppFontsize.textSizeMedium,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: ' $value',
              style: TextStyle(
                color: Colors.black87,
                fontSize: AppFontsize.textSizeMedium,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
