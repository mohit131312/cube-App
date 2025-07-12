import 'dart:convert';
import 'dart:developer';

import 'package:cube_app/cube_engineer/cube_casting_request/models/concerting_model.dart';
import 'package:cube_app/cube_engineer/cube_casting_request/models/concrete_grade__model.dart';
import 'package:cube_app/cube_engineer/cube_casting_request/models/element_model.dart';
import 'package:cube_app/remote_service.dart';
import 'package:cube_app/utils/custome_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CubeCastingRequestController extends GetxController {
  var selectLevelOfConcerting = ''.obs;
  RxnInt selectLevelOfConcertingId = RxnInt();

  GlobalKey concertingKey = GlobalKey();
  GlobalKey elementKey = GlobalKey();
  GlobalKey gradeKey = GlobalKey();
  GlobalKey castingKey = GlobalKey();

  var selectElement = ''.obs;
  RxnInt selectElementId = RxnInt();

  var selectConcertOfGrade = ''.obs;
  RxnInt selectConcertOfGradeId = RxnInt();
  void printSelectedValues() {
    print(
        'Level of Concreting: ${selectLevelOfConcerting.value} (ID: ${selectLevelOfConcertingId.value})');
    print('Element: ${selectElement.value} (ID: ${selectElementId.value})');
    print(
        'Concrete Grade: ${selectConcertOfGrade.value} (ID: ${selectConcertOfGradeId.value})');
  }

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

  ///////-------------------------------
  ///
  RxList<ConcertingLevel> concertingLevelList = <ConcertingLevel>[].obs;

  Future getconcertingLevel(projectId, buildingId) async {
    try {
      Map<String, dynamic> map = {
        "project_id": projectId,
        "building_id": buildingId,
      };

      var response = await RemoteServices.postMethodWithToken(
          'get_cube_concrete_list', map);
      log("📥 Raw Response: $response");
      final responseData = jsonDecode(response.body);

      if (responseData.containsKey('token') && responseData['token'] == false) {
        await RemoteServices.handleTokenExpiry();
        return false;
      }
      var project = concertingModelFromJson(response.body);

      if (project.data != null) {
        concertingLevelList.assignAll(project.data!);
        print("concertingLevelList Count: ${concertingLevelList.length}");
      } else {
        concertingLevelList.clear();
        print("No project data found.");
      }
      print('concertingLevelList Count: ${concertingLevelList.length}');
      return true;
    } catch (e) {
      print("Error: $e");
      return true;
    }
  }

  RxList<ElementList> elementList = <ElementList>[].obs;

  Future getElement() async {
    try {
      Map<String, dynamic> map = {};

      var response =
          await RemoteServices.postMethodWithToken('get_element_list', map);
      log("📥 Raw Response: $response");
      final responseData = jsonDecode(response.body);

      if (responseData.containsKey('token') && responseData['token'] == false) {
        await RemoteServices.handleTokenExpiry();
        return false;
      }
      var project = elementModelFromJson(response.body);

      if (project.data != null) {
        elementList.assignAll(project.data!);
        print("elementList Count: ${elementList.length}");
      } else {
        elementList.clear();
        print("No project data found.");
      }
      print('elementList Count: ${elementList.length}');
      return true;
    } catch (e) {
      print("Error: $e");
      return true;
    }
  }

  //------------------------------
  RxList<ConcreteGrade> concrateGradeList = <ConcreteGrade>[].obs;

  Future getConcreteGrade() async {
    try {
      Map<String, dynamic> map = {};

      var response = await RemoteServices.postMethodWithToken(
          'get_concrete_grade_list', map);
      log("📥 Raw Response: $response");
      final responseData = jsonDecode(response.body);

      if (responseData.containsKey('token') && responseData['token'] == false) {
        await RemoteServices.handleTokenExpiry();
        return false;
      }
      var project = concreteModelFromJson(response.body);

      if (project.data != null) {
        concrateGradeList.assignAll(project.data!);
        print("concrateGradeList Count: ${concrateGradeList.length}");
      } else {
        concrateGradeList.clear();
        print("No project data found.");
      }
      print('concrateGradeList Count: ${concrateGradeList.length}');
      return true;
    } catch (e) {
      print("Error: $e");
      return true;
    }
  }

  //------------------------

  int? calculateCubes(int cubicMeters) {
    final List<Map<String, dynamic>> ranges = [
      {"min": 0, "max": 5, "samples": 2 * 3},
      {"min": 6, "max": 15, "samples": 3 * 3},
      {"min": 16, "max": 30, "samples": 5 * 3},
      {"min": 31, "max": 50, "samples": 6 * 3},
      {"min": 51, "max": 100, "samples": 7 * 3},
      {"min": 101, "max": 150, "samples": 8 * 3},
      {"min": 151, "max": 200, "samples": 9 * 3},
      {"min": 201, "max": 250, "samples": 10 * 3},
      {"min": 251, "max": 300, "samples": 11 * 3},
      {"min": 301, "max": 350, "samples": 12 * 3},
      {"min": 351, "max": 400, "samples": 13 * 3},
      {"min": 401, "max": 450, "samples": 14 * 3},
    ];

    for (var range in ranges) {
      if (cubicMeters >= range['min'] && cubicMeters <= range['max']) {
        return range['samples'];
      }
    }

    return null; // Return null if not in range
  }

