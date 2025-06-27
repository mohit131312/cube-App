import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ScheduleActReportController extends GetxController {
  final TextEditingController dateController = TextEditingController();

  void updateDate(DateTime newDate) {
    dateController.text = DateFormat("yyyy-MM-dd").format(newDate);
  }

  final List testResults = [
    {
      "projectName": "Kumar Parc Residencies",
      "projectLocation": "Magarpatta",
      "buildingName": "A2-A",
      "level": "G-1",
      "element": "RCC Wall",
      "grade": "M-50",
      "cubicMeter": "10",
      "dateOfCasting": "2024-11-05",
      "noOfCube": "9",
      "batchNo": "AA081",
    },
    {
      "projectName": "Sunshine Heights",
      "projectLocation": "Wakad",
      "buildingName": "B1",
      "level": "P2",
      "element": "Footing",
      "grade": "M-30",
      "cubicMeter": "8",
      "dateOfCasting": "2024-10-22",
      "noOfCube": "6",
      "batchNo": "SH12",
    },
    {
      "projectName": "Blue Sky Villas",
      "projectLocation": "Baner",
      "buildingName": "C3",
      "level": "1st Floor",
      "element": "Column",
      "grade": "M-40",
      "cubicMeter": "12",
      "dateOfCasting": "2024-09-15",
      "noOfCube": "12",
      "batchNo": "BSV45",
    },
  ];

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

  final List testResultsTesting = [
    {
      "batchNo": "AA081",
      "noOfCube": "9",
      "dateofTesting": "2024-11-05",
      "gradeof": "M30",
      "dateOfCasting": "2024-11-05",
      "age": "28",
    },
    {
      "batchNo": "AA081",
      "noOfCube": "9",
      "dateofTesting": "2024-11-05",
      "gradeof": "M30",
      "dateOfCasting": "2024-11-05",
      "age": "28",
    },
    {
      "batchNo": "AA081",
      "noOfCube": "9",
      "dateofTesting": "2024-11-05",
      "gradeof": "M30",
      "dateOfCasting": "2024-11-05",
      "age": "28",
    },
  ];
}
