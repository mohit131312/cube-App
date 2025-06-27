import 'package:cube_app/utils/validator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  // var email = ''.obs;
  // var password = ''.obs;
  var isPasswordVisible = false.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var emailFocusNode = FocusNode();
  var passwordFocusNode = FocusNode();

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
}
