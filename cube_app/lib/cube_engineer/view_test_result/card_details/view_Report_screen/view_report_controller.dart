import 'package:cube_app/cube_engineer/view_test_result/card_details/card_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewReportController extends GetxController {
  final CardDetailsController cardDetailsController = Get.find();
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
  List<TextEditingController> csAreaControllers = [];
  List<FocusNode> csAreaFocusNodes = [];

  List<TextEditingController> densityControllers = [];
  List<FocusNode> densityFocusNodes = [];

  List<TextEditingController> strengthControllers = [];
  List<FocusNode> strengthFocusNodes = [];

  @override
  void onInit() {
    super.onInit();
    loadData(); // new
  }

  Future<void> loadData() async {
    final count = cardDetailsController.viewDetailstestResult.length;
    initCubeInputs(count);
    prefillDataFromApi();
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

    csAreaControllers = List.generate(count, (_) => TextEditingController());
    csAreaFocusNodes = List.generate(count, (_) => FocusNode());

    densityControllers = List.generate(count, (_) => TextEditingController());
    densityFocusNodes = List.generate(count, (_) => FocusNode());

    strengthControllers = List.generate(count, (_) => TextEditingController());
    strengthFocusNodes = List.generate(count, (_) => FocusNode());
  }

  void prefillDataFromApi() {
    initCubeInputs(cardDetailsController.viewDetailstestResult.length);

    for (int i = 0;
        i < cardDetailsController.viewDetailstestResult.length;
        i++) {
      final result = cardDetailsController.viewDetailstestResult[i];

      lengthControllers[i].text = result.length ?? '';
      widthControllers[i].text = result.width ?? '';
      heightControllers[i].text = result.height ?? '';
      weightControllers[i].text = result.weight ?? '';
      loadControllers[i].text = result.load ?? '';
      csAreaControllers[i].text = result.csArea ?? '';
      densityControllers[i].text = result.density ?? '';
      strengthControllers[i].text = result.compStrenght ?? '';
    }
  }
}