//---------------send for approval
  var requiredError = "".obs;
  Future postForApproval(projectId, buildingId, concreteLevelId, elementId,
      gradeId, castingDate, cubicMeter, noOfCubes, note, context) async {
    try {
      requiredError.value = '';
      Map<String, dynamic> map = {
        "project_id": projectId,
        "building_id": buildingId,
        "concrete_level_id": concreteLevelId,
        "element_id": elementId,
        "grade_id": gradeId,
        "proposed_casting_date": castingDate,
        "cubic_meter": cubicMeter,
        "number_of_cubes": noOfCubes,
        "note": note
      };
      log('map ---$map');
      var response =
          await RemoteServices.postMethodWithToken('send_for_approval', map);
      log("📥 Raw Response: $response");
      final responseData = jsonDecode(response.body);

      if (responseData.containsKey('token') && responseData['token'] == false) {
        await RemoteServices.handleTokenExpiry();
        return false;
      }
      if (responseData.containsKey('validation-message')) {
        final validationMap =
            responseData['validation-message'] as Map<String, dynamic>;

        if (validationMap.isNotEmpty) {
          List<String> allMessages = [];

          validationMap.forEach((key, value) {
            if (value is List) {
              allMessages.addAll(value.map((e) => e.toString()));
            }
          });

          requiredError.value = allMessages.join('\n');
        } else {
          requiredError.value = "Validation error occurred.";
        }

        await showDialog(
          context: context,
          builder: (_) => CustomValidationPopup(
            message: requiredError.value,
            icon: Icons.error_outline,
            iconColor: Colors.orange,
            onOk: () {},
          ),
        );

        return false;
      }
      var post = jsonDecode(response.body);

      print('post: ${post}');
      return true;
    } catch (e) {
      print("Error: $e");
      return true;
    }
  }

  //reset functiuon

  Future<void> resetFormData() async {
    selectLevelOfConcerting.value = '';
    selectLevelOfConcertingId.value = null;

    selectElement.value = '';
    selectElementId.value = null;

    selectConcertOfGrade.value = '';
    selectConcertOfGradeId.value = null;

    dateController.clear();

    cubicMeterController.clear();
    noOfCubeController.clear();
    notesController.clear();

    cubicMeterFocusNode.unfocus();
    noOfCubeFocusNode.unfocus();
    notesFocusNode.unfocus();

    print("All data reset.");
  }

  Future<void> resetAllData() async {
    concertingLevelList.clear();
    elementList.clear();
    concrateGradeList.clear();
    await resetFormData();
  }
}
