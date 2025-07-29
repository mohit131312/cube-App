import 'dart:convert';
import 'dart:developer';

import 'package:cube_app/cube_viewer/dashborad_cube_viewer/schedule_act_report/schedule_act_model.dart';
import 'package:cube_app/remote_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ScheduleActReportController extends GetxController {
  final TextEditingController dateController = TextEditingController();

  Future<void> updateDate(DateTime newDate) async {
    dateController.text = DateFormat("yyyy-MM-dd").format(newDate);
  }

  var isExpandedcasting = false.obs;
  var isExpandedbringing = false.obs;
  var isExpandedtestng = false.obs;

  void toggleCastingExpanded() {
    isExpandedcasting.toggle();
  }

  void toggleBringingExpanded() {
    isExpandedbringing.toggle();
  }

  void toggleTestingExpanded() {
    isExpandedtestng.toggle();
  }

  //----------------------------------------------------------

  RxList<CastingCubesSite> castingCubesSitesList = <CastingCubesSite>[].obs;
  RxList<CastingCubesSite> cubesFromSites = <CastingCubesSite>[].obs;
  RxList<TodaysTestingSchedule> cubeTestingSchedule =
      <TodaysTestingSchedule>[].obs;

  Future<bool> getcastingCubesAll(projectId,buildingId) async {
    try {
      Map<String, dynamic> map = {"project_id": projectId,"building_id":buildingId};

      var response = await RemoteServices.postMethodWithToken(
        'get_cube_report_viewer_data',
        map,
      );
      //   log("📥 Raw Response Body: ${response.body}");

      final responseData = await jsonDecode(response.body);

      if (responseData.containsKey('token') && responseData['token'] == false) {
        await RemoteServices.handleTokenExpiry();
        return false;
      }

      final project = scheduleActivityFromJson(response.body);

      log("project data ${project.data}");

      if (project.data != null) {
        castingCubesSitesList.assignAll(project.data!.castingCubesSites ?? []);
        cubesFromSites.assignAll(project.data!.cubesFromSites ?? []);
        cubeTestingSchedule
            .assignAll(project.data!.todaysTestingSchedule ?? []);

        print("✅ castingCubesSitesList Count: ${castingCubesSitesList.length}");
        print("✅ cubesFromSites Count: ${cubesFromSites.length}");
        print("✅ cubeTestingSchedule Count: ${cubeTestingSchedule.length}");
      } else {
        castingCubesSitesList.clear();
        cubesFromSites.clear();
        cubeTestingSchedule.clear();
        print("⚠️ No project data found.");
      }

      return true;
    } catch (e) {
      print("❌ Error: $e");
      return false;
    }
  }

  Future<bool> getcastingCubesAllByDate(date, projectId,buildingId) async {
    try {
      castingCubesSitesList.clear();
      cubesFromSites.clear();
      cubeTestingSchedule.clear();

      Map<String, dynamic> map = {
        "project_id": projectId,
        "report_date": date,
        "building_id":buildingId
      };

      var response = await RemoteServices.postMethodWithToken(
        'get_report_date',
        map,
      );
      //   log("📥 Raw Response Body: ${response.body}");

      final responseData = await jsonDecode(response.body);

      if (responseData.containsKey('token') && responseData['token'] == false) {
        await RemoteServices.handleTokenExpiry();
        return false;
      }

      final project = scheduleActivityFromJson(response.body);

      log("project data  from date ${project.data}");

      if (project.data != null) {
        castingCubesSitesList.assignAll(project.data!.castingCubesSites ?? []);
        cubesFromSites.assignAll(project.data!.cubesFromSites ?? []);
        cubeTestingSchedule
            .assignAll(project.data!.todaysTestingSchedule ?? []);

        print(
            "✅ castingCubesSitesList Count: from date ${castingCubesSitesList.length}");
        print("✅ cubesFromSites Count: from date${cubesFromSites.length}");
        print(
            "✅ cubeTestingSchedule Count:from date ${cubeTestingSchedule.length}");
      } else {
        castingCubesSitesList.clear();
        cubesFromSites.clear();
        cubeTestingSchedule.clear();
        print("⚠️ No project data found.");
      }

      return true;
    } catch (e) {
      print("❌ Error: $e");
      return false;
    }
  }
}
