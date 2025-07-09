import 'dart:convert';
import 'dart:developer';

import 'package:cube_app/cube_engineer/dashboard_card/view_test_result/view_test_result_model.dart';
import 'package:cube_app/remote_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ViewTestResultController extends GetxController {
  final TextEditingController dateController = TextEditingController();

  Future<void> updateDate(DateTime newDate) async {
    dateController.text = DateFormat("yyyy-MM-dd").format(newDate);
  }

  RxList<CardResult> viewtestResult = <CardResult>[].obs;

  Future getviewTestResult(castingDate, buildingId) async {
    viewtestResult.clear();
    try {
      Map<String, dynamic> map = {
        "proposed_casting_date": castingDate,
        "building_id": buildingId
      };

      var response = await RemoteServices.postMethodWithToken(
          'view_cube_test_result', map);
      log("📥 Raw Response: $response");
      final responseData = jsonDecode(response.body);

      if (responseData.containsKey('token') && responseData['token'] == false) {
        await RemoteServices.handleTokenExpiry();
        return false;
      }
      var project = viewTestModelFromJson(response.body);

      if (project.data != null) {
        viewtestResult.assignAll(project.data!);
        print("viewtestResult Count: ${viewtestResult.length}");
      } else {
        viewtestResult.clear();
        print("No project data found.");
      }
      print('viewtestResult Count: ${viewtestResult.length}');
      return true;
    } catch (e) {
      print("Error: $e");
      return true;
    }
  }

  //--------------------
  void resetData() {
    // Clear the date input
    dateController.clear();

    // Clear the result list
    viewtestResult.clear();

    // Optional log
    log('🔄 ViewTestResultController reset completed');
  }
}
