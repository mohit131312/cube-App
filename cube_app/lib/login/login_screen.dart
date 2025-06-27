import 'package:cube_app/component/app_text.dart';
import 'package:cube_app/component/app_textformfeild_login.dart';
import 'package:cube_app/login/login_controller.dart';
import 'package:cube_app/select_role/select_role_screen.dart';
import 'package:cube_app/utils/app_color.dart';
import 'package:cube_app/utils/app_const_text.dart';
import 'package:cube_app/utils/app_elevated_button.dart';
import 'package:cube_app/utils/app_fontsize.dart';
import 'package:cube_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController loginController = Get.put(LoginController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.loginbackground,
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: SizeConfig.heightMultiplier * 35,
                child: Center(
                  child: Image.asset(
                    "assets/images/background.png",
                    fit: BoxFit.cover,
                    height: SizeConfig.heightMultiplier * 32,
                    width: SizeConfig.widthMultiplier * 90,
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  padding: EdgeInsets.only(
                    left: SizeConfig.widthMultiplier * 5,
                    right: SizeConfig.widthMultiplier * 5,
                    top: SizeConfig.heightMultiplier * 3,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: AppConstText.welcome,
                          fontSize: AppFontsize.textSizeMedium,
                          fontWeight: FontWeight.w600,
                          color: AppColors.secondary,
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier * 0.8),
                        AppText(
                          text: AppConstText.welcometext,
                          fontSize: AppFontsize.textSizeSmall,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryText,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier * 2),
                        Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                text: AppConstText.email,
                                fontSize: AppFontsize.textSizeSmalle,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryText,
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 1.2,
                              ),
                              AppTextFormfeildLogin(
                                controller: loginController.emailController,
                                hintText: 'Enter Username',
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                prefixIcon: const Icon(
                                  Icons.email_sharp,
                                  color: AppColors.secondaryText,
                                  size: 24.0,
                                ),
                                focusNode: loginController.emailFocusNode,
                                onFieldSubmitted: (_) {
                                  loginController.emailFocusNode.unfocus();
                                },
                                validator: loginController.usernameValidator,
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 1.5,
                              ),
                              AppText(
                                text: AppConstText.password,
                                fontSize: AppFontsize.textSizeSmalle,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryText,
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 1,
                              ),
                              Obx(
                                () => AppTextFormfeildLogin(
                                  controller:
                                      loginController.passwordController,
                                  hintText: 'Enter Password',
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: AppColors.secondaryText,
                                    size: 26.0,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      loginController.isPasswordVisible.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: AppColors.secondaryText,
                                    ),
                                    onPressed: () {
                                      loginController.isPasswordVisible.value =
                                          !loginController
                                              .isPasswordVisible.value;
                                    },
                                  ),
                                  focusNode: loginController.passwordFocusNode,
                                  onFieldSubmitted: (_) {
                                    loginController.passwordFocusNode.unfocus();
                                  },
                                  obscureText:
                                      !loginController.isPasswordVisible.value,
                                  validator: loginController.passwordValidator,
                                ),
                              ),
                              SizedBox(
                                  height: SizeConfig.heightMultiplier * 5.0),
                              AppElevatedButton(
                                text: 'Log In',
                                onPressed: () async {
                                  // if (formKey.currentState?.validate() ??
                                  //     false) {
                                  Get.to(() => SelectRoleScreen());
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text(
                                        "You have successfully logged in.",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: AppColors.buttoncolor,
                                      duration: const Duration(seconds: 5),
                                      margin: const EdgeInsets.all(12),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                  //}
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier * 8),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 1.5,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: SizeConfig.heightMultiplier * 2,
            left: SizeConfig.widthMultiplier * 14,
            right: SizeConfig.widthMultiplier * 14,
            child: Image.asset("assets/images/kumarname.png",
                fit: BoxFit.contain, height: SizeConfig.heightMultiplier * 10),
          ),
          Positioned(
            top: SizeConfig.heightMultiplier * 12,
            left: SizeConfig.widthMultiplier * 25,
            right: SizeConfig.widthMultiplier * 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                    text: "CUBE APP",
                    fontSize: AppFontsize.textSizeMediumm,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary),
              ],
            ),
          ),
          Positioned(
            top: SizeConfig.heightMultiplier * 18,
            left: SizeConfig.widthMultiplier * 10,
            right: SizeConfig.widthMultiplier * 10,
            child: Image.asset('assets/images/Group.png',
                fit: BoxFit.contain, height: SizeConfig.heightMultiplier * 20),
          ),
        ],
      ),
    );
  }
}
