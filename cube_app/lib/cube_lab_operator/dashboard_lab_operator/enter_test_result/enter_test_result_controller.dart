import 'dart:convert';
import 'dart:developer';

import 'package:cube_app/cube_lab_operator/dashboard_lab_operator/enter_test_result/enter_test_result_model.dart';
import 'package:cube_app/remote_service.dart';
import 'package:cube_app/utils/custome_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EnterTestResultController extends GetxController {
  final TextEditingController dateController = TextEditingController();

  void updateDate(DateTime newDate) {
    dateController.text = DateFormat("yyyy-MM-dd").format(newDate);
  }

  final TextEditingController dateTestingController = TextEditingController();

  void updateTestingDate(DateTime newDate) {
    dateTestingController.text = DateFormat("yyyy-MM-dd").format(newDate);
  }

  TextEditingController batchnoController = TextEditingController();
  FocusNode batchnoFocusNode = FocusNode();
  TextEditingController remarkController = TextEditingController();
  FocusNode remarkFocusNode = FocusNode();

  List<TextEditingController> lengthControllers = [];
  List<FocusNode> lengthFocusNodes = [];

  List<TextEditingController> widthControllers = [];
  List<FocusNode> widthFocusNodes = [];

  List<TextEditingController> heightControllers = [];
  List<FocusNode> heightFocusNodes = [];

  List<TextEditingController> weightControllers = [];
  List<FocusNode> weightFocusNodes = [];

  List<TextEditingController> loadControllers = [];
  List<FocusNode> loadFocusNodes = [];

  var cubeCount = 1.obs;
  var cubeCastingId = 0.obs;
  var cubeReuestingId = 0.obs;
  final formKey = GlobalKey<FormState>();
  final scheduledateFormKey = GlobalKey<FormState>();

  final dateOfTestingFormkey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    initCubeInputs(cubeCount.value); // Initial count
  }

  void initCubeInputs(int count) {
    // Clean up previous ones
    for (var c in lengthControllers) {
      c.dispose();
    }
    for (var c in widthControllers) {
      c.dispose();
    }
    for (var c in heightControllers) {
      c.dispose();
    }
    for (var c in weightControllers) {
      c.dispose();
    }
    for (var c in loadControllers) {
      c.dispose();
    }

    // Re-initialize
    lengthControllers = List.generate(count, (_) => TextEditingController());
    lengthFocusNodes = List.generate(count, (_) => FocusNode());

    widthControllers = List.generate(count, (_) => TextEditingController());
    widthFocusNodes = List.generate(count, (_) => FocusNode());

    heightControllers = List.generate(count, (_) => TextEditingController());
    heightFocusNodes = List.generate(count, (_) => FocusNode());

    weightControllers = List.generate(count, (_) => TextEditingController());
    weightFocusNodes = List.generate(count, (_) => FocusNode());

    loadControllers = List.generate(count, (_) => TextEditingController());
    loadFocusNodes = List.generate(count, (_) => FocusNode());
  }

  RxList<BatchNoMain> batchNoList = <BatchNoMain>[].obs;
  RxString scheduleDate = RxString("");
  var msg = "".obs;
  Future getBacthData(batchNo) async {
    try {
      msg.value = '';
      Map<String, dynamic> map = {"batch_number": batchNo};
      log("map ----$map");

      var response =
          await RemoteServices.postMethodWithToken('search_cube_batch', map);
      log("📥 Raw Response: $response");
      final responseData = jsonDecode(response.body);

      if (responseData.containsKey('token') && responseData['token'] == false) {
        await RemoteServices.handleTokenExpiry();
        return false;
      }
      var project = batchNoFromJson(response.body);
      msg.value = project.message ?? '';

      if (project.data != null) {
        batchNoList.assignAll(project.data!.testingDateList!);
        cubeCastingId.value = project.data!.cubeCastingId!;
        print("batchNoList Count: ${batchNoList.length}");
      } else {
        batchNoList.clear();
        print("No project data found.");
      }
      print('batchNoList Count: ${batchNoList.length}');
      return true;
    } catch (e) {
      print("Error: $e");
      return true;
    }
  }

  var validatemsg = "".obs;
  var requiredError = "".obs;

  Future<bool> saveTestResult(context) async {
    try {
      validatemsg.value = '';
      requiredError.value = '';
      List<Map<String, dynamic>> testResults =
          List.generate(cubeCount.value, (i) {
        return {
          "sr_no": i + 1,
          "length": double.tryParse(lengthControllers[i].text.trim()) ?? 0.0,
          "width": double.tryParse(widthControllers[i].text.trim()) ?? 0.0,
          "height": double.tryParse(heightControllers[i].text.trim()) ?? 0.0,
          "weight": double.tryParse(weightControllers[i].text.trim()) ?? 0.0,
          "load": double.tryParse(loadControllers[i].text.trim()) ?? 0.0,
        };
      });

      print("📦 testResults: ${jsonEncode(testResults)}");

      Map<String, dynamic> payload = {
        "cube_casting_id": cubeCastingId.value,
        "cube_register_id": cubeReuestingId.value,
        "testing_date": dateTestingController.text.trim(),
        "schedule_date": scheduleDate.value.trim(),
        "remark": remarkController.text.trim(),
        "test_result": testResults,
      };

      log("📤 Payload: ${jsonEncode(payload)}");

      var response = await RemoteServices.postMethodWithToken(
        'save_test_result',
        payload,
      );

      log("📥 Save Test Result Response: ${response.body}");

      final responseData = jsonDecode(response.body);

      if (responseData['token'] == false) {
        await RemoteServices.handleTokenExpiry();
        return false;
      }

      if (responseData['status'] == true) {
        validatemsg.value =
            responseData['message'] ?? "Test result saved successfully.";
        return true;
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

      return false;
    } catch (e) {
      log("❌ Error saving test result: $e");
      validatemsg.value = "Unexpected error occurred.";
      return true;
    }
  }

  void clearFormData() {
    batchnoController.clear();
    remarkController.clear();
    dateTestingController.clear();
    scheduleDate.value = "";
    msg.value = "";
    validatemsg.value = "";
    requiredError.value = "";

    cubeCount.value = 1;
    cubeCastingId.value = 0;
    cubeReuestingId.value = 0;

    batchNoList.clear();
    initCubeInputs(1); // Reset to 1 input block
  }
}
