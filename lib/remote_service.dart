import 'dart:convert';
import 'package:cube_app/login/login_screen.dart';
import 'package:cube_app/utils/custome_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  static final gs = GetStorage();

// Logout method to clear stored data
  static Future<void> logout() async {
    await gs.remove('login');
    await gs.remove('token');
    await gs.remove('user_name');
    await gs.erase();
  }

  static const String baseUrl =
      "http://192.168.1.72/Kumar/KumarProperties/api/v1/"; // WIFI
  // static const String baseUrl =
  //     "http://34.133.129.206/stagging/api/v1/"; //stagging

  static Map<String, String> getHeaders({bool includeAuth = true}) {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (includeAuth) {
      String token = gs.read('token') ?? '';
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  static Future<http.Response> fetchGetData(String url) async {
    print('$baseUrl$url');
    print('Token: ${gs.read('token')}');
    try {
      var response = await http.get(
        Uri.parse('$baseUrl$url'),
        headers: getHeaders(),
      );

      return response;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  static Future<http.Response> postMethod(
      String url, Map<String, dynamic> map) async {
    print('$baseUrl$url');
    print("Request body: ${jsonEncode(map)}");
    try {
      var response = await http.post(
        Uri.parse('$baseUrl$url'),
        headers:
            getHeaders(includeAuth: false), // No token for POST in some cases
        body: jsonEncode(map),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  static Future<http.Response> postMethodWithToken(
      String url, Map<String, dynamic> map) async {
    print('$baseUrl$url');
    print('Token: ${gs.read('token')}');
    print("Request body: ${jsonEncode(map)}");
    var header = {
      'Authorization': '${gs.read('token')}',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      var response = await http.post(
        Uri.parse('$baseUrl$url'),
        headers: header,
        body: jsonEncode(map),
      ); // Handle expired token

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  static Future<void> handleTokenExpiry() async {
    logout();

    Get.offAll(() => LoginScreen());
    await showDialog(
      context: Get.context!,
      builder: (context) => CustomValidationPopup(
        message:
            "Your session has expired or your account was logged in on another device.",
        icon: Icons.close,
        iconColor: Colors.red,
        buttonText: "Ok",
        onOk: () {
          print("Dialog closed");
        },
      ),
    );
  }
}
