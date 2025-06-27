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

  var cubeCount = 3.obs;

  @override
  void onInit() {
    super.onInit();
    initCubeInputs(cubeCount.value); // Initial count
  }

  void initCubeInputs(int count) {
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
}
