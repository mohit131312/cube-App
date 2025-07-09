import 'dart:convert';
import 'dart:developer';

import 'package:cube_app/remote_service.dart';
import 'package:cube_app/utils/custome_popup.dart';
import 'package:cube_app/utils/validator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  var isPasswordVisible = false.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var emailFocusNode = FocusNode();
  var passwordFocusNode = FocusNode();

  void clearLoginfeild() {
    emailController.clear();
    passwordController.clear();
    isPasswordVisible.value = false;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  String? usernameValidator(String? value) {
    return Validator.validateEmail(value);
  }

  String? passwordValidator(String? value) {
    return Validator.validatePassword(value);
  }

  //----------------login------------------
  String validationmsg = '';
  bool logStatus = false;
  Future<void> login(email, pass) async {
    try {
      Map<String, dynamic> map = {
        "email": email,
        "password": pass,
        "FCM_token": "fabf21102951024b",
        "user_tye ": "1"
      };

      var response = await RemoteServices.postMethod('login', map);
      print("Status Code: ${response.statusCode}");
      print("Raw Response Body: ${response.body}");

      validationmsg = '';
      logStatus = false;
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);

        validationmsg = await responseData['message'] ?? "";
        logStatus = await responseData['status'] ?? false;
        if (!logStatus && validationmsg.isNotEmpty) {
          await showDialog(
            context: Get.context!,
            builder: (context) => CustomValidationPopup(
              message: validationmsg,
              icon: Icons.close,
              iconColor: Colors.red,
              buttonText: "Ok",
              onOk: () {
                print("Dialog closed");
              },
            ),
          );
        }
        var data = await responseData['data'];
        String token = await data["access_token"];
        String username = await data["user_name"];
        // String email = await data["email"];
        // String userrole = await data["user_role"];

        //---------------------------------------------------
        await RemoteServices.gs.write('token', token);
        await RemoteServices.gs.write('login', true);
        await RemoteServices.gs.write('user_name', username);
        // RemoteServices.gs.write('email', email);
        // RemoteServices.gs.write('userrole', userrole);
        log("token is ${RemoteServices.gs.read('token')}");
        log("login is ${RemoteServices.gs.read('login')}");
        log("username is ${RemoteServices.gs.read('user_name')}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
