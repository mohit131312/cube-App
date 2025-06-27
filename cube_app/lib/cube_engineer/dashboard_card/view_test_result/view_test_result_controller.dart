import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ViewTestResultController extends GetxController {
  final TextEditingController dateController = TextEditingController();

  void updateDate(DateTime newDate) {
    dateController.text = DateFormat("yyyy-MM-dd").format(newDate);
  }

  final List testResults = [
    {
      "projectName": "PARC RESIDENCIES",
      "dateOfCasting": "04-Aug-2024",
      "testRecordNo": "KAPP/KPD/PD/20-21/0047",
      "batchNo": "FH3",
      "age": "7",
      "dateOfTesting": "11-Aug-2024",
      "scheduleDated": "04-Aug-2024",
      "labAddress":
          "S.No. 214, Bhekarai Nagar, Opp. Shiv Shankar Mangal Karyalaya, Village Fursungi, Pune",
      "status": "Approved"
    },
    {
      "projectName": "SUNSHINE TOWERS",
      "dateOfCasting": "12-Jul-2024",
      "testRecordNo": "KAPP/KPD/PD/20-21/0048",
      "batchNo": "",
      "age": "",
      "dateOfTesting": "",
      "scheduleDated": "",
      "labAddress": "",
      "status": ""
    },
    {
      "projectName": "BLUE SKY HEIGHTS",
      "dateOfCasting": "25-Jun-2024",
      "testRecordNo": "KAPP/KPD/PD/20-21/0049",
      "batchNo": "",
      "age": "",
      "dateOfTesting": "",
      "scheduleDated": "",
      "labAddress": "",
      "status": ""
    },
    {
      "projectName": "",
      "dateOfCasting": "",
      "testRecordNo": "",
      "batchNo": "",
      "age": "",
      "dateOfTesting": "",
      "scheduleDated": "",
      "labAddress": "",
      "status": ""
    },
    {
      "projectName": "SUNSHINE TOWERS",
      "dateOfCasting": "12-Jul-2024",
      "testRecordNo": "KAPP/KPD/PD/20-21/0048",
      "batchNo": "",
      "age": "",
      "dateOfTesting": "",
      "scheduleDated": "",
      "labAddress": "",
      "status": ""
    },
    {
      "projectName": "BLUE SKY HEIGHTS (new address added)",
      "dateOfCasting": "25-Jun-2024",
      "testRecordNo": "KAPP/KPD/PD/20-21/0049",
      "batchNo": "",
      "age": "",
      "dateOfTesting": "",
      "scheduleDated": "",
      "labAddress": "",
      "status": ""
    },
  ];
}
