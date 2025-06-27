import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CubeCastingRequestController extends GetxController {
  List<String> dummyNames = [
    'Alice',
    'Bob',
    'Charlie',
    'David',
    'Eve',
    'Frank',
    'Grace',
    'Hannah',
    'Ivy',
    'Jack',
    'Eve',
    'Frank',
    'Grace',
    'Hannah',
    'Ivy',
    'Jack'
  ];

  var selectLevelOfConcerting = ''.obs;
  var selectElement = ''.obs;
  var selectConcertOfGrade = ''.obs;
  var selectProposeDate = ''.obs;

  final TextEditingController dateController = TextEditingController();

  void updateDate(DateTime newDate) {
    dateController.text = DateFormat("yyyy-MM-dd").format(newDate);
  }

  TextEditingController cubicMeterController = TextEditingController();
  FocusNode cubicMeterFocusNode = FocusNode();
  TextEditingController noOfCubeController = TextEditingController();
  FocusNode noOfCubeFocusNode = FocusNode();
  TextEditingController notesController = TextEditingController();
  FocusNode notesFocusNode = FocusNode();
}
